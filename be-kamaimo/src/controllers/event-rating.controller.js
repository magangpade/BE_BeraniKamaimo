const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

const validEventKey = (value) => typeof value === 'string' && /^[a-z0-9][a-z0-9-]{0,119}$/.test(value);
const validVisitorKey = (value) => typeof value === 'string' && /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value);

async function readSummary(eventKey, visitorKey) {
  const [rows] = await pool.query(
    'SELECT COUNT(*) AS ratingCount, ROUND(AVG(rating), 2) AS rating FROM event_rating WHERE event_key = ?',
    [eventKey]
  );
  let myRating = null;
  if (visitorKey) {
    const [mine] = await pool.query(
      'SELECT rating FROM event_rating WHERE event_key = ? AND visitor_key = ?',
      [eventKey, visitorKey]
    );
    if (mine.length) myRating = Number(mine[0].rating);
  }
  return {
    eventKey,
    rating: rows[0].rating === null ? null : Number(rows[0].rating),
    ratingCount: Number(rows[0].ratingCount),
    myRating,
  };
}

exports.summary = asyncHandler(async (req, res) => {
  const eventKey = req.params.eventKey;
  const visitorKey = req.query.visitorKey;
  if (!validEventKey(eventKey)) throw ApiError.badRequest('eventKey tidak valid');
  if (visitorKey !== undefined && !validVisitorKey(visitorKey)) {
    throw ApiError.badRequest('visitorKey tidak valid');
  }
  ApiResponse.success(res, await readSummary(eventKey, visitorKey));
});

exports.submit = asyncHandler(async (req, res) => {
  const eventKey = req.params.eventKey;
  const { visitorKey, rating } = req.body;
  if (!validEventKey(eventKey)) throw ApiError.badRequest('eventKey tidak valid');
  if (!validVisitorKey(visitorKey)) throw ApiError.badRequest('visitorKey tidak valid');
  if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
    throw ApiError.badRequest('rating harus bilangan bulat 1-5');
  }

  await pool.query(
    `INSERT INTO event_rating (event_key, visitor_key, rating) VALUES (?, ?, ?)
     ON DUPLICATE KEY UPDATE rating = VALUES(rating), updated_at = CURRENT_TIMESTAMP`,
    [eventKey, visitorKey, rating]
  );
  ApiResponse.success(res, await readSummary(eventKey, visitorKey), 'Rating Event berhasil disimpan');
});
