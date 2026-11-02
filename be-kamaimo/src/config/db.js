const mysql = require('mysql2/promise');
const { DB } = require('./env');

const pool = mysql.createPool({
  host: DB.host,
  port: DB.port,
  user: DB.user,
  password: DB.password,
  database: DB.name,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  dateStrings: true,
});

// Test connection sekali saat boot
(async () => {
  try {
    const conn = await pool.getConnection();
    console.log(`✅ MySQL connected: ${DB.name}@${DB.host}:${DB.port}`);
    conn.release();
  } catch (err) {
    console.warn('⚠️ MySQL connection warning:', err.message);
    console.warn('👉 Pastikan service MySQL berjalan & database/password di .env sudah sesuai.');
  }
})();

module.exports = pool;
