const pool = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');
const ApiError = require('../utils/ApiError');
const { GIS } = require('../config/env');

/**
 * GET /api/gis/markers
 *   → semua marker desa wisata + atraksi untuk Leaflet
 *   filter: ?jenis=DESA_WISATA|DESA_UNGGULAN|ATRAKSI
 */
exports.markers = asyncHandler(async (req, res) => {
  const { jenis } = req.query;
  let sql = `
    SELECT id, namaDesa_id AS nama, lokasi_id AS lokasi, latitude, longitude,
           jenisDesa AS jenis, foto, rating, total_ulasan
    FROM desa_wisata
  `;
  const params = [];
  if (jenis && jenis !== 'ATRAKSI') {
    sql += ' WHERE jenisDesa = ?'; params.push(jenis);
  }
  const [desa] = await pool.query(sql, params);

  // atraksi tidak punya lat/lng di tabel, kita bungkus dengan koordinat wilayahnya
  const [atraksi] = await pool.query(
    'SELECT id, nameEvent AS nama, location_id AS lokasi, foto FROM atraksi');

  const markers = [];
  for (const d of desa) {
    markers.push({
      id: `desa-${d.id}`,
      refId: d.id,
      type: 'desa_wisata',
      kategori: d.jenis,
      nama: d.nama,
      lokasi: d.lokasi,
      lat: parseFloat(d.latitude),
      lng: parseFloat(d.longitude),
      rating: parseFloat(d.rating),
      total_ulasan: d.total_ulasan,
      foto: d.foto,
    });
  }

  // Pemetaan koordinat lokasi event di Sulawesi Tengah
  const getEventCoords = (lokasi = '', id = 0) => {
    const loc = lokasi.toLowerCase();
    if (loc.includes('palu') || loc.includes('gor')) return { lat: -0.8975, lng: 119.8758 };
    if (loc.includes('tentena')) return { lat: -1.7634, lng: 120.6401 };
    if (loc.includes('bada') || loc.includes('lore')) return { lat: -1.8250, lng: 120.1950 };
    if (loc.includes('poso')) return { lat: -1.3959, lng: 120.7524 };
    if (loc.includes('togean') || loc.includes('tojo') || loc.includes('ampana')) return { lat: -0.4167, lng: 121.8833 };
    if (loc.includes('banggai') && loc.includes('moutong')) return { lat: -0.8180, lng: 120.1750 };
    if (loc.includes('banggai') || loc.includes('luwuk')) return { lat: -0.9516, lng: 122.7875 };
    if (loc.includes('moutong') || loc.includes('parigi') || loc.includes('tomini')) return { lat: -0.8180, lng: 120.1750 };
    if (loc.includes('sigi') || loc.includes('lindu')) return { lat: -1.3189, lng: 120.0897 };
    return { lat: GIS.defaultLat + (id * 0.05), lng: GIS.defaultLng + (id * 0.05) };
  };

  for (const a of atraksi) {
    const coords = getEventCoords(a.lokasi, a.id);
    markers.push({
      id: `atraksi-${a.id}`,
      refId: a.id,
      type: 'atraksi',
      kategori: 'EVENT',
      nama: a.nama,
      lokasi: a.lokasi,
      lat: coords.lat,
      lng: coords.lng,
      rating: 4.8,
      total_ulasan: 120,
      foto: a.foto || null,
    });
  }

  ApiResponse.success(res, {
    center: { lat: GIS.defaultLat, lng: GIS.defaultLng },
    total: markers.length,
    markers,
  });
});

/**
 * GET /api/gis/markers/:type/:id
 *   → detail lengkap titik (untuk popup di peta home)
 */
exports.markerDetail = asyncHandler(async (req, res) => {
  const { type, id } = req.params;
  if (type === 'desa') {
    const [rows] = await pool.query(
      'SELECT * FROM desa_wisata WHERE id = ?', [id]);
    if (!rows.length) throw ApiError.notFound('Titik desa tidak ditemukan');
    const [ulasan] = await pool.query(
      'SELECT * FROM ulasan WHERE desaId = ? ORDER BY createdAt DESC LIMIT 5', [id]);
    return ApiResponse.success(res, { ...rows[0], ulasan });
  }
  if (type === 'atraksi') {
    const [rows] = await pool.query(
      'SELECT * FROM atraksi WHERE id = ?', [id]);
    if (!rows.length) throw ApiError.notFound('Event tidak ditemukan');
    return ApiResponse.success(res, rows[0]);
  }
  throw ApiError.badRequest('type harus "desa" atau "atraksi"');
});

/**
 * GET /api/gis/nearby?lat=&lng=&radius=
 *   → cari desa wisata dalam radius (km)
 */
exports.nearby = asyncHandler(async (req, res) => {
  const { lat, lng, radius = 50 } = req.query;
  if (!lat || !lng) throw ApiError.badRequest('lat & lng wajib');
  const r = parseFloat(radius);
  const [rows] = await pool.query(
    `SELECT id, namaDesa_id AS nama, lokasi_id AS lokasi, latitude, longitude,
            foto, rating, total_ulasan,
       (6371 * ACOS(
         COS(RADIANS(?)) * COS(RADIANS(latitude)) *
         COS(RADIANS(longitude) - RADIANS(?)) +
         SIN(RADIANS(?)) * SIN(RADIANS(latitude))
       )) AS distance_km
       FROM desa_wisata
       HAVING distance_km < ?
       ORDER BY distance_km ASC`,
    [lat, lng, lat, r]
  );
  ApiResponse.success(res, rows);
});
