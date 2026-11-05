-- Jalankan sekali pada database yang sudah ada sebelum mengaktifkan fitur rating Event.
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
