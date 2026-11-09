const pool = require('../src/config/db');

const columns = {
  atraksi: {
    badge: 'VARCHAR(180)',
    program_json: 'LONGTEXT',
    rundown_json: 'LONGTEXT',
    akses_json: 'LONGTEXT',
    organizer_json: 'LONGTEXT',
    maps_url: 'TEXT',
    map_label: 'VARCHAR(180)',
    latitude: 'DECIMAL(10,7)',
    longitude: 'DECIMAL(10,7)',
  },
  tour_package: {
    kategori: "VARCHAR(50) DEFAULT 'EKOWISATA'",
    wilayah: 'VARCHAR(100)',
    durasi: 'VARCHAR(80)',
    tipe: 'VARCHAR(80)',
    tag: 'VARCHAR(100)',
    satuan: 'VARCHAR(40)',
    fasilitas: 'TEXT',
    link_gmaps: 'TEXT',
    rating: 'DECIMAL(3,2) DEFAULT 0',
    rating_count: 'VARCHAR(20)',
  },
  kuliner: {
    wilayah: 'VARCHAR(100)',
    warung: 'VARCHAR(100)',
    tag: 'VARCHAR(100)',
    bahan: 'TEXT',
    link_gmaps: 'TEXT',
    telepon: 'VARCHAR(100)',
    website: 'TEXT',
  },
  rumah_makan: {
    lokasi: 'VARCHAR(255)',
    telepon: 'VARCHAR(100)',
    website: 'TEXT',
    foto: 'TEXT',
  },
  hotel: {
    wilayah: 'VARCHAR(100)',
    tag: 'VARCHAR(100)',
    highlight: 'VARCHAR(100)',
    rating: 'DECIMAL(3,2) DEFAULT 0',
    rating_count: 'VARCHAR(20)',
  },
};

async function main() {
  for (const [table, definitions] of Object.entries(columns)) {
    const [rows] = await pool.query(
      'SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ?',
      [table],
    );
    const existing = new Set(rows.map((row) => row.COLUMN_NAME.toLowerCase()));
    for (const [column, definition] of Object.entries(definitions)) {
      if (existing.has(column.toLowerCase())) continue;
      await pool.query(`ALTER TABLE \`${table}\` ADD COLUMN \`${column}\` ${definition}`);
      console.log(`Added ${table}.${column}`);
    }
  }
  await pool.query('ALTER TABLE hotel MODIFY COLUMN rating DECIMAL(3,2) NOT NULL DEFAULT 0');
  await pool.query("ALTER TABLE hotel MODIFY COLUMN rating_count VARCHAR(20) DEFAULT '0'");
  await pool.query('ALTER TABLE tour_package MODIFY COLUMN rating DECIMAL(3,2) NOT NULL DEFAULT 0');
  await pool.query("ALTER TABLE tour_package MODIFY COLUMN rating_count VARCHAR(20) DEFAULT '0'");
}

main().then(() => pool.end()).catch(async (error) => {
  console.error(error);
  await pool.end();
  process.exitCode = 1;
});
