const r = require('express').Router();
const c = require('../controllers/kunjunganTuris.controller');

r.get('/', c.list);

module.exports = r;
