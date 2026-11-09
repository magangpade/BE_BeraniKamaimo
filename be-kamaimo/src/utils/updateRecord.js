const pool = require('../config/db');
const ApiError = require('./ApiError');

// Column names only come from the controller's fixed allowlist.
module.exports = async function updateRecord({
  table, id, body, fields, required = [], label,
}) {
  if (!/^\d+$/.test(String(id))) throw ApiError.badRequest('ID tidak valid');
  const updates = fields.filter((field) => body[field] !== undefined);
  if (!updates.length) throw ApiError.badRequest('Tidak ada field untuk diupdate');
  for (const field of required) {
    if (body[field] !== undefined &&
        (body[field] === null || String(body[field]).trim() === '')) {
      throw ApiError.badRequest(`${field} wajib diisi`);
    }
  }
  const [exists] = await pool.query(`SELECT id FROM ${table} WHERE id = ?`, [id]);
  if (!exists.length) throw ApiError.notFound(`${label} tidak ditemukan`);
  await pool.query(
    `UPDATE ${table} SET ${updates.map((field) => `${field} = ?`).join(', ')} WHERE id = ?`,
    [...updates.map((field) => body[field]), id]
  );
  const [rows] = await pool.query(`SELECT * FROM ${table} WHERE id = ?`, [id]);
  return rows[0];
};
