const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.register = asyncHandler(async (req, res) => {
  const { uid } = req.body;
  if (!uid) throw ApiError.badRequest('uid wajib');
  const [existing] = await pool.query('SELECT * FROM visitor WHERE uid = ?', [uid]);
  if (existing.length) return ApiResponse.success(res, existing[0], 'Visitor sudah terdaftar');
  const [r] = await pool.query('INSERT INTO visitor (uid) VALUES (?)', [uid]);
  const [rows] = await pool.query('SELECT * FROM visitor WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0], 'Visitor terdaftar');
});

exports.summary = asyncHandler(async (_req, res) => {
  const [[visitors]] = await pool.query('SELECT COUNT(*) AS c FROM visitor');
  const [[visits]] = await pool.query('SELECT COUNT(*) AS c FROM pageview');
  ApiResponse.success(res, { visitors: visitors.c, visits: visits.c });
});
