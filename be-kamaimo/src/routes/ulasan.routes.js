const r = require('express').Router();
const c = require('../controllers/ulasan.controller');

r.get('/', c.list);
r.get('/:id', c.detail);
r.post('/insert', c.insert); // publik
r.delete('/:id', c.remove);

module.exports = r;
