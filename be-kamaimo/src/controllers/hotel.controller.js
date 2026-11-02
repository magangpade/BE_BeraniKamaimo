const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query('SELECT * FROM hotel');
  ApiResponse.success(res, rows);
});
exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM hotel WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Hotel tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});
exports.create = asyncHandler(async (req, res) => {
  const b = req.body;
  if (!b.nama_hotel) throw ApiError.badRequest('nama_hotel wajib');
  const [r] = await pool.query(
    `INSERT INTO hotel (nama_hotel, telepon, jumlah_kamar, jumlah_tempatTidur,
      harga_minimum, harga_maximum, website, link_gmaps, lokasi, foto, link_video)
     VALUES (?,?,?,?,?,?,?,?,?,?,?)`,
    [b.nama_hotel, b.telepon||'', b.jumlah_kamar||0, b.jumlah_tempatTidur||0,
     b.harga_minimum||0, b.harga_maximum||0, b.website||'', b.link_gmaps||'',
     b.lokasi||'', b.foto||null, b.link_video||null]);
  const [rows] = await pool.query('SELECT * FROM hotel WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM hotel WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Hotel tidak ditemukan');
  ApiResponse.success(res, null, 'Hotel dihapus');
});