const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

async function main() {
  const dbName = process.env.DB_NAME || 'berani_kamaimo';
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    multipleStatements: true,
  });

  console.log(`Resetting and preparing database: ${dbName}...`);
  await conn.query(`DROP DATABASE IF EXISTS \`${dbName}\`;`);
  await conn.query(`CREATE DATABASE \`${dbName}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`);
  await conn.query(`USE \`${dbName}\`;`);

  // 1. Import dberanikamaimobackup_mysql.sql
  const backupPath = path.join(__dirname, '../../dberanikamaimobackup_mysql.sql');
  console.log(`Importing backup file: ${backupPath}...`);
  const backupSql = fs.readFileSync(backupPath, 'utf8');

  await conn.query('SET FOREIGN_KEY_CHECKS = 0;');
  await conn.query(backupSql);
  await conn.query('SET FOREIGN_KEY_CHECKS = 1;');
  console.log('Raw backup data imported successfully!');

  // 2. Adjust ulasan table to support desaId
  await conn.query('ALTER TABLE ulasan ADD COLUMN IF NOT EXISTS desaId INT NULL;');

  // 3. Create backend tables
  console.log('Creating backend tables (desa_wisata, atraksi, admin_user, etc.)...');
  await conn.query(`
    CREATE TABLE IF NOT EXISTS admin_user (
      id INT AUTO_INCREMENT PRIMARY KEY,
      nama_Lengkap VARCHAR(150) NOT NULL,
      username VARCHAR(80) NOT NULL UNIQUE,
      password VARCHAR(255) NOT NULL,
      jenis_kelamin ENUM('L','P') NOT NULL DEFAULT 'L',
      role ENUM('Admin','superAdmin') NOT NULL DEFAULT 'Admin',
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS desa_wisata (
      id INT AUTO_INCREMENT PRIMARY KEY,
      namaDesa_id VARCHAR(180) NOT NULL,
      namaDesa_en VARCHAR(180),
      lokasi_id VARCHAR(180) NOT NULL,
      lokasi_en VARCHAR(180),
      deskripsi_id TEXT NOT NULL,
      deskripsi_en TEXT,
      latitude DECIMAL(10,7) NOT NULL,
      longitude DECIMAL(10,7) NOT NULL,
      jenisDesa ENUM('DESA_WISATA','DESA_UNGGULAN') NOT NULL DEFAULT 'DESA_WISATA',
      kategori VARCHAR(50) DEFAULT 'EKOWISATA',
      foto VARCHAR(255),
      link_video VARCHAR(500),
      rating DECIMAL(3,2) NOT NULL DEFAULT 4.50,
      total_ulasan INT NOT NULL DEFAULT 0,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      INDEX idx_lokasi (lokasi_id),
      INDEX idx_jenis (jenisDesa),
      INDEX idx_coord (latitude, longitude)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS atraksi (
      id INT AUTO_INCREMENT PRIMARY KEY,
      nameEvent VARCHAR(200) NOT NULL,
      location_id VARCHAR(180) NOT NULL,
      location_en VARCHAR(180),
      description_id TEXT NOT NULL,
      description_en TEXT,
      startdate DATE NOT NULL,
      enddate DATE NOT NULL,
      kategori ENUM('BUDAYA','BAHARI','UMKM','EKOWISATA') NOT NULL DEFAULT 'BUDAYA',
      wilayah VARCHAR(100),
      harga INT NULL,
      rating DECIMAL(3,2) NOT NULL DEFAULT 4.70,
      rating_count INT NOT NULL DEFAULT 0,
      foto VARCHAR(255),
      link_video VARCHAR(500),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      INDEX idx_tanggal (startdate, enddate),
      INDEX idx_kategori (kategori)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS jarak_desa (
      id INT AUTO_INCREMENT PRIMARY KEY,
      desaId INT NOT NULL,
      titikKota ENUM('PALU','LUWUK') NOT NULL,
      jalur_darat TEXT NOT NULL,
      jalur_laut TEXT NOT NULL,
      jalur_udara TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      INDEX idx_desa (desaId)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS rumah_makan (
      id INT AUTO_INCREMENT PRIMARY KEY,
      resto VARCHAR(180) NOT NULL,
      kulinerId INT NOT NULL,
      link_gmaps VARCHAR(500) NOT NULL,
      link_video VARCHAR(500),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      INDEX idx_kuliner (kulinerId)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS tour_package (
      id INT AUTO_INCREMENT PRIMARY KEY,
      nama_wisata_id VARCHAR(180) NOT NULL,
      nama_wisata_en VARCHAR(180),
      harga INT NOT NULL,
      deskripsi_id TEXT NOT NULL,
      deskripsi_en TEXT,
      lokasi_id VARCHAR(180) NOT NULL,
      lokasi_en VARCHAR(180),
      kontak VARCHAR(100) NOT NULL,
      media VARCHAR(255),
      link_video VARCHAR(500),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS event_rating (
      id BIGINT AUTO_INCREMENT PRIMARY KEY,
      event_key VARCHAR(120) NOT NULL,
      visitor_key CHAR(36) NOT NULL,
      rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      UNIQUE KEY uq_event_visitor (event_key, visitor_key),
      INDEX idx_event_rating (event_key)
    ) ENGINE=InnoDB;

    CREATE TABLE IF NOT EXISTS kunjungan_turis (
      id INT AUTO_INCREMENT PRIMARY KEY,
      negara VARCHAR(100) NOT NULL,
      jumlah INT NOT NULL DEFAULT 0,
      createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      INDEX idx_negara (negara)
    ) ENGINE=InnoDB;
  `);

  // 4. Sync data from backup tables into backend tables
  console.log('Syncing desawisata -> desa_wisata...');
  await conn.query(`
    INSERT INTO desa_wisata (
      id, namaDesa_id, namaDesa_en, lokasi_id, lokasi_en,
      deskripsi_id, deskripsi_en, latitude, longitude, jenisDesa, foto, link_video
    )
    SELECT
      id, namaDesa_id, namaDesa_en, lokasi_id, lokasi_en,
      deskripsi_id, deskripsi_en, CAST(latitude AS DECIMAL(10,7)), CAST(longitude AS DECIMAL(10,7)),
      CASE WHEN UPPER(jenisDesa) LIKE '%UNGGULAN%' THEN 'DESA_UNGGULAN' ELSE 'DESA_WISATA' END,
      foto, link_video
    FROM desawisata
    ON DUPLICATE KEY UPDATE
      namaDesa_id = VALUES(namaDesa_id),
      namaDesa_en = VALUES(namaDesa_en),
      lokasi_id = VALUES(lokasi_id),
      lokasi_en = VALUES(lokasi_en),
      deskripsi_id = VALUES(deskripsi_id),
      deskripsi_en = VALUES(deskripsi_en),
      latitude = VALUES(latitude),
      longitude = VALUES(longitude),
      jenisDesa = VALUES(jenisDesa),
      foto = VALUES(foto),
      link_video = VALUES(link_video);
  `);

  console.log('Syncing event -> atraksi...');
  await conn.query(`
    INSERT INTO atraksi (
      id, nameEvent, location_id, location_en, description_id, description_en,
      foto, startdate, enddate, link_video
    )
    SELECT
      id, nameEvent, location_id, location_en, description_id, description_en,
      foto, DATE(startdate), DATE(enddate), link_video
    FROM event
    ON DUPLICATE KEY UPDATE
      nameEvent = VALUES(nameEvent),
      location_id = VALUES(location_id),
      location_en = VALUES(location_en),
      description_id = VALUES(description_id),
      description_en = VALUES(description_en),
      foto = VALUES(foto),
      startdate = VALUES(startdate),
      enddate = VALUES(enddate),
      link_video = VALUES(link_video);
  `);

  console.log('Syncing jarakdesa -> jarak_desa...');
  await conn.query(`
    INSERT INTO jarak_desa (id, desaId, titikKota, jalur_laut, jalur_darat, jalur_udara)
    SELECT id, desaId, titikKota, jalur_laut, jalur_darat, jalur_udara
    FROM jarakdesa
    ON DUPLICATE KEY UPDATE
      titikKota = VALUES(titikKota),
      jalur_laut = VALUES(jalur_laut),
      jalur_darat = VALUES(jalur_darat),
      jalur_udara = VALUES(jalur_udara);
  `);

  console.log('Syncing rumahmakan -> rumah_makan...');
  await conn.query(`
    INSERT INTO rumah_makan (id, resto, kulinerId, link_gmaps, link_video)
    SELECT id, resto, kulinerId, link_gmaps, link_video
    FROM rumahmakan
    ON DUPLICATE KEY UPDATE
      resto = VALUES(resto),
      kulinerId = VALUES(kulinerId),
      link_gmaps = VALUES(link_gmaps),
      link_video = VALUES(link_video);
  `);

  console.log('Syncing tourpackage -> tour_package...');
  await conn.query(`
    INSERT INTO tour_package (
      id, nama_wisata_id, nama_wisata_en, harga, deskripsi_id, deskripsi_en,
      kontak, media, lokasi_id, lokasi_en, link_video
    )
    SELECT
      id, nama_wisata_id, nama_wisata_en, CAST(harga AS SIGNED), deskripsi_id, deskripsi_en,
      kontak, media, lokasi_id, lokasi_en, link_video
    FROM tourpackage
    ON DUPLICATE KEY UPDATE
      nama_wisata_id = VALUES(nama_wisata_id),
      nama_wisata_en = VALUES(nama_wisata_en),
      harga = VALUES(harga),
      deskripsi_id = VALUES(deskripsi_id),
      deskripsi_en = VALUES(deskripsi_en),
      kontak = VALUES(kontak),
      media = VALUES(media),
      lokasi_id = VALUES(lokasi_id),
      lokasi_en = VALUES(lokasi_en),
      link_video = VALUES(link_video);
  `);

  console.log('Syncing user -> admin_user...');
  await conn.query(`
    INSERT INTO admin_user (id, nama_Lengkap, username, password, jenis_kelamin, role)
    SELECT
      id, nama_Lengkap, username, password,
      CASE WHEN jenis_kelamin LIKE '%P%' THEN 'P' ELSE 'L' END,
      CASE WHEN role = 'superAdmin' THEN 'superAdmin' ELSE 'Admin' END
    FROM user
    ON DUPLICATE KEY UPDATE
      nama_Lengkap = VALUES(nama_Lengkap),
      password = VALUES(password),
      jenis_kelamin = VALUES(jenis_kelamin),
      role = VALUES(role);
  `);

  // Superadmin fallback
  await conn.query(`
    INSERT INTO admin_user (nama_Lengkap, username, password, jenis_kelamin, role)
    VALUES (
      'Super Admin Kamaimo',
      'superadmin',
      '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
      'L',
      'superAdmin'
    ) ON DUPLICATE KEY UPDATE username = username;
  `);

  // 5. Augment hotel and kuliner tables with frontend-compatible columns if needed
  console.log('Augmenting hotel table columns...');
  const hotelCols = [
    "ALTER TABLE hotel ADD COLUMN IF NOT EXISTS wilayah VARCHAR(100) DEFAULT NULL",
    "ALTER TABLE hotel ADD COLUMN IF NOT EXISTS tag VARCHAR(100) DEFAULT NULL",
    "ALTER TABLE hotel ADD COLUMN IF NOT EXISTS rating DECIMAL(3,2) NOT NULL DEFAULT 4.70",
    "ALTER TABLE hotel ADD COLUMN IF NOT EXISTS rating_count VARCHAR(20) DEFAULT '100'",
    "ALTER TABLE hotel ADD COLUMN IF NOT EXISTS highlight VARCHAR(100) DEFAULT NULL",
  ];
  for (const q of hotelCols) {
    try { await conn.query(q); } catch (e) { /* ignore duplicate */ }
  }

  console.log('Augmenting kuliner table columns...');
  const kulinerCols = [
    "ALTER TABLE kuliner ADD COLUMN IF NOT EXISTS wilayah VARCHAR(100) DEFAULT NULL",
    "ALTER TABLE kuliner ADD COLUMN IF NOT EXISTS warung VARCHAR(100) DEFAULT NULL",
    "ALTER TABLE kuliner ADD COLUMN IF NOT EXISTS tag VARCHAR(100) DEFAULT NULL",
    "ALTER TABLE kuliner ADD COLUMN IF NOT EXISTS bahan TEXT DEFAULT NULL",
    "ALTER TABLE kuliner ADD COLUMN IF NOT EXISTS link_gmaps VARCHAR(500) DEFAULT NULL",
  ];
  for (const q of kulinerCols) {
    try { await conn.query(q); } catch (e) { /* ignore duplicate */ }
  }

  console.log('Augmenting tour_package table columns...');
  const tourCols = [
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS kategori VARCHAR(50) DEFAULT 'EKOWISATA'",
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS durasi VARCHAR(50) DEFAULT '1 Hari'",
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS tipe VARCHAR(50) DEFAULT 'Open Trip'",
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS rating DECIMAL(3,2) NOT NULL DEFAULT 4.80",
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS rating_count VARCHAR(20) DEFAULT '50+'",
    "ALTER TABLE tour_package ADD COLUMN IF NOT EXISTS fasilitas TEXT DEFAULT NULL",
  ];
  for (const q of tourCols) {
    try { await conn.query(q); } catch (e) { /* ignore duplicate */ }
  }

  // 6. Update categories & tags
  await conn.query("UPDATE desa_wisata SET kategori = 'BAHARI' WHERE namaDesa_id LIKE '%Paisu Pok%' OR namaDesa_id LIKE '%Togean%' OR namaDesa_id LIKE '%Pulo Dua%'");
  await conn.query("UPDATE desa_wisata SET kategori = 'BUDAYA' WHERE namaDesa_id LIKE '%Bada%'");
  await conn.query("UPDATE desa_wisata SET kategori = 'EKOWISATA' WHERE namaDesa_id LIKE '%Tambing%' OR namaDesa_id LIKE '%Saluopa%'");

  // Populate kunjungan_turis sample data if empty
  const [[{ ktCount }]] = await conn.query('SELECT COUNT(*) AS ktCount FROM kunjungan_turis');
  if (ktCount === 0) {
    await conn.query(`
      INSERT INTO kunjungan_turis (negara, jumlah) VALUES
      ('Prancis', 8420), ('Jerman', 6150), ('Belanda', 5230), ('Australia', 4890),
      ('Inggris', 3940), ('Amerika Serikat', 3410), ('Jepang', 2980), ('Singapura', 2650),
      ('Malaysia', 2140), ('China', 1980);
    `);
  }

  // Link ulasan to desa_wisata if possible
  const [[firstDesa]] = await conn.query('SELECT id FROM desa_wisata LIMIT 1');
  if (firstDesa) {
    await conn.query('UPDATE ulasan SET desaId = ? WHERE desaId IS NULL', [firstDesa.id]);
  }

  // Summary counts
  console.log('--- DATA MIGRATION SUMMARY ---');
  const tables = [
    'desa_wisata', 'atraksi', 'hotel', 'kuliner', 'rumah_makan',
    'tour_package', 'jarak_desa', 'admin_user', 'ulasan', 'visitor', 'pageview', 'kunjungan_turis'
  ];
  for (const t of tables) {
    const [[{ c }]] = await conn.query(`SELECT COUNT(*) AS c FROM \`${t}\``);
    console.log(`  ${t.padEnd(16)}: ${c} records`);
  }

  console.log('SUCCESS: Database successfully updated with backup data!');
  await conn.end();
}

main().catch(err => {
  console.error('Migration failed:', err);
  process.exit(1);
});
