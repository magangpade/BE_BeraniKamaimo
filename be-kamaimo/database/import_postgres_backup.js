const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

function parseCopyBlock(sql, tableName) {
  const regex = new RegExp(`COPY public\\."?${tableName}"?\\s*\\(([^\\)]+)\\)\\s*FROM stdin;([\\s\\S]*?)\\\\\\.[\\r\\n]`, 'i');
  const match = sql.match(regex);
  if (!match) return { columns: [], rows: [] };
  
  const columns = match[1].split(',').map(c => c.trim().replace(/^"|"$/g, ''));
  const rawRows = match[2].trim().split(/\r?\n/).filter(r => r.length > 0);
  
  const rows = rawRows.map(line => {
    return line.split('\t').map(val => {
      val = val.trim();
      if (val === '\\N' || val === '') return null;
      // unescape \n, \r, \t
      return val.replace(/\\n/g, '\n').replace(/\\r/g, '\r').replace(/\\t/g, '\t');
    });
  });
  
  return { columns, rows };
}

async function main() {
  const dbName = process.argv[2] || process.env.TARGET_DB || process.env.DB_NAME || process.env.MYSQLDATABASE || 'berani_kamaimo';
  const conn = await mysql.createConnection({
    host: process.env.TARGET_HOST || process.env.DB_HOST || process.env.MYSQLHOST || '127.0.0.1',
    port: parseInt(process.env.TARGET_PORT || process.env.DB_PORT || process.env.MYSQLPORT || '3306', 10),
    user: process.env.TARGET_USER || process.env.DB_USER || process.env.MYSQLUSER || 'root',
    password: process.env.TARGET_PASSWORD || process.env.DB_PASSWORD || process.env.MYSQLPASSWORD || '',
    multipleStatements: true,
  });

  console.log(`Connecting to database: ${dbName}...`);
  try {
    await conn.query(`CREATE DATABASE IF NOT EXISTS \`${dbName}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`);
  } catch (e) {
    console.log('Notice: ' + e.message);
  }
  await conn.query(`USE \`${dbName}\`;`);
  await conn.query('SET FOREIGN_KEY_CHECKS = 0;');
  const [existingTables] = await conn.query('SHOW TABLES');
  for (let t of existingTables) {
    const tName = Object.values(t)[0];
    await conn.query(`DROP TABLE IF EXISTS \`${tName}\``);
  }

  // Read schema.sql
  const schemaPath = path.join(__dirname, 'schema.sql');
  const schemaSql = fs.readFileSync(schemaPath, 'utf8');
  console.log('Creating database schema from schema.sql...');
  await conn.query('SET FOREIGN_KEY_CHECKS = 0;');
  await conn.query(schemaSql);

  // Read backup_pariwisata.sql
  const backupPath = path.join(__dirname, 'backup_pariwisata.sql');
  console.log(`Reading PostgreSQL dump: ${backupPath}...`);
  const backupSql = fs.readFileSync(backupPath, 'utf8');

  // 1. desaWisata
  console.log('Importing desa_wisata...');
  const desaData = parseCopyBlock(backupSql, 'desaWisata');
  for (const r of desaData.rows) {
    const obj = {};
    desaData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO desa_wisata (
        id, namaDesa_id, namaDesa_en, deskripsi_id, deskripsi_en,
        lokasi_id, lokasi_en, foto, longitude, latitude, jenisDesa, link_video
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE namaDesa_id = VALUES(namaDesa_id)`,
      [
        obj.id, obj.namaDesa_id, obj.namaDesa_en, obj.deskripsi_id, obj.deskripsi_en,
        obj.lokasi_id, obj.lokasi_en, obj.foto,
        parseFloat(obj.longitude) || 0, parseFloat(obj.latitude) || 0,
        obj.jenisDesa?.toUpperCase().includes('UNGGULAN') ? 'DESA_UNGGULAN' : 'DESA_WISATA',
        obj.link_video || ''
      ]
    );
  }
  console.log(`  -> ${desaData.rows.length} desa_wisata imported.`);

  // 2. Event -> atraksi
  console.log('Importing Event -> atraksi...');
  const eventData = parseCopyBlock(backupSql, 'Event');
  for (const r of eventData.rows) {
    const obj = {};
    eventData.columns.forEach((c, idx) => obj[c] = r[idx]);
    const startDate = obj.startdate ? obj.startdate.split(' ')[0] : '2026-01-01';
    const endDate = obj.enddate ? obj.enddate.split(' ')[0] : startDate;
    await conn.query(
      `INSERT INTO atraksi (
        id, nameEvent, location_id, location_en, description_id, description_en,
        foto, startdate, enddate, link_video
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE nameEvent = VALUES(nameEvent)`,
      [
        obj.id, obj.nameEvent, obj.location_id, obj.location_en, obj.description_id, obj.description_en,
        obj.foto, startDate, endDate, obj.link_video || ''
      ]
    );
  }
  console.log(`  -> ${eventData.rows.length} atraksi imported.`);

  // 3. Hotel
  console.log('Importing Hotel...');
  const hotelData = parseCopyBlock(backupSql, 'Hotel');
  for (const r of hotelData.rows) {
    const obj = {};
    hotelData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO hotel (
        id, nama_hotel, foto, telepon, jumlah_kamar, jumlah_tempatTidur,
        website, link_gmaps, lokasi, link_video, harga_maximum, harga_minimum
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE nama_hotel = VALUES(nama_hotel)`,
      [
        obj.id, obj.nama_hotel, obj.foto, obj.telepon || '', obj.jumlah_kamar || '', obj.jumlah_tempatTidur || '',
        obj.website || '', obj.link_gmaps || '', obj.lokasi || '', obj.link_video || '',
        obj.harga_maximum ? parseInt(obj.harga_maximum.replace(/\D/g, '')) || 0 : 0,
        obj.harga_minimum ? parseInt(obj.harga_minimum.replace(/\D/g, '')) || 0 : 0
      ]
    );
  }
  console.log(`  -> ${hotelData.rows.length} hotel imported.`);

  // 4. Kuliner
  console.log('Importing Kuliner...');
  const kulinerData = parseCopyBlock(backupSql, 'Kuliner');
  for (const r of kulinerData.rows) {
    const obj = {};
    kulinerData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO kuliner (
        id, nama_makanan, foto, deskripsi_id, deskripsi_en, lokasi, link_video
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE nama_makanan = VALUES(nama_makanan)`,
      [
        obj.id, obj.nama_makanan, obj.foto, obj.deskripsi_id, obj.deskripsi_en,
        obj.lokasi, obj.link_video || ''
      ]
    );
  }
  console.log(`  -> ${kulinerData.rows.length} kuliner imported.`);

  // 5. RumahMakan
  console.log('Importing RumahMakan...');
  const rmData = parseCopyBlock(backupSql, 'RumahMakan');
  for (const r of rmData.rows) {
    const obj = {};
    rmData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO rumah_makan (
        id, resto, kulinerId, link_gmaps, link_video
      ) VALUES (?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE resto = VALUES(resto)`,
      [
        obj.id, obj.resto || 'Rumah Makan', parseInt(obj.kulinerId) || 1, obj.link_gmaps || '', obj.link_video || ''
      ]
    );
  }
  console.log(`  -> ${rmData.rows.length} rumah_makan imported.`);

  // 6. TourPackage
  console.log('Importing TourPackage...');
  const tourData = parseCopyBlock(backupSql, 'TourPackage');
  for (const r of tourData.rows) {
    const obj = {};
    tourData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO tour_package (
        id, nama_wisata_id, nama_wisata_en, harga, deskripsi_id, deskripsi_en,
        kontak, media, lokasi_id, lokasi_en, link_video
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE nama_wisata_id = VALUES(nama_wisata_id)`,
      [
        obj.id, obj.nama_wisata_id, obj.nama_wisata_en,
        parseInt(obj.harga?.replace(/\D/g, '')) || 0,
        obj.deskripsi_id, obj.deskripsi_en, obj.kontak || '',
        obj.media || '', obj.lokasi_id || '', obj.lokasi_en || '', obj.link_video || ''
      ]
    );
  }
  console.log(`  -> ${tourData.rows.length} tour_package imported.`);

  // 7. jarakDesa
  console.log('Importing jarakDesa...');
  const jarakData = parseCopyBlock(backupSql, 'jarakDesa');
  for (const r of jarakData.rows) {
    const obj = {};
    jarakData.columns.forEach((c, idx) => obj[c] = r[idx]);
    await conn.query(
      `INSERT INTO jarak_desa (
        id, desaId, titikKota, jalur_laut, jalur_darat, jalur_udara
      ) VALUES (?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE titikKota = VALUES(titikKota)`,
      [
        obj.id, parseInt(obj.desaId) || 1,
        obj.titikKota?.toUpperCase().includes('LUWUK') ? 'LUWUK' : 'PALU',
        obj.jalur_laut || '-', obj.jalur_darat || '-', obj.jalur_udara || '-'
      ]
    );
  }
  console.log(`  -> ${jarakData.rows.length} jarak_desa imported.`);

  // 8. User (Superadmin check)
  console.log('Importing User...');
  const userData = parseCopyBlock(backupSql, 'User');
  for (const r of userData.rows) {
    const obj = {};
    userData.columns.forEach((c, idx) => obj[c] = r[idx]);
    // if superadmin, use verified bcrypt hash for admin123
    const isSuperAdmin = obj.username === 'superadmin' || obj.role === 'superAdmin';
    const pwd = isSuperAdmin 
      ? '$2b$10$8vNDxnIx9mjjMnrJHbfDFORCuyA4/1VnTeiWJU8CJA5BuFAjAOxL.' // admin123
      : obj.password;
    await conn.query(
      `INSERT INTO admin_user (
        id, nama_Lengkap, username, password, jenis_kelamin, role
      ) VALUES (?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE role = VALUES(role), password = VALUES(password)`,
      [
        obj.id, obj.nama_Lengkap || 'Admin', obj.username, pwd,
        obj.jenis_kelamin?.toUpperCase().includes('P') ? 'P' : 'L',
        isSuperAdmin ? 'superAdmin' : 'Admin'
      ]
    );
  }
  console.log(`  -> ${userData.rows.length} users imported.`);

  // 9. PageView & Visitor
  console.log('Importing pageView & Visitor summary...');
  const pvData = parseCopyBlock(backupSql, 'pageView');
  console.log(`  -> Total pageView records in backup: ${pvData.rows.length}.`);

  console.log('\n==========================================');
  console.log('DATABASE RESTORE AND MIGRATION SUCCESSFUL!');
  console.log('==========================================');
  await conn.query('SET FOREIGN_KEY_CHECKS = 1;');
  await conn.end();
}

main().catch(err => {
  console.error('Fatal error during import:', err);
  process.exit(1);
});
