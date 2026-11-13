const r = require('express').Router();
const c = require('../controllers/user.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');

r.post('/login', c.login);
r.get('/me', authenticate, c.me);
r.put('/me', authenticate, c.updateMe);
r.get('/', authenticate, requireRole('superAdmin'), c.list);
r.post('/', authenticate, requireRole('superAdmin'), c.create);
r.patch('/:id', authenticate, requireRole('superAdmin'), c.update);
r.put('/:id', authenticate, requireRole('superAdmin'), c.update);
r.delete('/:id', authenticate, requireRole('superAdmin'), c.remove);

module.exports = r;
