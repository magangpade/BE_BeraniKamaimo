const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query(
    'SELECT * FROM kunjungan_turis ORDER BY jumlah DESC LIMIT 20');
  ApiResponse.success(res, rows);
});
