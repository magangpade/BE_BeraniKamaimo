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

let migrationChecked = false;
async function ensureBalasanColumns() {
  if (migrationChecked) return;
  try {
    const [cols] = await pool.query("SHOW COLUMNS FROM ulasan LIKE 'balasan_admin'");
    if (!cols.length) {
      await pool.query("ALTER TABLE ulasan ADD COLUMN balasan_admin TEXT NULL, ADD COLUMN balasan_at TIMESTAMP NULL");
    }
    migrationChecked = true;
  } catch (_) {
    // Abaikan jika sudah ada atau tabel belum dibuat
  }
}

exports.list = asyncHandler(async (req, res) => {
  await ensureBalasanColumns();
  const { desaId } = req.query;
  let sql = 'SELECT * FROM ulasan';
  const params = [];
  if (desaId) { sql += ' WHERE desaId = ?'; params.push(desaId); }
  sql += ' ORDER BY createdAt DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  await ensureBalasanColumns();
  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
  ApiResponse.success(res, rows[0]);
});

exports.insert = asyncHandler(async (req, res) => {
  await ensureBalasanColumns();
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
  await ensureBalasanColumns();
  if (req.body.balasanAdmin !== undefined && req.body.balasan_admin === undefined) {
    req.body.balasan_admin = req.body.balasanAdmin;
  }
  const fields = ['nama', 'rating', 'komentar', 'desaId', 'balasan_admin'];
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
    
    // Jika balasan_admin diupdate, update juga balasan_at
    const setClauses = [...updates.map((field) => `${field} = ?`)];
    const setValues = [...updates.map((field) => req.body[field])];
    if (req.body.balasan_admin !== undefined) {
      setClauses.push('balasan_at = CURRENT_TIMESTAMP');
    }
    
    await connection.query(
      `UPDATE ulasan SET ${setClauses.join(', ')} WHERE id = ?`,
      [...setValues, req.params.id]
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

exports.balas = asyncHandler(async (req, res) => {
  await ensureBalasanColumns();
  const balasan = req.body.balasan || req.body.balasan_admin || req.body.komentar;
  if (!balasan || !String(balasan).trim()) {
    throw ApiError.badRequest('Teks balasan admin wajib diisi');
  }
  const [oldRows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
  if (!oldRows.length) throw ApiError.notFound('Ulasan tidak ditemukan');
  await pool.query(
    'UPDATE ulasan SET balasan_admin = ?, balasan_at = CURRENT_TIMESTAMP WHERE id = ?',
    [String(balasan).trim(), req.params.id]
  );
  const [rows] = await pool.query('SELECT * FROM ulasan WHERE id = ?', [req.params.id]);
  ApiResponse.success(res, rows[0], 'Balasan admin berhasil disimpan');
});
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
