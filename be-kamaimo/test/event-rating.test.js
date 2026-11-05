const test = require('node:test');
const assert = require('node:assert/strict');

const ratings = new Map();
const dbPath = require.resolve('../src/config/db');
require.cache[dbPath] = {
  id: dbPath,
  filename: dbPath,
  loaded: true,
  exports: {
    async query(sql, params) {
      if (sql.startsWith('INSERT INTO event_rating')) {
        const [eventKey, visitorKey, rating] = params;
        if (!ratings.has(eventKey)) ratings.set(eventKey, new Map());
        ratings.get(eventKey).set(visitorKey, rating);
        return [{ affectedRows: 1 }];
      }
      if (sql.startsWith('SELECT COUNT(*)')) {
        const values = [...(ratings.get(params[0])?.values() ?? [])];
        return [[{
          ratingCount: values.length,
          rating: values.length
            ? values.reduce((sum, value) => sum + value, 0) / values.length
            : null,
        }]];
      }
      if (sql.startsWith('SELECT rating')) {
        const value = ratings.get(params[0])?.get(params[1]);
        return [value === undefined ? [] : [{ rating: value }]];
      }
      throw new Error(`Unexpected SQL: ${sql}`);
    },
  },
};

const controller = require('../src/controllers/event-rating.controller');

async function invoke(handler, eventKey, body = {}, query = {}) {
  let status = 200;
  let response;
  let error;
  const res = {
    status(value) { status = value; return this; },
    json(value) { response = value; return this; },
  };
  await handler({ params: { eventKey }, body, query }, res, (err) => { error = err; });
  return { status, response, error };
}

const firstVisitor = '11111111-1111-4111-8111-111111111111';
const secondVisitor = '22222222-2222-4222-8222-222222222222';

test('rating Event diisolasi dan pengiriman ulang mengganti suara perangkat yang sama', async () => {
  const eventKey = 'pasar-kreatif-sulteng-2026-10-31';
  const empty = await invoke(controller.summary, eventKey);
  assert.deepEqual(empty.response.data, { eventKey, rating: null, ratingCount: 0, myRating: null });

  await invoke(controller.submit, eventKey, { visitorKey: firstVisitor, rating: 4 });
  await invoke(controller.submit, eventKey, { visitorKey: firstVisitor, rating: 2 });
  const sent = await invoke(controller.submit, eventKey, { visitorKey: secondVisitor, rating: 5 });
  assert.equal(sent.response.data.ratingCount, 2);
  assert.equal(sent.response.data.rating, 3.5);
  assert.equal(sent.response.data.myRating, 5);

  const mine = await invoke(controller.summary, eventKey, {}, { visitorKey: firstVisitor });
  assert.equal(mine.response.data.myRating, 2);
  const other = await invoke(controller.summary, 'festival-danau-poso-2026-10-24');
  assert.equal(other.response.data.ratingCount, 0);
});

test('nilai rating dan identitas yang tidak valid ditolak', async () => {
  for (const rating of [0, 6, 3.5, '4']) {
    const result = await invoke(controller.submit, 'pasar-kreatif', { visitorKey: firstVisitor, rating });
    assert.equal(result.error.statusCode, 400);
  }
  const invalidKey = await invoke(controller.summary, '../atraksi');
  assert.equal(invalidKey.error.statusCode, 400);
  const invalidVisitor = await invoke(controller.submit, 'pasar-kreatif', { visitorKey: 'unknown', rating: 4 });
  assert.equal(invalidVisitor.error.statusCode, 400);
});
