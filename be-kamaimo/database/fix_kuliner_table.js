const mysql = require('mysql2/promise');
require('dotenv').config({ path: 'd:/ApkKamaimo/be-kamaimo/.env' });

async function addCol(c, name, def) {
  try {
    const [cols] = await c.query(`SHOW COLUMNS FROM kuliner LIKE '${name}'`);
    if (cols.length === 0) {
      await c.query(`ALTER TABLE kuliner ADD COLUMN ${name} ${def}`);
      console.log(`Added column ${name}`);
    } else {
      console.log(`Column ${name} already exists`);
    }
  } catch (err) {
    console.log(`Error adding ${name}:`, err.message);
  }
}

async function main() {
  const c = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'berani_kamaimo'
  });

  console.log('Checking & adding kuliner columns...');
  await addCol(c, 'wilayah', 'VARCHAR(100) NULL');
  await addCol(c, 'warung', 'VARCHAR(150) NULL');
  await addCol(c, 'tag', 'VARCHAR(100) NULL');
  await addCol(c, 'bahan', 'TEXT NULL');

  await c.query(`
    UPDATE kuliner SET wilayah = 
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

  await c.query(`
    UPDATE kuliner SET warung = CONCAT('Kuliner Khas ', lokasi) WHERE warung IS NULL OR warung = ''
  `);

  console.log('Kuliner table updated successfully!');
  await c.end();
}

main().catch(console.error);
