const bcrypt = require('bcryptjs');
const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const jwt = require('../utils/jwt');

const DEFAULT_SUPERADMIN_HASH = '$2b$10$8vNDxnIx9mjjMnrJHbfDFORCuyA4/1VnTeiWJU8CJA5BuFAjAOxL.';
const LEGACY_PLACEHOLDER_HASH = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy';

function normalizeUser(u) {
  if (!u) return u;
  const { password: _pw, ...safe } = u;
  if (safe.jenis_kelamin === 'L') safe.jenis_kelamin = 'Laki-laki';
  if (safe.jenis_kelamin === 'P') safe.jenis_kelamin = 'Perempuan';
  return safe;
}

function toDbGender(g) {
  if (!g) return 'L';
  const s = String(g).toLowerCase();
  if (s.startsWith('p') || s.includes('perempuan') || s.includes('wanita')) return 'P';
  return 'L';
}

exports.login = asyncHandler(async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password)
    throw ApiError.badRequest('username & password wajib');

  let rows = [];
  let dbAvailable = true;
  try {
    const [r] = await pool.query('SELECT * FROM admin_user WHERE username = ?', [username]);
    rows = r;

    // Auto-seed atau perbaiki hash placeholder lama untuk superadmin
    if (!rows.length && username === 'superadmin') {
      await pool.query(
        `INSERT INTO admin_user (nama_Lengkap, username, password, jenis_kelamin, role)
         VALUES ('Super Admin Kamaimo', 'superadmin', ?, 'L', 'superAdmin')`,
        [DEFAULT_SUPERADMIN_HASH]
      );
      const [recheck] = await pool.query('SELECT * FROM admin_user WHERE username = ?', ['superadmin']);
      rows = recheck;
    } else if (rows.length && rows[0].username === 'superadmin' && rows[0].password === LEGACY_PLACEHOLDER_HASH) {
      await pool.query(
        'UPDATE admin_user SET password = ? WHERE id = ?',
        [DEFAULT_SUPERADMIN_HASH, rows[0].id]
      );
      rows[0].password = DEFAULT_SUPERADMIN_HASH;
    }
  } catch (_dbErr) {
    dbAvailable = false;
  }

  if (!dbAvailable) {
    // Fallback jika database lokal sedang belum nyala
    if ((username === 'superadmin' || username === 'admin') && password === 'admin123') {
      const fallbackUser = {
        id: username === 'superadmin' ? 1 : 2,
        nama_Lengkap: username === 'superadmin' ? 'Super Admin Kamaimo' : 'Admin Berani Kamaimo',
        username,
        jenis_kelamin: 'Laki-laki',
        role: username === 'superadmin' ? 'superAdmin' : 'Admin',
      };
      const token = jwt.sign({ id: fallbackUser.id, username: fallbackUser.username, role: fallbackUser.role });
      return ApiResponse.success(res, { token, user: fallbackUser }, 'Login berhasil');
    }
    throw ApiError.unauthorized('Username atau password salah');
  }

  if (!rows.length) throw ApiError.unauthorized('Username atau password salah');
  const user = rows[0];
  const match = await bcrypt.compare(password, user.password);
  if (!match) throw ApiError.unauthorized('Username atau password salah');

  const token = jwt.sign({ id: user.id, username: user.username, role: user.role });
  ApiResponse.success(res, { token, user: normalizeUser(user) }, 'Login berhasil');
});

exports.me = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE id = ?', [req.user.id]);
  if (!rows.length) throw ApiError.notFound('User tidak ditemukan');
  ApiResponse.success(res, normalizeUser(rows[0]));
});

exports.updateMe = asyncHandler(async (req, res) => {
  const { nama_Lengkap, jenis_kelamin, password } = req.body;
  const sets = [];
  const vals = [];
  if (nama_Lengkap) {
    sets.push('nama_Lengkap = ?');
    vals.push(nama_Lengkap);
  }
  if (jenis_kelamin) {
    sets.push('jenis_kelamin = ?');
    vals.push(toDbGender(jenis_kelamin));
  }
  if (password && String(password).trim().length > 0) {
    const hash = await bcrypt.hash(String(password).trim(), 10);
    sets.push('password = ?');
    vals.push(hash);
  }
  if (!sets.length) throw ApiError.badRequest('Tidak ada perubahan');
  vals.push(req.user.id);
  await pool.query(`UPDATE admin_user SET ${sets.join(', ')} WHERE id = ?`, vals);
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE id = ?', [req.user.id]);
  ApiResponse.success(res, normalizeUser(rows[0]), 'Profil diperbarui');
});

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query(
    'SELECT id, nama_Lengkap, username, jenis_kelamin, role, created_at FROM admin_user ORDER BY id ASC'
  );
  ApiResponse.success(res, rows.map(normalizeUser));
});

exports.create = asyncHandler(async (req, res) => {
  const { nama_Lengkap, username, password, jenis_kelamin, role } = req.body;
  if (!nama_Lengkap || !username || !password)
    throw ApiError.badRequest('nama_Lengkap, username, password wajib');
  const hash = await bcrypt.hash(password, 10);
  const [r] = await pool.query(
    'INSERT INTO admin_user (nama_Lengkap, username, password, jenis_kelamin, role) VALUES (?,?,?,?,?)',
    [nama_Lengkap, username, hash, toDbGender(jenis_kelamin), role || 'Admin']
  );
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, normalizeUser(rows[0]), 'Admin baru dibuat');
});

exports.update = asyncHandler(async (req, res) => {
  const { nama_Lengkap, username, password, jenis_kelamin, role } = req.body;
  const sets = [];
  const vals = [];
  if (nama_Lengkap) { sets.push('nama_Lengkap = ?'); vals.push(nama_Lengkap); }
  if (username) { sets.push('username = ?'); vals.push(username); }
  if (jenis_kelamin) { sets.push('jenis_kelamin = ?'); vals.push(toDbGender(jenis_kelamin)); }
  if (role) { sets.push('role = ?'); vals.push(role); }
  if (password && String(password).trim().length > 0) {
    const hash = await bcrypt.hash(String(password).trim(), 10);
    sets.push('password = ?');
    vals.push(hash);
  }
  if (!sets.length) throw ApiError.badRequest('Tidak ada perubahan');
  vals.push(req.params.id);
  await pool.query(`UPDATE admin_user SET ${sets.join(', ')} WHERE id = ?`, vals);
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Admin tidak ditemukan');
  ApiResponse.success(res, normalizeUser(rows[0]), 'Data admin diperbarui');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM admin_user WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Admin tidak ditemukan');
  ApiResponse.success(res, null, 'Admin dihapus');
});
