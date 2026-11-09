const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const updateRecord = require('../utils/updateRecord');

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query('SELECT * FROM tour_package');
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
      deskripsi_en, lokasi_id, lokasi_en, kontak, media, link_video,
      kategori, wilayah, durasi, tipe, tag, satuan, fasilitas, link_gmaps)
     VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    [b.nama_wisata_id, b.nama_wisata_en, b.harga, b.deskripsi_id||'',
     b.deskripsi_en, b.lokasi_id||'', b.lokasi_en, b.kontak||'', b.media, b.link_video,
     b.kategori||'EKOWISATA', b.wilayah||null, b.durasi||'', b.tipe||'',
     b.tag||'', b.satuan||'/orang', b.fasilitas||'', b.link_gmaps||'']);
  const [rows] = await pool.query('SELECT * FROM tour_package WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.update = asyncHandler(async (req, res) => {
  const row = await updateRecord({
    table: 'tour_package', id: req.params.id, body: req.body,
    fields: ['nama_wisata_id', 'nama_wisata_en', 'harga', 'deskripsi_id',
      'deskripsi_en', 'lokasi_id', 'lokasi_en', 'kontak', 'media', 'link_video',
      'kategori', 'wilayah', 'durasi', 'tipe', 'tag', 'satuan', 'fasilitas', 'link_gmaps'],
    required: ['nama_wisata_id', 'harga'], label: 'Paket wisata',
  });
  ApiResponse.success(res, row, 'Paket wisata diperbarui');
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM tour_package WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Paket wisata tidak ditemukan');
  ApiResponse.success(res, null, 'Paket wisata dihapus');
});
