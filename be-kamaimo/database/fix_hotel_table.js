const mysql = require('mysql2/promise');
require('dotenv').config({ path: 'd:/ApkKamaimo/be-kamaimo/.env' });

async function addCol(c, name, def) {
  try {
    const [cols] = await c.query(`SHOW COLUMNS FROM hotel LIKE '${name}'`);
    if (cols.length === 0) {
      await c.query(`ALTER TABLE hotel ADD COLUMN ${name} ${def}`);
      console.log(`Added column ${name}`);
    } else {
      console.log(`Column ${name} already exists`);
    }
  } catch (err) {
    console.log(`Error adding ${name}:`, err.message);
  }uter
}

async function main() {
  const c = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'berani_kamaimo'
  });

  console.log('Checking & adding hotel columns...');
  await addCol(c, 'rating', 'DECIMAL(3,2) NOT NULL DEFAULT 4.70');
  await addCol(c, 'rating_count', 'INT NOT NULL DEFAULT 120');
  await addCol(c, 'tag', 'VARCHAR(100) NULL');
  await addCol(c, 'wilayah', 'VARCHAR(100) NULL');

  await c.query(`
    UPDATE hotel SET wilayah = 
      CASE 
        WHEN LOWER(lokasi) LIKE '%palu%' THEN 'Palu'
        WHEN LOWER(lokasi) LIKE '%luwuk%' THEN 'Luwuk'
        WHEN LOWER(lokasi) LIKE '%togean%' OR LOWER(lokasi) LIKE '%tojo%' OR LOWER(lokasi) LIKE '%ampana%' THEN 'Ampana & Togean'
        WHEN LOWER(lokasi) LIKE '%poso%' THEN 'Poso'
        WHEN LOWER(lokasi) LIKE '%donggala%' THEN 'Donggala'
        WHEN LOWER(lokasi) LIKE '%sigi%' THEN 'Sigi'
        WHEN LOWER(lokasi) LIKE '%banggai%' THEN 'Banggai'
        ELSE 'Sulteng'
      END
    WHERE wilayah IS NULL OR wilayah = ''
  `);

  console.log('Hotel table updated successfully!');
  await c.end();
}

main().catch(console.error);
