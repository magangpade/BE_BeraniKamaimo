const test = require('node:test');
const assert = require('node:assert/strict');
const app = require('../src/app');
const pool = require('../src/config/db');
const { sign } = require('../src/utils/jwt');

test('konten admin baru tersimpan dan tersedia pada endpoint pengguna', async () => {
  const server = app.listen(0, '127.0.0.1');
  await new Promise((resolve) => server.once('listening', resolve));
  const base = `http://127.0.0.1:${server.address().port}/api`;
  const token = sign({ role: 'Admin' });
  const made = [];
  const request = async (method, path, body) => {
    const response = await fetch(`${base}${path}`, {
      method,
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' },
      body: body == null ? undefined : JSON.stringify(body),
    });
    const json = await response.json();
    assert.ok(response.ok, `${method} ${path}: ${response.status} ${json.message}`);
    return json.data;
  };
  const create = async (path, body) => {
    const row = await request('POST', path, body);
    made.push([path, row.id]);
    return row;
  };
  try {
    const marker = `Uji Admin ${Date.now()}`;
    const [villages] = await pool.query('SELECT id FROM desa_wisata LIMIT 1');
    assert.ok(villages.length, 'Perlu satu desa untuk pengujian jalur');
    const route = await create('/jarak', {
      desaId: villages[0].id, titikKota: marker,
      jalur_darat: 'Akses darat untuk pengujian', jalur_laut: '', jalur_udara: '',
      jalur_darat_judul: 'Rute darat uji', jalur_darat_durasi: '2 jam',
    });
    assert.equal(route.titikKota, marker);
    assert.equal(route.jalur_darat_judul, 'Rute darat uji');
    const accessible = await request('GET', `/jarak?desaId=${villages[0].id}`);
    assert.ok(accessible.some((row) => row.id === route.id));

    const program = [{ title: 'Program uji', description: 'Deskripsi program', image: '/uploads/test.jpg' }];
    const rundown = [{ hari: 'Hari 1', items: [{
      jam: '08.00 WITA', chip: 'Area utama', judul: 'Pembukaan',
      deskripsi: 'Kegiatan pembuka', chipColor: 'mint', dotColor: 'mint',
    }] }];
    const event = await create('/atraksi', {
      nameEvent: marker, location_id: 'Poso', description_id: 'Festival uji',
      startdate: '2026-12-01', enddate: '2026-12-02', kategori: 'BUDAYA',
      wilayah: 'Poso', foto: '/uploads/test.jpg', program_json: program,
      rundown_json: rundown, maps_url: 'https://maps.google.com/?q=Poso',
      latitude: -1.4, longitude: 120.7,
    });
    assert.equal(JSON.parse(event.program_json)[0].title, 'Program uji');
    assert.equal(JSON.parse(event.rundown_json)[0].items[0].judul, 'Pembukaan');
    assert.equal((await request('GET', `/atraksi/${event.id}`)).wilayah, 'Poso');

    const packageRow = await create('/tourPackage', {
      nama_wisata_id: marker, lokasi_id: 'Poso', deskripsi_id: 'Paket uji',
      harga: 100000, kontak: '628123456789', media: '/uploads/test.jpg',
      kategori: 'BUDAYA', wilayah: 'Poso', durasi: '2 Hari 1 Malam',
      tipe: 'Tur pribadi', fasilitas: 'Transportasi, Pemandu', satuan: '/orang',
    });
    assert.equal(packageRow.durasi, '2 Hari 1 Malam');
    assert.equal((await request('GET', `/tourPackage/${packageRow.id}`)).kontak, '628123456789');

    const food = await create('/kuliner', {
      nama_makanan: marker, lokasi: 'Poso', deskripsi_id: 'Kuliner uji',
      wilayah: 'Poso', warung: 'Warung uji', telepon: '628123456789',
      website: 'https://example.com', link_gmaps: 'https://maps.google.com/?q=Poso',
      foto: '/uploads/test.jpg',
    });
    assert.equal((await request('GET', `/kuliner/${food.id}`)).telepon, '628123456789');
    const restaurant = await create('/rumahMakan', {
      resto: marker, kulinerId: food.id, lokasi: 'Poso',
      link_gmaps: 'https://maps.google.com/?q=Poso', telepon: '628123456789',
    });
    assert.equal(restaurant.lokasi, 'Poso');
    const displayedFood = await request('GET', `/kuliner/${food.id}`);
    assert.equal(displayedFood.warung, marker);
    assert.equal(displayedFood.link_gmaps, restaurant.link_gmaps);
    const otherRestaurant = await create('/rumahMakan', {
      resto: `${marker} kedua`, kulinerId: food.id, lokasi: 'Sigi',
      link_gmaps: 'https://maps.google.com/?q=Sigi',
    });
    const listedFood = await request('GET', `/kuliner?q=${encodeURIComponent(marker)}`);
    assert.ok(listedFood.some((row) => row.warung === marker));
    assert.ok(listedFood.some((row) => row.warung === otherRestaurant.resto));

    const hotel = await create('/hotel', {
      nama_hotel: marker, lokasi: 'Poso', wilayah: 'Poso',
      telepon: '628123456789', harga_minimum: 250000,
      website: 'https://example.com', link_gmaps: 'https://maps.google.com/?q=Poso',
      foto: '/uploads/test.jpg', tag: 'Hotel', highlight: 'Dekat pusat kota',
    });
    assert.equal((await request('GET', `/hotel/${hotel.id}`)).wilayah, 'Poso');
  } finally {
    for (const [path, id] of made.reverse()) {
      try { await request('DELETE', `${path}/${id}`); } catch (_) { /* cleanup best effort */ }
    }
    await new Promise((resolve) => server.close(resolve));
    await pool.end();
  }
});
