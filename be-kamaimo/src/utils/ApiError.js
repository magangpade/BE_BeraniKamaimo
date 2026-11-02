class ApiError extends Error {
  constructor(statusCode, message, details = null) {
    super(message);
    this.statusCode = statusCode;
    this.details = details;
    this.isOperational = true;
    Error.captureStackTrace(this, this.constructor);
  }

  static badRequest(msg = 'Permintaan tidak valid', details) {
    return new ApiError(400, msg, details);
  }
  static unauthorized(msg = 'Tidak terautentikasi') {
    return new ApiError(401, msg);
  }
  static forbidden(msg = 'Tidak punya akses') {
    return new ApiError(403, msg);
  }
  static notFound(msg = 'Data tidak ditemukan') {
    return new ApiError(404, msg);
  }
  static server(msg = 'Server sedang bermasalah') {
    return new ApiError(500, msg);
  }
}

module.exports = ApiError;