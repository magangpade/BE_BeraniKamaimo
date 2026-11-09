const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');

async function recalculateDesa(connection, desaId) {
  if (desaId == null) return;
  await connection.query(
    `UPDATE desa_wisata SET
       rating = COALESCE((SELECT ROUND(AVG(rating), 2) FROM ulasan WHERE desaId = ?), 0),
       total_ulasan = (SELECT COUNT(*) FROM ulasan WHERE desaId = ?)
     WHERE id = ?`,
    [desaId, desaId, desaId]
  );
}

exports.list = asyncHandler(async (req, res) => {
  const { desaId } = req.query;
  let sql = 'SELECT * FROM ulasan';
  const params = [];
  if (desaId) { sql += ' WHERE desaId = ?'; params.push(desaId); }
  sql += ' ORDER BY createdAt DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});

exports.insert = asyncHandler(async (req, res) => {
  const { nama, rating, komentar, desaId } = req.body;
  if (!nama || !rating || !komentar)
    throw ApiError.badRequest('nama, rating, komentar wajib diisi');
  if (rating < 1 || rating > 5)
    throw ApiError.badRequest('rating harus 1-5');
  const [r] = await pool.query(
    'INSERT INTO ulasan (desaId, nama, rating, komentar) VALUES (?,?,?,?)',
    [desaId || null, nama, rating, komentar]
  );

  // update agregat desa (kalau desaId ada)
  if (desaId) {
    await pool.query(
      `UPDATE desa_wisata SET
         rating = (SELECT ROUND(AVG(rating),2) FROM ulasan WHERE desaId = ?),
         total_ulasan = (SELECT COUNT(*) FROM ulasan WHERE desaId = ?)
       WHERE id = ?`,
      [desaId, desaId, desaId]
    );
  }

  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0], 'Ulasan berhasil dikirim');
});

exports.update = asyncHandler(async (req, res) => {
  const fields = ['nama', 'rating', 'komentar', 'desaId'];
  const updates = fields.filter((field) => req.body[field] !== undefined);
  if (!updates.length) throw ApiError.badRequest('Tidak ada field untuk diupdate');
  for (const field of ['nama', 'komentar']) {
    if (req.body[field] !== undefined && !String(req.body[field]).trim()) {
      throw ApiError.badRequest(`${field} wajib diisi`);
    }
  }
  if (req.body.rating !== undefined &&
      (!Number.isInteger(Number(req.body.rating)) ||
       Number(req.body.rating) < 1 || Number(req.body.rating) > 5)) {
    throw ApiError.badRequest('rating harus 1-5');
  }
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();
    const [oldRows] = await connection.query(
      'SELECT * FROM ulasan WHERE id = ? FOR UPDATE', [req.params.id]
    );
    if (!oldRows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
    await connection.query(
      `UPDATE ulasan SET ${updates.map((field) => `${field} = ?`).join(', ')} WHERE id = ?`,
      [...updates.map((field) => req.body[field]), req.params.id]
    );
    const [rows] = await connection.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
    await recalculateDesa(connection, oldRows[0].desaId);
    if (rows[0].desaId !== oldRows[0].desaId) {
      await recalculateDesa(connection, rows[0].desaId);
    }
    await connection.commit();
    ApiResponse.success(res, rows[0], 'Ulasan diperbarui');
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
});

exports.remove = asyncHandler(async (req, res) => {
  const connection = await pool.getConnection();
  try {
    await connection.beginTransaction();
    const [rows] = await connection.query(
      'SELECT desaId FROM ulasan WHERE id = ? FOR UPDATE', [req.params.id]
    );
    if (!rows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
    await connection.query('DELETE FROM ulasan WHERE id = ?', [req.params.id]);
    await recalculateDesa(connection, rows[0].desaId);
    await connection.commit();
    ApiResponse.success(res, null, 'Ulasan dihapus');
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
});
