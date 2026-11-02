const r = require('express').Router();
const c = require('../controllers/gis.controller');

r.get('/markers', c.markers);
r.get('/markers/:type/:id', c.markerDetail);
r.get('/nearby', c.nearby);

module.exports = r;
