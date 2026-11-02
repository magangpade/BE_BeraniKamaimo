const r = require('express').Router();
const c = require('../controllers/pageview.controller');

r.post('/', c.track);
r.get('/chart', c.chart);

module.exports = r;
