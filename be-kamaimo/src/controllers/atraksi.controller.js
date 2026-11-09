const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

const details = ['badge', 'program_json', 'rundown_json', 'akses_json',
  'organizer_json', 'maps_url', 'map_label', 'latitude', 'longitude'];

function validateEvent(b) {
  if (!b.nameEvent || !b.location_id || !b.description_id || !b.startdate || !b.enddate) {
    throw ApiError.badRequest('Nama, lokasi, deskripsi, dan tanggal event wajib diisi');
  }
  if (new Date(b.enddate) < new Date(b.startdate)) {
    throw ApiError.badRequest('Tanggal selesai harus setelah tanggal mulai');
  }
  for (const field of ['program_json', 'rundown_json', 'akses_json', 'organizer_json']) {
    if (b[field] == null || b[field] === '') continue;
    let value;
    try { value = typeof b[field] === 'string' ? JSON.parse(b[field]) : b[field]; }
    catch (_) { throw ApiError.badRequest(`${field} bukan JSON yang valid`); }
    if (!Array.isArray(value)) throw ApiError.badRequest(`${field} harus berupa daftar`);
  }
}

exports.list = asyncHandler(async (req, res) => {
  const { kategori, wilayah, q } = req.query;
  let sql = 'SELECT * FROM atraksi WHERE 1=1';
  const params = [];
  if (kategori) { sql += ' AND kategori = ?'; params.push(kategori); }
  if (wilayah) { sql += ' AND wilayah = ?'; params.push(wilayah); }
  if (q) {
    sql += ' AND (nameEvent LIKE ? OR location_id LIKE ?)';
    params.push(`%${q}%`, `%${q}%`);
  }
  sql += ' ORDER BY startdate ASC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM atraksi WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Atraksi tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});

exports.create = asyncHandler(async (req, res) => {
  const {
    nameEvent, location_id, location_en, description_id, description_en,
    startdate, enddate, kategori, wilayah, harga, foto, link_video,
  } = req.body;
  validateEvent(req.body);
  const detailValues = details.map((field) => {
    const value = req.body[field];
    return Array.isArray(value) ? JSON.stringify(value) : (value ?? null);
  });
  const [r] = await pool.query(
    `INSERT INTO atraksi
     (nameEvent, location_id, location_en, description_id, description_en,
      startdate, enddate, kategori, wilayah, harga, foto, link_video,
      ${details.join(', ')})
     VALUES (${Array(12 + details.length).fill('?').join(',')})`,
    [nameEvent, location_id, location_en, description_id, description_en,
     startdate, enddate, kategori || 'BUDAYA', wilayah, harga || null,
     foto, link_video, ...detailValues]
  );
  const [rows] = await pool.query('SELECT * FROM atraksi WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});

exports.update = asyncHandler(async (req, res) => {
  const [exists] = await pool.query('SELECT * FROM atraksi WHERE id = ?', [req.params.id]);
  if (!exists.length) throw ApiError.notFound('Atraksi tidak ditemukan');
  validateEvent({ ...exists[0], ...req.body });
  const fields = ['nameEvent','location_id','location_en','description_id',
    'description_en','startdate','enddate','kategori','wilayah','harga','foto','link_video', ...details];
  const sets = []; const vals = [];
  for (const f of fields) {
    if (req.body[f] !== undefined) {
      sets.push(`${f} = ?`);
      vals.push(Array.isArray(req.body[f]) ? JSON.stringify(req.body[f]) : req.body[f]);
    }
  }
  if (!sets.length) throw ApiError.badRequest('Tidak ada field untuk diupdate');
  vals.push(req.params.id);
  await pool.query(`UPDATE atraksi SET ${sets.join(', ')} WHERE id = ?`, vals);
  const [rows] = await pool.query('SELECT * FROM atraksi WHERE id = ?', [req.params.id]);
  ApiResponse.success(res, rows[0], 'Atraksi diperbarui');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM atraksi WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Atraksi tidak ditemukan');
  ApiResponse.success(res, null, 'Atraksi dihapus');
});
