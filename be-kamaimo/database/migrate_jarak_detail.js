const pool = require('../src/config/db');

const modes = ['laut', 'darat', 'udara'];
const columns = modes.flatMap((mode) => [
  [`jalur_${mode}_en`, 'TEXT NULL'],
  [`jalur_${mode}_judul`, 'VARCHAR(180) NULL'],
  [`jalur_${mode}_judul_en`, 'VARCHAR(180) NULL'],
  [`jalur_${mode}_durasi`, 'VARCHAR(80) NULL'],
  [`jalur_${mode}_biaya`, 'VARCHAR(100) NULL'],
]);

async function migrate() {
  const [[origin]] = await pool.query(
    `SELECT DATA_TYPE FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'jarak_desa' AND COLUMN_NAME = 'titikKota'`
  );
  if (!origin) throw new Error('Tabel jarak_desa belum tersedia');
  if (origin.DATA_TYPE !== 'varchar') {
    await pool.query('ALTER TABLE jarak_desa MODIFY COLUMN titikKota VARCHAR(100) NOT NULL');
    console.log('Asal wilayah kini menerima semua wilayah');
  }
  const [rows] = await pool.query(
    `SELECT COLUMN_NAME FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'jarak_desa'`
  );
  if (!rows.length) throw new Error('Tabel jarak_desa belum tersedia');
  const existing = new Set(rows.map((row) => row.COLUMN_NAME));
  for (const [name, type] of columns) {
    if (existing.has(name)) continue;
    await pool.query(`ALTER TABLE jarak_desa ADD COLUMN \`${name}\` ${type}`);
    console.log(`Kolom ${name} ditambahkan`);
  }
  console.log('Migrasi detail jalur desa selesai');
}

migrate()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => pool.end());
