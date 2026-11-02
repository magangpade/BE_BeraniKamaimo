const r = require('express').Router();
const c = require('../controllers/rumahMakan.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');

r.get('/', c.list);
r.post('/', authenticate, requireRole('Admin','superAdmin'), c.create);
r.delete('/:id', authenticate, requireRole('Admin','superAdmin'), c.remove);

module.exports = r;
