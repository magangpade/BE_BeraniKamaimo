const r = require('express').Router();
const c = require('../controllers/visitor.controller');

r.post('/', c.register);
r.get('/summary', c.summary);

module.exports = r;
