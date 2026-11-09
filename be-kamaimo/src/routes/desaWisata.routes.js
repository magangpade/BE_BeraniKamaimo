const r = require('express').Router();
const c = require('../controllers/desaWisata.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');

r.get('/', c.list);
r.post('/upload', authenticate, requireRole('Admin','superAdmin'), upload.single('foto'), c.uploadPhoto);
r.get('/:id', c.detail);
r.post('/', authenticate, requireRole('Admin','superAdmin'), c.create);
r.patch('/:id', authenticate, requireRole('Admin','superAdmin'), c.update);
r.delete('/:id', authenticate, requireRole('Admin','superAdmin'), c.remove);

module.exports = r;
