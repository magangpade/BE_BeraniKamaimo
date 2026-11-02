const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

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
  if (!nameEvent || !startdate || !enddate)
    throw ApiError.badRequest('nameEvent, startdate, enddate wajib');
  const [r] = await pool.query(
    `INSERT INTO atraksi
     (nameEvent, location_id, location_en, description_id, description_en,
      startdate, enddate, kategori, wilayah, harga, foto, link_video)
     VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
    [nameEvent, location_id, location_en, description_id, description_en,
     startdate, enddate, kategori || 'BUDAYA', wilayah, harga || null,
     foto, link_video]
  );
  const [rows] = await pool.query('SELECT * FROM atraksi WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});

exports.update = asyncHandler(async (req, res) => {
  const [exists] = await pool.query('SELECT id FROM atraksi WHERE id = ?', [req.params.id]);
  if (!exists.length) throw ApiError.notFound('Atraksi tidak ditemukan');
  const fields = ['nameEvent','location_id','location_en','description_id',
    'description_en','startdate','enddate','kategori','wilayah','harga','foto','link_video'];
  const sets = []; const vals = [];
  for (const f of fields) {
    if (req.body[f] !== undefined) { sets.push(`${f} = ?`); vals.push(req.body[f]); }
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
