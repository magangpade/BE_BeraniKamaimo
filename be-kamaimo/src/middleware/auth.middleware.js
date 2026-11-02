const { verify } = require('../utils/jwt');
const ApiError = require('../utils/ApiError');

exports.authenticate = (req, res, next) => {
  const header = req.headers.authorization || '';
  const token = header.startsWith('Bearer ') ? header.slice(7) : null;
  if (!token) return next(ApiError.unauthorized('Token tidak ada'));
  try {
    req.user = verify(token);
    next();
  } catch {
    next(ApiError.unauthorized('Token tidak valid / kedaluwarsa'));
  }
};

exports.requireRole = (...roles) => (req, res, next) => {
  if (!req.user || !roles.includes(req.user.role)) {
    return next(ApiError.forbidden('Role tidak diizinkan'));
  }
  next();
};