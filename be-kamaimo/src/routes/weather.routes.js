const r = require('express').Router();
const c = require('../controllers/weather.controller');

r.get('/', c.current);

module.exports = r;
