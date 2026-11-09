const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const fs = require('fs/promises');
const path = require('path');
const { v4: uuid } = require('uuid');

exports.uploadPhoto = asyncHandler(async (req, res) => {
  if (!req.file) throw ApiError.badRequest('Pilih foto desa wisata');
  const bytes = req.file.buffer;
  const png = bytes.length >= 8 && bytes.subarray(0, 8).equals(Buffer.from([137,80,78,71,13,10,26,10]));
  const jpeg = bytes.length >= 3 && bytes.subarray(0, 3).equals(Buffer.from([255,216,255]));
  const webp = bytes.length >= 12 && bytes.toString('ascii', 0, 4) === 'RIFF' &&
    bytes.toString('ascii', 8, 12) === 'WEBP';
  const extension = png ? '.png' : jpeg ? '.jpg' : webp ? '.webp' : null;
  if (!extension) throw ApiError.badRequest('Isi foto harus JPG, PNG, atau WebP');
  const filename = `${uuid()}${extension}`;
  const directory = path.join(__dirname, '../../public/uploads');
  await fs.mkdir(directory, { recursive: true });
  await fs.writeFile(path.join(directory, filename), bytes);
  ApiResponse.created(res, { foto: `/uploads/${filename}` });
});

exports.categories = asyncHandler(async (req, res) => {
  const [rows] = await pool.query(
    'SELECT DISTINCT kategori FROM desa_wisata WHERE kategori IS NOT NULL AND TRIM(kategori) != "" ORDER BY kategori ASC'
  );
  const categories = rows.map(r => r.kategori).filter(Boolean);
  ApiResponse.success(res, categories);
});

exports.list = asyncHandler(async (req, res) => {
  const { jenis, q, kabupaten, kategori } = req.query;
  let sql = 'SELECT * FROM desa_wisata WHERE 1=1';
  const params = [];
  if (jenis) { sql += ' AND jenisDesa = ?'; params.push(jenis); }
  if (kategori) { sql += ' AND UPPER(kategori) = ?'; params.push(kategori.toUpperCase()); }
  if (kabupaten) { sql += ' AND lokasi_id LIKE ?'; params.push(`%${kabupaten}%`); }
  if (q) { sql += ' AND (namaDesa_id LIKE ? OR lokasi_id LIKE ? OR deskripsi_id LIKE ?)';
    params.push(`%${q}%`, `%${q}%`, `%${q}%`); }
  sql += ' ORDER BY rating DESC';
  const [rows] = await pool.query(sql, params);
  ApiResponse.success(res, rows);
});

exports.detail = asyncHandler(async (req, res) => {
  const [rows] = await pool.query('SELECT * FROM desa_wisata WHERE id = ?', [req.params.id]);
  if (!rows.length) throw ApiError.notFound('Desa wisata tidak ditemukan');
  // sertakan jarak & ulasan
  const [jarak] = await pool.query('SELECT * FROM jarak_desa WHERE desaId = ?', [req.params.id]);
  const [ulasan] = await pool.query(
    'SELECT * FROM ulasan WHERE desaId = ? ORDER BY createdAt DESC', [req.params.id]);
  ApiResponse.success(res, { ...rows[0], jarak, ulasan });
});

exports.create = asyncHandler(async (req, res) => {
  const {
    namaDesa_id, namaDesa_en, lokasi_id, lokasi_en, deskripsi_id, deskripsi_en,
    latitude, longitude, jenisDesa, kategori, foto, link_video,
  } = req.body;
  if (!namaDesa_id || latitude == null || longitude == null)
    throw ApiError.badRequest('namaDesa_id, latitude, longitude wajib');
  const [r] = await pool.query(
    `INSERT INTO desa_wisata
     (namaDesa_id, namaDesa_en, lokasi_id, lokasi_en, deskripsi_id, deskripsi_en,
      latitude, longitude, jenisDesa, kategori, foto, link_video)
     VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
    [namaDesa_id, namaDesa_en, lokasi_id, lokasi_en, deskripsi_id, deskripsi_en,
     latitude, longitude, jenisDesa || 'DESA_WISATA', kategori || 'EKOWISATA', foto, link_video]
  );
  const [rows] = await pool.query('SELECT * FROM desa_wisata WHERE id = ?', [r.insertId]);
  ApiResponse.created(res, rows[0]);
});

exports.update = asyncHandler(async (req, res) => {
  const [exists] = await pool.query('SELECT id FROM desa_wisata WHERE id = ?', [req.params.id]);
  if (!exists.length) throw ApiError.notFound('Desa wisata tidak ditemukan');
  const fields = ['namaDesa_id','namaDesa_en','lokasi_id','lokasi_en','deskripsi_id',
    'deskripsi_en','latitude','longitude','jenisDesa','kategori','foto','link_video'];
  const sets = []; const vals = [];
  for (const f of fields) {
    if (req.body[f] !== undefined) { sets.push(`${f} = ?`); vals.push(req.body[f]); }
  }
  if (!sets.length) throw ApiError.badRequest('Tidak ada field untuk diupdate');
  vals.push(req.params.id);
  await pool.query(`UPDATE desa_wisata SET ${sets.join(', ')} WHERE id = ?`, vals);
  const [rows] = await pool.query('SELECT * FROM desa_wisata WHERE id = ?', [req.params.id]);
  ApiResponse.success(res, rows[0], 'Desa wisata diperbarui');
});

exports.remove = asyncHandler(async (req, res) => {
  const [r] = await pool.query('DELETE FROM desa_wisata WHERE id = ?', [req.params.id]);
  if (!r.affectedRows) throw ApiError.notFound('Desa wisata tidak ditemukan');
  ApiResponse.success(res, null, 'Desa wisata dihapus');
});
