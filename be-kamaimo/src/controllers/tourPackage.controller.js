const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (req, res) => {
  const { q, kategori } = req.query;
  let sql = 'SELECT * FROM tour_package WHERE 1=1';
  const params = [];
  if (kategori && kategori !== 'Semua') {
    sql += ' AND UPPER(kategori) = ?';
    params.push(kategori.toUpperCase());
  }
  if (q) {
    sql += ' AND (nama_wisata_id LIKE ? OR lokasi_id LIKE ? OR deskripsi_id LIKE ?)';
    params.push(`%${q}%`, `%${q}%`, `%${q}%`);
  }
  sql += ' ORDER BY rating DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});
exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM tour_package WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Paket wisata tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});
exports.create = asyncHandler(async (req, res) => {
  const b = req.body;
  if (!b.nama_wisata_id || b.harga == null)
    throw ApiError.badRequest('nama_wisata_id & harga wajib');
  const [r] = await pool.query(
    `INSERT INTO tour_package (nama_wisata_id, nama_wisata_en, harga, deskripsi_id,
      deskripsi_en, lokasi_id, lokasi_en, kontak, media, link_video)
     VALUES (?,?,?,?,?,?,?,?,?,?)`,
    [b.nama_wisata_id, b.nama_wisata_en, b.harga, b.deskripsi_id||'',
     b.deskripsi_en, b.lokasi_id||'', b.lokasi_en, b.kontak||'', b.media, b.link_video]);
  const [rows] = await pool.query('SELECT * FROM tour_package WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM tour_package WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Paket wisata tidak ditemukan');
  ApiResponse.success(res, null, 'Paket wisata dihapus');
});