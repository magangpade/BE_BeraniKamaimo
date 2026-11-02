const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.list = asyncHandler(async (req, res) => {
  const { kulinerId } = req.query;
  let sql = 'SELECT * FROM rumah_makan';
  const params = [];
  if (kulinerId) { sql += ' WHERE kulinerId = ?'; params.push(kulinerId); }
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});
exports.create = asyncHandler(async (req, res) => {
  const { resto, kulinerId, link_gmaps, link_video } = req.body;
  if (!resto || !kulinerId) throw ApiError.badRequest('resto & kulinerId wajib');
  const [r] = await pool.query(
    'INSERT INTO rumah_makan (resto, kulinerId, link_gmaps, link_video) VALUES (?,?,?,?)',
    [resto, kulinerId, link_gmaps, link_video]);
  const [rows] = await pool.query('SELECT * FROM rumah_makan WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM rumah_makan WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Rumah makan tidak ditemukan');
  ApiResponse.success(res, null, 'Rumah makan dihapus');
});