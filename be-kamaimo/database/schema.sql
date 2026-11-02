-- =====================================================
-- DATABASE BERANI KAMAIMO
-- MySQL 8.x
-- =====================================================
CREATE DATABASE IF NOT EXISTS berani_kamaimo
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE berani_kamaimo;

-- =====================================================
-- 1. ADMIN USER
-- =====================================================
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

-- Seed superadmin (password: admin123)
INSERT INTO admin_user (nama_Lengkap, username, password, jenis_kelamin, role)
VALUES (
  'Super Admin Kamaimo',
  'superadmin',
  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
  'L',
  'superAdmin'
) ON DUPLICATE KEY UPDATE username = username;

-- =====================================================
-- 2. DESA WISATA
-- =====================================================
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

-- =====================================================
-- 3. ATRAKSI (EVENT)
-- =====================================================
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

-- =====================================================
-- 4. JARAK DESA (akses ke desa)
-- =====================================================
CREATE TABLE IF NOT EXISTS jarak_desa (
  id INT AUTO_INCREMENT PRIMARY KEY,
  desaId INT NOT NULL,
  titikKota ENUM('PALU','LUWUK') NOT NULL,
  jalur_darat TEXT NOT NULL,
  jalur_laut TEXT NOT NULL,
  jalur_udara TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_jarak_desa FOREIGN KEY (desaId)
    REFERENCES desa_wisata(id) ON DELETE CASCADE,
  INDEX idx_desa (desaId)
) ENGINE=InnoDB;

-- =====================================================
-- 5. KULINER
-- =====================================================
CREATE TABLE IF NOT EXISTS kuliner (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_makanan VARCHAR(180) NOT NULL,
  lokasi VARCHAR(180) NOT NULL,
  deskripsi_id TEXT NOT NULL,
  deskripsi_en TEXT,
  foto VARCHAR(255),
  link_video VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================
-- 6. RUMAH MAKAN
-- =====================================================
CREATE TABLE IF NOT EXISTS rumah_makan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  resto VARCHAR(180) NOT NULL,
  kulinerId INT NOT NULL,
  link_gmaps VARCHAR(500) NOT NULL,
  link_video VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rm_kuliner FOREIGN KEY (kulinerId)
    REFERENCES kuliner(id) ON DELETE CASCADE,
  INDEX idx_kuliner (kulinerId)
) ENGINE=InnoDB;

-- =====================================================
-- 7. HOTEL
-- =====================================================
CREATE TABLE IF NOT EXISTS hotel (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nama_hotel VARCHAR(180) NOT NULL,
  telepon VARCHAR(30) NOT NULL,
  jumlah_kamar INT NOT NULL DEFAULT 0,
  jumlah_tempatTidur INT NOT NULL DEFAULT 0,
  harga_minimum INT NOT NULL DEFAULT 0,
  harga_maximum INT NOT NULL DEFAULT 0,
  website VARCHAR(255),
  link_gmaps VARCHAR(500),
  lokasi VARCHAR(180) NOT NULL,
  foto VARCHAR(255),
  link_video VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================
-- 8. TOUR PACKAGE
-- =====================================================
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

-- =====================================================
-- 9. ULASAN
-- =====================================================
CREATE TABLE IF NOT EXISTS ulasan (
  id INT AUTO_INCREMENT PRIMARY KEY,
  desaId INT NULL,
  nama VARCHAR(120) NOT NULL,
  rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  komentar TEXT NOT NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_ulasan_desa FOREIGN KEY (desaId)
    REFERENCES desa_wisata(id) ON DELETE SET NULL,
  INDEX idx_desa (desaId)
) ENGINE=InnoDB;

-- =====================================================
-- 10. VISITOR (tracking)
-- =====================================================
CREATE TABLE IF NOT EXISTS visitor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  uid VARCHAR(100) NOT NULL UNIQUE,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pageview (
  id INT AUTO_INCREMENT PRIMARY KEY,
  page VARCHAR(255) NOT NULL,
  visitorId INT NOT NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pv_visitor FOREIGN KEY (visitorId)
    REFERENCES visitor(id) ON DELETE CASCADE,
  INDEX idx_page (page)
) ENGINE=InnoDB;

-- =====================================================
-- 11. KUNJUNGAN TURIS (ranking asal negara)
-- =====================================================
CREATE TABLE IF NOT EXISTS kunjungan_turis (
  id INT AUTO_INCREMENT PRIMARY KEY,
  negara VARCHAR(100) NOT NULL,
  jumlah INT NOT NULL DEFAULT 0,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_negara (negara)
) ENGINE=InnoDB;

-- =====================================================
-- SEED DATA (contoh — biar UI langsung terisi)
-- =====================================================
INSERT INTO desa_wisata
(namaDesa_id, namaDesa_en, lokasi_id, lokasi_en, deskripsi_id, deskripsi_en,
 latitude, longitude, jenisDesa, foto, rating, total_ulasan)
VALUES
('Luk Panenteng & Danau Paisu Pok','Luk Panenteng & Lake Paisu Pok',
 'Banggai Kepulauan','Banggai Islands',
 'Air sebening kaca dengan vegetasi hutan yang masih alami—ikon tersembunyi di Kepulauan Banggai.',
 'Crystal-clear water with pristine forest vegetation—a hidden icon of the Banggai Islands.',
 -1.3275000, 123.4627000, 'DESA_UNGGULAN',
 'assets/images/destinasi/feat_luk_panenteng.png', 4.90, 1400),
('Kepulauan Togean','Togean Islands','Tojo Una-Una','Tojo Una-Una',
 'Laguna jernih, terumbu karang, dan pulau sunyi dalam satu gugusan.',
 'Clear lagoons, coral reefs, and quiet islands in one archipelago.',
 -0.3833000, 121.9500000, 'DESA_WISATA',
 'assets/images/destinasi/card_togean.png', 4.90, 2300),
('Danau Tambing','Lake Tambing','Poso','Poso',
 'Danau pegunungan sejuk di jantung Taman Nasional Lore Lindu.',
 'A cool mountain lake in the heart of Lore Lindu National Park.',
 -1.3500000, 120.0833000, 'DESA_WISATA',
 'assets/images/destinasi/card_tambing.png', 4.80, 890),
('Air Terjun Saluopa','Saluopa Waterfall','Poso','Poso',
 'Dua belas tingkat air terjun alami dengan jalur teduh yang mudah dijelajahi.',
 'Twelve tiers of natural waterfalls with a shaded, easy-to-explore trail.',
 -1.4500000, 120.2500000, 'DESA_WISATA',
 'assets/images/destinasi/card_saluopa.png', 4.80, 870),
('Lembah Bada','Bada Valley','Lore Selatan, Poso','South Lore, Poso',
 'Bentang lembah megah dengan arca batu purba berusia ribuan tahun.',
 'A majestic valley with ancient stone statues thousands of years old.',
 -1.8500000, 120.1667000, 'DESA_WISATA',
 'assets/images/destinasi/card_bada.png', 4.70, 1200),
('Pulo Dua Balantak','Pulo Dua Balantak','Banggai','Banggai',
 'Perbukitan karst ikonik bertemu laut biru di ujung timur Sulawesi.',
 'Iconic karst hills meet the blue sea at the eastern tip of Sulawesi.',
 -1.1167000, 123.4500000, 'DESA_WISATA',
 'assets/images/destinasi/card_pulo_dua.png', 4.90, 950);

INSERT INTO jarak_desa (desaId, titikKota, jalur_darat, jalur_laut, jalur_udara) VALUES
(1, 'LUWUK',
 'Perjalanan darat aspal pesisir menyusuri bukit karst dengan mobil rental atau ojek lokal Salakan langsung ke gapura danau.',
 'Berangkat dari Pelabuhan Rakyat Luwuk setiap pagi menuju Pelabuhan Salakan (Banggai Kepulauan) pukul 09:00 WITA.',
 'Penerbangan reguler terjadwal dari Makassar (UPG) atau Manado (MDC) menuju Bandara Luwuk (Wings Air / Batik Air).'),
(1, 'PALU',
 'Perjalanan darat trans-Sulawesi dari Palu menuju Luwuk dengan bus malam ±10–12 jam, dilanjutkan feri ke Salakan dan mobil ke desa.',
 'Ferri reguler dari Pelabuhan Pantoloan (Palu) menuju Luwuk dengan jadwal tidak harian — cek jadwal terbaru sebelum berangkat.',
 'Penerbangan dari Palu (PLW) umumnya transit Makassar (UPG) atau Manado (MDC) menuju Bandara Luwuk.');

INSERT INTO atraksi
(nameEvent, location_id, description_id, startdate, enddate, kategori, wilayah,
 harga, rating, rating_count, foto)
VALUES
('Festival Danau Poso ke-24','Tentena, Poso',
 'Parade budaya, tari mogele, & lomba perahu naga di tepian Danau Poso.',
 '2026-10-24','2026-10-26','BUDAYA','Poso', NULL, 4.50, 1200,
 'assets/images/beranda/thumb_event1.png'),
('Pasar Kreatif Sulteng','Taman GOR, Palu',
 'Kriya lokal, kuliner khas, dan musik senja.',
 '2026-10-31','2026-11-01','UMKM','Palu', NULL, 4.70, 11000,
 'assets/images/beranda/thumb_event1.png'),
('Festival Teluk Tomini (FTT)','Banggai Moutong',
 'Karnaval bahari & expo UMKM di tepi teluk.',
 '2026-11-18','2026-11-20','BAHARI','Banggai', NULL, 4.70, 1100,
 'assets/images/destinasi/card_pulo_dua.png'),
('Jelajah Megalitikum Lore','Lembah Bada, Poso',
 'Jelajah situs purba bersama penduduk lokal.',
 '2026-11-25','2026-11-29','BUDAYA','Poso', 150000, 4.70, 1100,
 'assets/images/destinasi/card_bada.png');

INSERT INTO ulasan (desaId, nama, rating, komentar) VALUES
(1,'Rian Kusuma',5,'Sewa kano transparan sangat recommended, pemandangan danau dari atas air bening banget.'),
(1,'Dinda Widyawati',5,'Rute feri dari Pelabuhan Luwuk gampang banget diikuti, tapi jangan lupa cek jadwal pasang-surut.'),
(2,'Andi Pratama',4,'Snorkeling di Togean luar biasa, terumbu karangnya masih sangat terjaga.');

INSERT INTO kunjungan_turis (negara, jumlah) VALUES
('Australia', 1250),('Malaysia', 980),('Singapore', 760),
('Japan', 540),('Netherlands', 420);