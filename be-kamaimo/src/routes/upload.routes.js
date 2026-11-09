const r = require('express').Router();
const { authenticate, requireRole } = require('../middleware/auth.middleware');
const upload = require('../middleware/upload.middleware');
const c = require('../controllers/upload.controller');

r.post('/image', authenticate, requireRole('Admin', 'superAdmin'), upload.single('foto'), c.image);
module.exports = r;
