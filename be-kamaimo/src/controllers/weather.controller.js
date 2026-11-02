const axios = require('axios');
const { OPENWEATHER, GIS } = require('../config/env');
const asyncHandler = require('../utils/asyncHandler');
const ApiResponse = require('../utils/ApiResponse');

/**
 * GET /api/weather?city=Palu  atau  ?lat=-1.43&lng=121.44
 * Mengembalikan cuaca real-time + prakiraan 3 hari.
 */
exports.current = asyncHandler(async (req, res) => {
  const { city, lat, lng } = req.query;

  // fallback dummy jika API key belum diisi
  if (!OPENWEATHER.key) {
    return ApiResponse.success(res, {
      source: 'fallback',
      location: city || 'Palu',
      temp: 29,
      feels_like: 31,
      description: 'Cerah Berawan',
      icon: '02d',
      humidity: 78,
      wind_speed: 3.6,
      forecast: [],
    }, 'Weather fallback (API key belum diisi)');
  }

  let url;
  if (lat && lng) {
    url = `${OPENWEATHER.baseUrl}/weather?lat=${lat}&lon=${lng}&units=metric&lang=id&appid=${OPENWEATHER.key}`;
  } else {
    const q = city || 'Palu';
    url = `${OPENWEATHER.baseUrl}/weather?q=${encodeURIComponent(q)},ID&units=metric&lang=id&appid=${OPENWEATHER.key}`;
  }

  try {
    const { data } = await axios.get(url, { timeout: 8000 });

    // forecast 3 hari via coords
    let forecast = [];
    try {
      const fUrl = `${OPENWEATHER.baseUrl}/forecast?lat=${data.coord.lat}&lon=${data.coord.lon}&units=metric&lang=id&appid=${OPENWEATHER.key}`;
      const fRes = await axios.get(fUrl, { timeout: 8000 });
      // Ambil 1 sample per hari (jam 12:00)
      const byDay = {};
      for (const item of fRes.data.list) {
        const day = item.dt_txt.slice(0, 10);
        if (!byDay[day] && item.dt_txt.includes('12:00:00')) byDay[day] = item;
      }
      forecast = Object.values(byDay).slice(0, 3).map((it) => ({
        date: it.dt_txt.slice(0, 10),
        temp: Math.round(it.main.temp),
        description: it.weather[0].description,
        icon: it.weather[0].icon,
      }));
    } catch (_) { /* forecast gagal, abaikan */ }

    ApiResponse.success(res, {
      source: 'openweather',
      location: data.name || city || 'Palu',
      temp: Math.round(data.main.temp),
      feels_like: Math.round(data.main.feels_like),
      description: data.weather[0].description,
      icon: data.weather[0].icon,
      humidity: data.main.humidity,
      wind_speed: data.wind.speed,
      coord: data.coord,
      forecast,
    });
  } catch (err) {
    // fallback jika API error / limit
    ApiResponse.success(res, {
      source: 'fallback_error',
      location: city || 'Palu',
      temp: 29,
      description: 'Cerah Berawan',
      icon: '02d',
      error: err.response?.data?.message || err.message,
    }, 'Weather API error, menggunakan fallback');
  }
});
