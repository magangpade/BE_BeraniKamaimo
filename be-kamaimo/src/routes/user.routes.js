const r = require('express').Router();
const c = require('../controllers/user.controller');
const { authenticate, requireRole } = require('../middleware/auth.middleware');

r.post('/login', c.login);
r.get('/me', authenticate, c.me);
r.get('/', authenticate, requireRole('superAdmin'), c.list);
r.post('/', authenticate, requireRole('superAdmin'), c.create);

module.exports = r;
