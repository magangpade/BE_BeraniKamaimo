const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

exports.track = asyncHandler(async (req, res) => {
  const { page, visitorId } = req.body;
  if (!page || !visitorId) throw ApiError.badRequest('page & visitorId wajib');
  const [r] = await pool.query(
    'INSERT INTO pageview (page, visitorId) VALUES (?,?)', [page, visitorId]);
  ApiResponse.created(res, { id: r.insertId }, 'Pageview dicatat');
});

exports.chart = asyncHandler(async (req, res) => {
  const filter = req.query.filter || 'day';
  // filter: day = 7 hari terakhir, month = 12 bulan terakhir, year = 5 tahun terakhir
  let sql;
  if (filter === 'month') {
    sql = `SELECT DATE_FORMAT(createdAt, '%Y-%m') AS label, COUNT(*) AS value
           FROM pageview
           WHERE createdAt >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
           GROUP BY label ORDER BY label`;
  } else if (filter === 'year') {
    sql = `SELECT YEAR(createdAt) AS label, COUNT(*) AS value
           FROM pageview
           WHERE createdAt >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
           GROUP BY label ORDER BY label`;
  } else {
    sql = `SELECT DATE_FORMAT(createdAt, '%Y-%m-%d') AS label, COUNT(*) AS value
           FROM pageview
           WHERE createdAt >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
           GROUP BY label ORDER BY label`;
  }
  const [rows] = await pool.query(sql);
  ApiResponse.success(res, rows);
});
