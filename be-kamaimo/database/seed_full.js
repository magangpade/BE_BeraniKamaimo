const mysql = require('mysql2/promise');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env') });

(async () => {
  try {
    const conn = await mysql.createConnection({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });

    console.log('Connected to MySQL database:', process.env.DB_NAME);

    // 1. desa_wisata: add kategori
    try {
      await conn.query("ALTER TABLE desa_wisata ADD COLUMN kategori VARCHAR(50) DEFAULT 'EKOWISATA'");
      console.log('Added kategori column to desa_wisata');
    } catch (e) {
      if (!e.message.includes('Duplicate column')) console.log('desa_wisata notice:', e.message);
    }

    await conn.query("UPDATE desa_wisata SET kategori = 'BAHARI' WHERE namaDesa_id LIKE '%Paisu Pok%' OR namaDesa_id LIKE '%Togean%' OR namaDesa_id LIKE '%Pulo Dua%'");
    await conn.query("UPDATE desa_wisata SET kategori = 'BUDAYA' WHERE namaDesa_id LIKE '%Bada%'");
    await conn.query("UPDATE desa_wisata SET kategori = 'EKOWISATA' WHERE namaDesa_id LIKE '%Tambing%' OR namaDesa_id LIKE '%Saluopa%'");

    const [existingUmkm] = await conn.query("SELECT id FROM desa_wisata WHERE namaDesa_id LIKE '%Tenun%'");
    if (existingUmkm.length === 0) {
      await conn.query(`
        INSERT INTO desa_wisata
        (namaDesa_id, namaDesa_en, lokasi_id, lokasi_en, deskripsi_id, deskripsi_en, latitude, longitude, jenisDesa, foto, rating, total_ulasan, kategori)
        VALUES
        ('Sentra Tenun & Souvenir Kaili', 'Kaili Weaving & Souvenir Center', 'Donggala', 'Donggala', 'Pusat kerajinan tenun ikat tradisional Donggala dan cinderamata khas Palu.', 'Traditional Donggala ikat weaving and Palu souvenir center.', -0.8912, 119.8654, 'DESA_WISATA', 'assets/images/beranda/thumb_event1.png', 4.80, 520, 'UMKM')
      `);
      console.log('Inserted UMKM destination');
    }

    // 2. hotel: add columns
    const hotelCols = [
      ['wilayah', 'VARCHAR(100) DEFAULT NULL'],
      ['tag', 'VARCHAR(100) DEFAULT NULL'],
      ['rating', 'DECIMAL(3,2) NOT NULL DEFAULT 4.70'],
      ['rating_count', "VARCHAR(20) DEFAULT '100'"],
      ['highlight', 'VARCHAR(100) DEFAULT NULL'],
    ];
    for (const [col, def] of hotelCols) {
      try {
        await conn.query(`ALTER TABLE hotel ADD COLUMN ${col} ${def}`);
        console.log(`Added column ${col} to hotel`);
      } catch (e) {
        if (!e.message.includes('Duplicate column')) console.log(`hotel ${col}:`, e.message);
      }
    }

    const [hRows] = await conn.query('SELECT COUNT(*) as cnt FROM hotel');
    if (hRows[0].cnt === 0) {
      await conn.query(`
        INSERT INTO hotel
        (nama_hotel, telepon, jumlah_kamar, jumlah_tempatTidur, harga_minimum, harga_maximum, website, link_gmaps, lokasi, wilayah, tag, rating, rating_count, highlight, foto)
        VALUES
        ('Swiss–Belhotel Silae Palu', '08114561888', 130, 2, 750000, 1600000, 'https://www.swiss-belhotel.com', 'https://maps.google.com/?q=Swiss-Belhotel+Silae+Palu', 'Teluk Palu, Palu Barat', 'Palu', 'Bintang 4 Resor', 4.70, '1.2k', 'Sea View', 'assets/images/eksplor/hotel1.jpg'),
        ('Tanjung Karang Beach Resort', '08124233211', 58, 2, 480000, 850000, 'https://tanjungkarang.com', 'https://maps.google.com/?q=Tanjung+Karang+Donggala', 'Tanjung Karang, Donggala', 'Donggala', 'Resor Pantai', 4.60, '310', 'Private Beach', 'assets/images/eksplor/hotel2.jpg'),
        ('Luwuk Bay Guest House', '085241098877', 24, 2, 320000, 550000, '', 'https://maps.google.com/?q=Luwuk+Banggai', 'Luwuk Timur, Luwuk', 'Luwuk', 'Guesthouse Pesisir', 4.50, '812', 'Sunset Deck', 'assets/images/eksplor/hotel3.jpg'),
        ('Bukabuka Island Resort', '082188990011', 12, 2, 950000, 1800000, '', 'https://maps.google.com/?q=Pulau+Buka+Buka+Togean', 'Pulau Buka-Buka, Togean', 'Ampana & Togean', 'Island Retreat', 4.90, '96', 'Snorkeling Langsung', 'assets/images/eksplor/hotel4.jpg')
      `);
      console.log('Seeded 4 hotels');
    }

    // 3. kuliner: add columns
    const kulinerCols = [
      ['wilayah', 'VARCHAR(100) DEFAULT NULL'],
      ['warung', 'VARCHAR(180) DEFAULT NULL'],
      ['tag', 'VARCHAR(100) DEFAULT NULL'],
      ['bahan', 'TEXT DEFAULT NULL'],
      ['link_gmaps', 'VARCHAR(500) DEFAULT NULL'],
    ];
    for (const [col, def] of kulinerCols) {
      try {
        await conn.query(`ALTER TABLE kuliner ADD COLUMN ${col} ${def}`);
        console.log(`Added column ${col} to kuliner`);
      } catch (e) {
        if (!e.message.includes('Duplicate column')) console.log(`kuliner ${col}:`, e.message);
      }
    }

    const [kRows] = await conn.query('SELECT COUNT(*) as cnt FROM kuliner');
    if (kRows[0].cnt === 0) {
      await conn.query(`
        INSERT INTO kuliner
        (nama_makanan, lokasi, wilayah, warung, tag, deskripsi_id, bahan, foto, link_gmaps)
        VALUES
        ('Onyop (Kuah Asam Ikan Segar)', 'Palu', 'Palu', 'R.M TINAKU 2 (Khas Kaili)', NULL, 'Kuah asam pedas segar dari asam jawa muda santan, potongan ikan segar, dan cabai rawit hijau — makan siang legendaris pesisir Teluk Palu.', '🌿 Asam Jawa Muda, 🌶️ Cabai Rawit Hijau, 🍠 Singkong Rebus', 'assets/images/eksplor/kuliner1.jpg', 'https://maps.google.com/?q=RM+Tinaku+Palu'),
        ('Kaledo (Kaki Lemboe Asli)', 'Donggala', 'Donggala', 'Kaledo Donggala', 'Legendaris', 'Sup sumsum tulang kaki sapi empuk berkuah asam pedas khas rempah asam jawa mentah (uve kalopo) dan cabai rawit hijau yang disedot langsung dengan sedotan bambu.', '🌿 Asam Jawa Segar, 🌶️ Cabai Rawit Hijau, 🍠 Singkong Rebus', 'assets/images/eksplor/kuliner2.jpg', 'https://maps.google.com/?q=Kaledo+Donggala'),
        ('Lalampa (Ketan Bakar Isi Tuna)', 'Palu', 'Palu', 'Raja Lalampa Toboli', NULL, 'Beras ketan berisi ikan tuna bakar bumbu pedas, dibungkus daun pisang lalu dibakar — jajanan legendaris di jalur Toboli menuju Poso.', '🌾 Beras Ketan, 🐟 Tuna Bumbu, 🌿 Daun Pisang', 'assets/images/eksplor/kuliner3.jpg', 'https://maps.google.com/?q=Toboli+Parigi+Moutong'),
        ('Uta Dada (Kuah Kuning Rempah)', 'Palu', 'Palu', 'R.M Uta Dada Palu', 'Autentik', 'Kuah kuning santan rempah dengan daging empuk dan sayuran khas punuk Kaili — hidangan hangat rumahan paling dicari saat musim hujan.', '🌶️ Kunyit Segar, 🥥 Santan Kental, 🍲 Daging Sapi', 'assets/images/eksplor/kuliner4.jpg', 'https://maps.google.com/?q=RM+Uta+Dada+Palu')
      `);
      console.log('Seeded 4 kuliner');
    }

    // 4. tour_package: add columns
    const tpCols = [
      ['kategori', "VARCHAR(50) DEFAULT 'BAHARI'"],
      ['durasi', 'VARCHAR(50) DEFAULT NULL'],
      ['tipe', 'VARCHAR(50) DEFAULT NULL'],
      ['rating', 'DECIMAL(3,2) NOT NULL DEFAULT 4.80'],
      ['rating_count', 'INT NOT NULL DEFAULT 80'],
      ['fasilitas', 'TEXT DEFAULT NULL'],
    ];
    for (const [col, def] of tpCols) {
      try {
        await conn.query(`ALTER TABLE tour_package ADD COLUMN ${col} ${def}`);
        console.log(`Added column ${col} to tour_package`);
      } catch (e) {
        if (!e.message.includes('Duplicate column')) console.log(`tour_package ${col}:`, e.message);
      }
    }

    const [tpRows] = await conn.query('SELECT COUNT(*) as cnt FROM tour_package');
    if (tpRows[0].cnt === 0) {
      await conn.query(`
        INSERT INTO tour_package
        (nama_wisata_id, lokasi_id, harga, deskripsi_id, kontak, media, kategori, durasi, tipe, rating, rating_count, fasilitas)
        VALUES
        ('Eksotisme Kepulauan Togean', 'Tojo Una-Una', 2850000, 'Berenang bersama ubur-ubur tanpa sengat Danau Mariona, snorkeling di gosong, dan berlabuh di pulau pribadi.', '6281234567890', 'assets/images/paket/paket_togean.png', 'BAHARI', '4 Hari 3 Malam', 'Water Cottage', 4.90, 86, 'Makan Lengkap, Guide HPI Lokal, Perahu Pribadi, Dokumentasi Drone'),
        ('Sombori Secret Paradise', 'Morowali', 350000, 'Laguna toska karst megah, tebing cadas, dan pasir putih Kepulauan Sombori bersama perahu eksklusif.', '6281234567891', 'assets/images/paket/paket_sambori.png', 'BAHARI', '3 Hari 2 Malam', 'Open Trip', 4.95, 54, 'Guide HPI Lokal, Perahu Pribadi, Snorkeling Set, Dokumentasi Drone'),
        ('Misteri Lembah Bada & Megalitikum', 'Poso', 650000, 'Menelusuri patung megalitik seribu tahun, rumah adat, dan tradisi api abadi di Lembah Bada.', '6281234567892', 'assets/images/paket/paket_megalitikum.png', 'BUDAYA', '2 Hari 1 Malam', 'Homestay Desa', 4.80, 112, 'Guide HPI Lokal, Makan Lengkap, Homestay Lokal, Transport Touring')
      `);
      console.log('Seeded 3 tour packages');
    }

    console.log('SUCCESS: All tables migrated and seeded!');
    await conn.end();
  } catch (err) {
    console.error('Migration error:', err);
    process.exit(1);
  }
})();

