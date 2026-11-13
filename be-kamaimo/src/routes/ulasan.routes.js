const r = require('express').Router();
const c = require('../controllers/ulasan.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');

r.get('/', c.list);
r.get('/:id', c.detail);
r.post('/insert', c.insert); // publik
r.post('/:id/balas', authenticate, requireRole('Admin','superAdmin'), c.balas);
r.patch('/:id', authenticate, requireRole('Admin','superAdmin'), c.update);
r.delete('/:id', authenticate, requireRole('Admin','superAdmin'), c.remove);

module.exports = r;
