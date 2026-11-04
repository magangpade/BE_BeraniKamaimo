const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (req, res) => {
  const { q, wilayah } = req.query;
  let sql = 'SELECT * FROM kuliner WHERE 1=1';
  const params = [];
  if (wilayah && wilayah !== 'Semua Wilayah') {
    sql += ' AND (wilayah LIKE ? OR lokasi LIKE ?)';
    params.push(`%${wilayah}%`, `%${wilayah}%`);
  }
  if (q) {
    sql += ' AND (nama_makanan LIKE ? OR warung LIKE ? OR lokasi LIKE ? OR wilayah LIKE ?)';
    params.push(`%${q}%`, `%${q}%`, `%${q}%`, `%${q}%`);
  }
  sql += ' ORDER BY nama_makanan ASC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});
exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM kuliner WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Kuliner tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});
exports.create = asyncHandler(async (req, res) => {
  const { nama_makanan, lokasi, deskripsi_id, deskripsi_en, foto, link_video } = req.body;
  if (!nama_makanan) throw ApiError.badRequest('nama_makanan wajib');
  const [r] = await pool.query(
    'INSERT INTO kuliner (nama_makanan, lokasi, deskripsi_id, deskripsi_en, foto, link_video) VALUES (?,?,?,?,?,?)',
    [nama_makanan, lokasi, deskripsi_id, deskripsi_en, foto, link_video]);
  const [rows] = await pool.query('SELECT * FROM kuliner WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM kuliner WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Kuliner tidak ditemukan');
  ApiResponse.success(res, null, 'Kuliner dihapus');
});