const test = require('node:test');
const assert = require('node:assert/strict');

const rows = {
  jarak_desa: { id: 2, desaId: 1, titikKota: 'PALU', jalur_darat: 'lama' },
  tour_package: { id: 3, nama_wisata_id: 'Paket lama', harga: 100000 },
  kuliner: { id: 4, nama_makanan: 'Makanan lama' },
  rumah_makan: { id: 5, resto: 'Resto lama', kulinerId: 4 },
  hotel: { id: 6, nama_hotel: 'Hotel lama' },
};

const review = { id: 7, desaId: 1, nama: 'Pengulas', rating: 3, komentar: 'lama' };
const recalculated = [];
const dbPath = require.resolve('../src/config/db');
require.cache[dbPath] = {
  id: dbPath, filename: dbPath, loaded: true,
  exports: {
    async query(sql, params) {
      const table = Object.keys(rows).find((name) => sql.includes(`${name} WHERE id = ?`) ||
        sql.startsWith(`UPDATE ${name} SET`));
      if (!table) throw new Error(`Unexpected SQL: ${sql}`);
      const row = rows[table];
      if (sql.startsWith('SELECT id')) return [[row.id == params[0] ? { id: row.id } : []].flat()];
      if (sql.startsWith('SELECT *')) return [row.id == params[0] ? [{ ...row }] : []];
      const fields = [...sql.matchAll(/([A-Za-z_]+) = \?/g)].map((match) => match[1]);
      fields.pop(); // WHERE id
      fields.forEach((field, index) => { row[field] = params[index]; });
      return [{ affectedRows: 1 }];
    },
    async getConnection() {
      return {
        async beginTransaction() {}, async commit() {}, async rollback() {}, release() {},
        async query(sql, params) {
          if (sql.startsWith('SELECT * FROM ulasan') || sql.startsWith('SELECT desaId FROM ulasan')) {
            return [review.id == params[0] ? [{ ...review }] : []];
          }
          if (sql.startsWith('UPDATE ulasan SET')) {
            const fields = [...sql.matchAll(/([A-Za-z_]+) = \?/g)].map((match) => match[1]);
            fields.pop();
            fields.forEach((field, index) => { review[field] = params[index]; });
            return [{ affectedRows: 1 }];
          }
          if (sql.startsWith('DELETE FROM ulasan')) {
            review.deleted = true;
            return [{ affectedRows: 1 }];
          }
          if (sql.startsWith('UPDATE desa_wisata SET')) {
            recalculated.push(params[0]);
            return [{ affectedRows: 1 }];
          }
          throw new Error(`Unexpected SQL: ${sql}`);
        },
      };
    },
  },
};

const updateRecord = require('../src/utils/updateRecord');
const reviewController = require('../src/controllers/ulasan.controller');

test('pembaruan hanya menulis kolom yang diizinkan dan mengembalikan data terbaru', async () => {
  const cases = [
    ['jarak_desa', 2, 'jalur_darat', 'baru'],
    ['tour_package', 3, 'nama_wisata_id', 'Paket baru'],
    ['kuliner', 4, 'nama_makanan', 'Makanan baru'],
    ['rumah_makan', 5, 'resto', 'Resto baru'],
    ['hotel', 6, 'nama_hotel', 'Hotel baru'],
  ];
  for (const [table, id, field, value] of cases) {
    const result = await updateRecord({
      table, id, body: { [field]: value, password: 'ignored' },
      fields: [field], label: table,
    });
    assert.equal(result[field], value);
    assert.equal(result.password, undefined);
  }
  await assert.rejects(
    updateRecord({ table: 'hotel', id: 6, body: { password: 'x' }, fields: ['nama_hotel'], label: 'Hotel' }),
    { statusCode: 400 }
  );
});

test('edit ulasan menghitung ulang rating desa lama dan baru', async () => {
  let response;
  let error;
  const res = { status() { return this; }, json(value) { response = value; return this; } };
  await reviewController.update({ params: { id: 7 }, body: { rating: 5, desaId: 2 } },
    res, (failure) => { error = failure; });
  assert.equal(error, undefined);
  assert.equal(response.data.rating, 5);
  assert.deepEqual(recalculated, [1, 2]);
});

test('hapus ulasan menghitung ulang rating desa terkait', async () => {
  let response;
  let error;
  const res = { status() { return this; }, json(value) { response = value; return this; } };
  await reviewController.remove({ params: { id: 7 } }, res,
    (failure) => { error = failure; });
  assert.equal(error, undefined);
  assert.equal(response.success, true);
  assert.equal(review.deleted, true);
  assert.deepEqual(recalculated, [1, 2, 2]);
});
