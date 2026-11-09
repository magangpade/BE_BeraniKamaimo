const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const updateRecord = require('../utils/updateRecord');

// Setiap rumah makan terkait tampil sebagai kartu kuliner tersendiri.
// Kuliner tanpa rumah makan tetap tampil dengan data kontak dan lokasi sendiri.
const withRestaurant = 'kuliner k LEFT JOIN rumah_makan r ON r.kulinerId = k.id';
const columns = `k.*,
  COALESCE(NULLIF(r.resto, ''), k.warung) AS warung,
  COALESCE(NULLIF(r.lokasi, ''), k.lokasi) AS lokasi,
  COALESCE(NULLIF(r.telepon, ''), k.telepon) AS telepon,
  COALESCE(NULLIF(r.website, ''), k.website) AS website,
  COALESCE(NULLIF(r.foto, ''), k.foto) AS foto,
  COALESCE(NULLIF(r.link_gmaps, ''), k.link_gmaps) AS link_gmaps`;

exports.list = asyncHandler(async (req, res) => {
  const { q, wilayah } = req.query;
  let sql = `SELECT ${columns} FROM ${withRestaurant} WHERE 1=1`;
  const params = [];
  if (wilayah && wilayah !== 'Semua Wilayah') {
    sql += ' AND (k.wilayah LIKE ? OR k.lokasi LIKE ? OR r.lokasi LIKE ?)';
    params.push(`%${wilayah}%`, `%${wilayah}%`, `%${wilayah}%`);
  }
  if (q) {
    sql += ' AND (k.nama_makanan LIKE ? OR k.warung LIKE ? OR k.lokasi LIKE ? OR k.wilayah LIKE ? OR r.resto LIKE ?)';
    params.push(`%${q}%`, `%${q}%`, `%${q}%`, `%${q}%`, `%${q}%`);
  }
  sql += ' ORDER BY k.nama_makanan ASC, r.id DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});
exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query(`SELECT ${columns} FROM ${withRestaurant} WHERE k.id = ? ORDER BY r.id DESC LIMIT 1`, [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Kuliner tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});
exports.create = asyncHandler(async (req, res) => {
  const { nama_makanan, lokasi, deskripsi_id, deskripsi_en, foto, link_video,
    wilayah, warung, tag, bahan, link_gmaps, telepon, website } = req.body;
  if (!nama_makanan || !lokasi || !deskripsi_id || !foto)
    throw ApiError.badRequest('Nama, lokasi, deskripsi, dan foto kuliner wajib diisi');
  const [r] = await pool.query(
    `INSERT INTO kuliner (nama_makanan, lokasi, deskripsi_id, deskripsi_en, foto,
      link_video, wilayah, warung, tag, bahan, link_gmaps, telepon, website)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    [nama_makanan, lokasi, deskripsi_id, deskripsi_en || '', foto, link_video,
      wilayah, warung, tag, bahan, link_gmaps, telepon, website]);
  const [rows] = await pool.query('SELECT * FROM kuliner WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.update = asyncHandler(async (req, res) => {
  const row = await updateRecord({
    table: 'kuliner', id: req.params.id, body: req.body,
    fields: ['nama_makanan', 'lokasi', 'deskripsi_id', 'deskripsi_en',
      'foto', 'link_video', 'wilayah', 'warung', 'tag', 'bahan',
      'link_gmaps', 'telepon', 'website'],
    required: ['nama_makanan'], label: 'Kuliner',
  });
  ApiResponse.success(res, row, 'Kuliner diperbarui');
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM kuliner WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Kuliner tidak ditemukan');
  ApiResponse.success(res, null, 'Kuliner dihapus');
});
