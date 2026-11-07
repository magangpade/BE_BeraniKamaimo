-- =====================================================
-- DATABASE BERANI KAMAIMO
-- MySQL 8.x
-- =====================================================

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
  '$2b$10$8vNDxnIx9mjjMnrJHbfDFORCuyA4/1VnTeiWJU8CJA5BuFAjAOxL.',
  'L',
  'superAdmin'
) ON DUPLICATE KEY UPDATE password = VALUES(password), role = 'superAdmin';

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
  kategori VARCHAR(50) DEFAULT 'EKOWISATA',
  foto TEXT,
  link_video TEXT,
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
  foto TEXT,
  link_video TEXT,
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
  foto TEXT,
  link_video TEXT,
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
  link_gmaps TEXT NOT NULL,
  link_video TEXT,
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
  telepon VARCHAR(100),
  jumlah_kamar VARCHAR(50),
  jumlah_tempatTidur VARCHAR(50),
  harga_minimum INT NOT NULL DEFAULT 0,
  harga_maximum INT NOT NULL DEFAULT 0,
  website TEXT,
  link_gmaps TEXT,
  lokasi VARCHAR(255),
  foto TEXT,
  link_video TEXT,
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
  media TEXT,
  link_video TEXT,
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

-- Rating khusus Event; satu rating per perangkat untuk setiap Event.
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

INSERT INTO kunjungan_turis (negara, jumlah) VALUES
('Australia', 1250),('Malaysia', 980),('Singapore', 760),
('Japan', 540),('Netherlands', 420);
