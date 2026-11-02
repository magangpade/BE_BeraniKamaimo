const bcrypt = require('bcryptjs');
const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const jwt = require('../utils/jwt');

exports.login = asyncHandler(async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password)
    throw ApiError.badRequest('username & password wajib');
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE username = ?', [username]);
  if (!rows.length) throw ApiError.unauthorized('Username atau password salah');
  const user = rows[0];
  const match = await bcrypt.compare(password, user.password);
  if (!match) throw ApiError.unauthorized('Username atau password salah');
  const token = jwt.sign({ id: user.id, username: user.username, role: user.role });
  const { password: _pw, ...safe } = user;
  ApiResponse.success(res, { token, user: safe }, 'Login berhasil');
});

exports.me = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM admin_user WHERE id = ?', [req.user.id]);
  if (!rows.length) throw ApiError.notFound('User tidak ditemukan');
  const { password: _pw, ...safe } = rows[0];
  ApiResponse.success(res, safe);
});

exports.list = asyncHandler(async (_req, res) => {
  const [rows] = await pool.query(
    'SELECT id, nama_Lengkap, username, jenis_kelamin, role, created_at FROM admin_user');
  ApiResponse.success(res, rows);
});

exports.create = asyncHandler(async (req, res) => {
  const { nama_Lengkap, username, password, jenis_kelamin, role } = req.body;
  if (!nama_Lengkap || !username || !password)
    throw ApiError.badRequest('nama_Lengkap, username, password wajib');
  const hash = await bcrypt.hash(password, 10);
  const [r] = await pool.query(
    'INSERT INTO admin_user (nama_Lengkap, username, password, jenis_kelamin, role) VALUES (?,?,?,?,?)',
    [nama_Lengkap, username, hash, jenis_kelamin || 'L', role || 'Admin']
  );
  ApiResponse.created(res, { id: r.insertId }, 'Admin baru dibuat');
});
