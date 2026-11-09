const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs/promises');
const path = require('node:path');
const app = require('../src/app');
const pool = require('../src/config/db');
const { sign } = require('../src/utils/jwt');

test('foto desa memerlukan admin dan hanya menyimpan berkas gambar valid', async () => {
  const server = app.listen(0, '127.0.0.1');
  await new Promise((resolve) => server.once('listening', resolve));
  const base = `http://127.0.0.1:${server.address().port}`;
  const png = Buffer.from(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAusB9Wl2tkwAAAAASUVORK5CYII=',
    'base64'
  );
  const send = (token, bytes, type, endpoint = '/api/desaWisata/upload') => {
    const form = new FormData();
    form.append('foto', new Blob([bytes], { type }), 'desa.png');
    return fetch(`${base}${endpoint}`, {
      method: 'POST',
      headers: token ? { Authorization: `Bearer ${token}` } : {},
      body: form,
    });
  };
  let uploadedPath;
  let sharedImagePath;
  try {
    assert.equal((await send(null, png, 'image/png')).status, 401);
    assert.equal((await send(sign({ role: 'user' }), png, 'image/png')).status, 403);
    assert.equal((await send(sign({ role: 'Admin' }), Buffer.from('not a photo'), 'image/png')).status, 400);
    const response = await send(sign({ role: 'Admin' }), png, 'image/png');
    assert.equal(response.status, 201);
    const json = await response.json();
    assert.match(json.data.foto, /^\/uploads\/[a-f0-9-]+\.png$/);
    uploadedPath = path.join(__dirname, '../public', json.data.foto.substring(1));
    assert.deepEqual(await fs.readFile(uploadedPath), png);
    assert.equal((await send(null, png, 'image/png', '/api/uploads/image')).status, 401);
    const shared = await send(sign({ role: 'Admin' }), png, 'image/png', '/api/uploads/image');
    assert.equal(shared.status, 201);
    sharedImagePath = path.join(__dirname, '../public', (await shared.json()).data.foto.substring(1));
    assert.deepEqual(await fs.readFile(sharedImagePath), png);
  } finally {
    if (uploadedPath) await fs.unlink(uploadedPath);
    if (sharedImagePath) await fs.unlink(sharedImagePath);
    await new Promise((resolve) => server.close(resolve));
    await pool.end();
  }
});
