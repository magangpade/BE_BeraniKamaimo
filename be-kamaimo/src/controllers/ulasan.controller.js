const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (req, res) => {
  const { desaId } = req.query;
  let sql = 'SELECT * FROM ulasan';
  const params = [];
  if (desaId) { sql += ' WHERE desaId = ?'; params.push(desaId); }
  sql += ' ORDER BY createdAt DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});

exports.insert = asyncHandler(async (req, res) => {
  const { nama, rating, komentar, desaId } = req.body;
  if (!nama || !rating || !komentar)
    throw ApiError.badRequest('nama, rating, komentar wajib diisi');
  if (rating < 1 || rating > 5)
    throw ApiError.badRequest('rating harus 1-5');
  const [r] = await pool.query(
    'INSERT INTO ulasan (desaId, nama, rating, komentar) VALUES (?,?,?,?)',
    [desaId || null, nama, rating, komentar]
  );

  // update agregat desa (kalau desaId ada)
  if (desaId) {
    await pool.query(
      `UPDATE desa_wisata SET
         rating = (SELECT ROUND(AVG(rating),2) FROM ulasan WHERE desaId = ?),
         total_ulasan = (SELECT COUNT(*) FROM ulasan WHERE desaId = ?)
       WHERE id = ?`,
      [desaId, desaId, desaId]
    );
  }

  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0], 'Ulasan berhasil dikirim');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM ulasan WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Ulasan tidak ditemukan');
  ApiResponse.success(res, null, 'Ulasan dihapus');
});
