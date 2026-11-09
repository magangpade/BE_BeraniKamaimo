const ApiError = require('../utils/ApiError');
const multer = require('multer');

module.exports = (err, req, res, _next) => {
  console.error('💥', err.message);
  if (err instanceof ApiError) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message,
      details: err.details,
    });
  }
  if (err instanceof multer.MulterError) {
    return res.status(400).json({
      success: false,
      message: err.code === 'LIMIT_FILE_SIZE' ? 'Ukuran foto maksimal 5 MB' : 'Unggah foto tidak valid',
    });
  }
  // MySQL duplicate
  if (err.code === 'ER_DUP_ENTRY') {
    return res.status(409).json({ success: false, message: 'Data duplikat' });
  }
  return res.status(500).json({
    success: false,
    message: 'Terjadi kesalahan pada server',
    ...(process.env.NODE_ENV !== 'production' ? { error: err.message } : {}),
  });
};
