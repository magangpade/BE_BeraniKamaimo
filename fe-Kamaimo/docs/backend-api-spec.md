# Spesifikasi API Endpoint Eksternal -- Untuk Tim Backend

Dokumen ini berisi spesifikasi endpoint yang perlu disediakan oleh tim backend untuk mendukung fitur-fitur di aplikasi **Berani Kamaimo** (frontend Flutter).

**Versi:** 1.0
**Tanggal:** 2025-10-13
**Penyusun:** Frontend Team (berdasarkan analisis kode & PRD)

---

## 1. Endpoint Cuaca (Weather)

### `GET /weather`

Mengembalikan data cuaca realtime berdasarkan koordinat pengguna.

#### Request

| Parameter | Tipe | Wajib? | Keterangan |
|-----------|------|--------|------------|
| `lat` | number (float) | Ya | Latitude lokasi pengguna, contoh: `-0.897` |
| `lon` | number (float) | Ya | Longitude lokasi pengguna, contoh: `119.866` |

**Contoh:**
```
GET /api/weather?lat=-0.897&lon=119.866
```

#### Response (200 OK)

```json
{
  "success": true,
  "data": {
    "temperature": 29,
    "weatherCode": 3,
    "weatherDescription": "Cerah Berawan",
    "locationName": "Palu",
    "humidity": 78,
    "windSpeed": 12.5,
    "isDay": true
  }
}
```

#### Field Response

| Field | Tipe | Keterangan |
|-------|------|------------|
| `temperature` | integer | Suhu dalam Celsius. Tampilin di UI sebagai `{value}°C`. |
| `weatherCode` | integer | Kode WMO (lihat tabel di bawah). Frontend pakai ini buat pilih icon. |
| `weatherDescription` | string | Deskripsi cuaca dalam Bahasa Indonesia. Maks 30 karakter. |
| `locationName` | string | Nama kota/kecamatan dari reverse geocoding. Dipakai di bawah suhu. |
| `humidity` | integer | Kelembaban persen (opsional, buat future use). |
| `windSpeed` | float | Kecepatan angin km/jam (opsional). |
| `isDay` | boolean | True = siang, false = malam. Dipakai buat pilih icon siang/malam. |

#### Weather Code (WMO) --> Icon Mapping

Ini kontrak antara backend dan frontend. Backend return `weatherCode`, frontend pilih icon:

| Code | Kondisi | Icon (Flutter) | Warna |
|------|---------|-----------------|-------|
| 0 | Cerah (Clear sky) | `wb_sunny` | #F59E0B (amber) |
| 1 | Utamanya cerah | `wb_sunny` | #F59E0B |
| 2 | Sebagian berawan | `wb_partly_cloudy_day` / `cloud` | #94A3B8 |
| 3 | Berawan (Overcast) | `cloud` | #94A3B8 |
| 45 | Kabut | `cloud_queue` | #CBD5E1 |
| 48 | Kabut tebal | `cloud_queue` | #CBD5E1 |
| 51 | Gerimis ringan | `grain` | #60A5FA |
| 53 | Gerimis sedang | `grain` | #3B82F6 |
| 55 | Gerimis lebat | `grain` | #2563EB |
| 61 | Hujan ringan | `water_drop` | #60A5FA |
| 63 | Hujan sedang | `water_drop` | #3B82F6 |
| 65 | Hujan lebat | `water_drop` | #2563EB |
| 71 | Salju ringan | `ac_unit` | #E2E8F0 |
| 73-77 | Salju sedang/lebat | `ac_unit` | #CBD5E1 |
| 80 | Hujan deras ringan | `thunderstorm` | #6366F1 |
| 81-82 | Hujan deras sedang/lebat | `thunderstorm` | #4F46E5 |
| 95 | Badai petir | `thunderstorm` | #7C3AED |
| 96-99 | Badai petir + hujan es | `thunderstorm` | #6D28D9 |

> **Catatan:** Frontend akan handle fallback. Kalau code tidak ada di tabel, tampilkan icon `cloud` default.

#### Error Response

```json
// 400 - parameter kurang
{ "success": false, "message": "Parameter 'lat' dan 'lon' wajib diisi" }

// 502 - error dari upstream weather API
{ "success": false, "message": "Gagal mengambil data cuaca" }
```

---

## 2. Implementasi Backend (Saran Teknis)

### Sumber Data Cuaca: Open-Meteo (GRATIS, TANPA API KEY)

Backend cukup proxy ke Open-Meteo. Contoh implementasi (pseudocode):

```javascript
// BACKEND: GET /api/weather?lat=-0.897&lon=119.866

const OPEN_METEO_BASE = 'https://api.open-meteo.com/v1/forecast';

async function getWeather(req, res) {
  const { lat, lon } = req.query;

  if (!lat || !lon) {
    return res.status(400).json({
      success: false,
      message: "Parameter 'lat' dan 'lon' wajib diisi"
    });
  }

  try {
    // 1. Panggil Open-Meteo (gratis, no key needed)
    const weatherRes = await fetch(
      `${OPEN_METEO_BASE}?latitude=${lat}&longitude=${lon}` +
      `&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,is_day` +
      `&timezone=auto`
    );
    const weatherData = await weatherRes.json();

    // 2. Reverse geocoding lewat Nominatim (gratis, no key needed)
    const geoRes = await fetch(
      `https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}`,
      { headers: { 'User-Agent': 'BeraniKamaimo/1.0' } }
    );
    const geoData = await geoRes.json();

    // 3. Map ke response contract
    const current = weatherData.current;
    res.json({
      success: true,
      data: {
        temperature: Math.round(current.temperature_2m),
        weatherCode: current.weather_code,
        weatherDescription: translateWmoCode(current.weather_code), // fungsi terjemah ke Bahasa Indonesia
        locationName: geoData.address?.city || geoData.address?.town || geoData.address?.county || 'Lokasi',
        humidity: current.relative_humidity_2m,
        windSpeed: current.wind_speed_10m,
        isDay: !!current.is_day
      }
    });

  } catch (error) {
    res.status(502).json({
      success: false,
      message: 'Gagal mengambil data cuaca'
    });
  }
}
```

### Sumber Data Geocoding: Nominatim/OpenStreetMap (GRATIS, TANPA API KEY)

- **Endpoint:** `https://nominatim.openstreetmap.org/reverse`
- **Wajib header:** `User-Agent: BeraniKamaimo/1.0` (Nominatim menolak request tanpa User-Agent)
- **Rate limit:** 1 request/detik (backend harus throttle/rate limit)
- **Field yang dipakai:** `address.city`, `address.town`, `address.county`, `address.state`

### Terjemahan WMO Weather Code --> Bahasa Indonesia

```javascript
function translateWmoCode(code) {
  const map = {
    0: 'Cerah', 1: 'Cerah', 2: 'Cerah Berawan', 3: 'Berawan',
    45: 'Berkabut', 48: 'Kabut Tebal',
    51: 'Gerimis Ringan', 53: 'Gerimis', 55: 'Gerimis Lebat',
    61: 'Hujan Ringan', 63: 'Hujan', 65: 'Hujan Lebat',
    71: 'Salju Ringan', 73: 'Salju', 75: 'Salju Lebat',
    80: 'Hujan Deras', 81: 'Hujan Deras', 82: 'Hujan Sangat Deras',
    95: 'Badai Petir', 96: 'Badai Petir', 99: 'Badai Petir & Es'
  };
  return map[code] || 'Berawan'; // default fallback
}
```

---

## 3. Yang TIDAK Perlu Backend Sediakan

| Fitur | Kenapa tidak perlu? |
|-------|---------------------|
| Google Maps | Cukup deep link (`https://maps.google.com/?q=...`) dari field `link_gmaps` di database |
| WhatsApp link | Cukup `wa.me/<nomor>` dari field `kontak` di database |
| Telepon link | Cukup `tel:<nomor>` dari field `telepon` di database |
| Map tiles (flutter_map) | CartoDB light tiles gratis tanpa key |
| Jarak antar desa | Sudah ada endpoint `/jarak`, data dari database sendiri |
| Semua data wisata | Sudah ada endpoint masing-masing (`/desaWisata`, `/atraksi`, `/kuliner`, dll.) |

---

## 4. Checklist Untuk Tim Backend

- [ ] Buat endpoint `GET /api/weather?lat=&lon=` yang proxy ke Open-Meteo
- [ ] Integrasikan reverse geocoding Nominatum (jangan lupa header User-Agent)
- [ ] Return response sesuai kontrak JSON di atas
- [ ] Handle error ketika Open-Meteo/Nominatim down (return error message, jangan crash)
- [ ] Rate limit maksimal 1 request/detik ke Nominatim (aturan penggunaan OSM)
- [ ] Cache response cuaca minimal 5 menit (jangan panggil API eksternal setiap kali user refresh)
- [ ] Weather description dalam Bahasa Indonesia

---

## 5. Future Consideration (Tidak Sekarang)

Fitur-fitur ini muncul di PRD tapi **belum perlu** diimplementasikan sekarang:

| Fitur | API yang dibutuhkan nanti | Kapan? |
|-------|--------------------------|--------|
| Forecast cuaca multi-hari | Open-Meteo sudah support (`daily=...`) | Kalau user minta detail forecast |
| Alert cuaca ekstrem | BMKG atau OpenWeatherMap alert | Phase lanjutan |
| Autocomplete pencarian lokasi | Nominatim search endpoint | Kalau ada fitur cari kota |
| Navigation / rute | OSRM atau Google Directions API | Kalau ada fitur navigasi |

---

_Dokumen ini disusun berdasarkan analisis kode sumber `lib/features/user/home/user_shell.dart` (widget `_WeatherCard`), `lib/core/network/api_config.dart`, `pubspec.yaml`, dan `PRD.md`._
