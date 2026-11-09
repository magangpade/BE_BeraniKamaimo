const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const updateRecord = require('../utils/updateRecord');

const modes = ['laut', 'darat', 'udara'];
const detailFields = modes.flatMap((mode) => [
  `jalur_${mode}_en`, `jalur_${mode}_judul`, `jalur_${mode}_judul_en`,
  `jalur_${mode}_durasi`, `jalur_${mode}_biaya`,
]);
const fields = ['desaId', 'titikKota', ...modes.map((mode) => `jalur_${mode}`), ...detailFields];

function validateRoute(row) {
  if (!Number.isInteger(Number(row.desaId)) || Number(row.desaId) <= 0) {
    throw ApiError.badRequest('Pilih desa wisata yang valid');
  }
  if (!String(row.titikKota || '').trim() || String(row.titikKota).length > 100) {
    throw ApiError.badRequest('Isi asal wilayah (maksimal 100 karakter)');
  }
  if (!modes.some((mode) => String(row[`jalur_${mode}`] || '').trim())) {
    throw ApiError.badRequest('Isi setidaknya satu deskripsi jalur');
  }
  for (const mode of modes) {
    const description = String(row[`jalur_${mode}`] || '').trim();
    const hasDetails = detailFields.some((key) => key.startsWith(`jalur_${mode}_`) &&
      String(row[key] || '').trim());
    if (!description && hasDetails) {
      throw ApiError.badRequest(`Deskripsi jalur ${mode} wajib diisi jika detail jalurnya diisi`);
    }
  }
}

async function validateRelation(desaId, titikKota, excludedId = null) {
  const [desa] = await pool.query('SELECT id FROM desa_wisata WHERE id = ?', [desaId]);
  if (!desa.length) throw ApiError.badRequest('Desa wisata tidak ditemukan');
  const [duplicates] = await pool.query(
    'SELECT id FROM jarak_desa WHERE desaId = ? AND titikKota = ? AND (? IS NULL OR id <> ?) LIMIT 1',
    [desaId, titikKota, excludedId, excludedId]
  );
  if (duplicates.length) {
    throw new ApiError(409, 'Jalur dari kota ini sudah ada untuk desa tersebut. Edit data yang tersedia.');
  }
}

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
  const row = { ...req.body };
  validateRoute(row);
  await validateRelation(row.desaId, row.titikKota);
  const values = fields.map((field) => row[field] ?? (modes.some((mode) => field === `jalur_${mode}`) ? '' : null));
  const [r] = await pool.query(
    `INSERT INTO jarak_desa (${fields.join(', ')}) VALUES (${fields.map(() => '?').join(', ')})`,
    values
  );
  const [rows] = await pool.query('SELECT * FROM jarak_desa WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});
exports.update = asyncHandler(async (req, res) => {
  const [oldRows] = await pool.query('SELECT * FROM jarak_desa WHERE id = ?', [req.params.id]);
  if (!oldRows.length) throw ApiError.notFound('Jarak tidak ditemukan');
  const merged = { ...oldRows[0], ...req.body };
  validateRoute(merged);
  if (merged.desaId != oldRows[0].desaId || merged.titikKota !== oldRows[0].titikKota) {
    await validateRelation(merged.desaId, merged.titikKota, req.params.id);
  }
  const row = await updateRecord({
    table: 'jarak_desa', id: req.params.id, body: req.body,
    fields,
    required: ['desaId', 'titikKota'], label: 'Jarak',
  });
  ApiResponse.success(res, row, 'Jarak diperbarui');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM jarak_desa WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Jarak tidak ditemukan');
  ApiResponse.success(res, null, 'Jarak dihapus');
});
