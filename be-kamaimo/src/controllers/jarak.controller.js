const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const updateRecord = require('../utils/updateRecord');

exports.list = asyncHandler(async (req, res) => {
  const { desaId } = req.query;
  let sql = 'SELECT * FROM jarak_desa';
  const params = [];
  if (desaId) { sql += ' WHERE desaId = ?'; params.push(desaId); }
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM jarak_desa WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Jarak tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});

exports.create = asyncHandler(async (req, res) => {
  const { desaId, titikKota, jalur_darat, jalur_laut, jalur_udara } = req.body;
  if (!desaId || !titikKota) throw ApiError.badRequest('desaId & titikKota wajib');
  const [r] = await pool.query(
    'INSERT INTO jarak_desa (desaId, titikKota, jalur_darat, jalur_laut, jalur_udara) VALUES (?,?,?,?,?)',
    [desaId, titikKota, jalur_darat || '', jalur_laut || '', jalur_udara || '']
  );
  const [rows] = await pool.query('SELECT * FROM jarak_desa WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.update = asyncHandler(async (req, res) => {
  const row = await updateRecord({
    table: 'jarak_desa', id: req.params.id, body: req.body,
    fields: ['desaId', 'titikKota', 'jalur_darat', 'jalur_laut', 'jalur_udara'],
    required: ['desaId', 'titikKota'], label: 'Jarak',
  });
  ApiResponse.success(res, row, 'Jarak diperbarui');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM jarak_desa WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Jarak tidak ditemukan');
  ApiResponse.success(res, null, 'Jarak dihapus');
});
