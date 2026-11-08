const r = require('express').Router();
const c = require('../controllers/desaWisata.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');

r.get('/', c.list);
r.get('/categories', c.categories);
r.get('/:id', c.detail);
r.post('/', authenticate, requireRole('Admin','superAdmin'), c.create);
r.patch('/:id', authenticate, requireRole('Admin','superAdmin'), c.update);
r.delete('/:id', authenticate, requireRole('Admin','superAdmin'), c.remove);

module.exports = r;
