const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query('SELECT * FROM kuliner ORDER BY nama_makanan');
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