/// Exception API dengan pesan ramah bahasa Indonesia.
class ApiException implements Exception {
  ApiException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  factory ApiException.network(String message) =>
      ApiException(type: ApiErrorType.network, message: message);

  factory ApiException.timeout() => ApiException(
        type: ApiErrorType.timeout,
        message: 'Koneksi terlalu lama. Cek jaringan Anda.',
      );

  factory ApiException.unauthorized(String message) => ApiException(
        type: ApiErrorType.unauthorized,
        message: 'Username atau password salah.',
        statusCode: 401,
      );

  factory ApiException.forbidden(String message) => ApiException(
        type: ApiErrorType.forbidden,
        message: 'Anda tidak punya akses.',
        statusCode: 403,
      );

  factory ApiException.notFound(String message) => ApiException(
        type: ApiErrorType.notFound,
        message: 'Data tidak ditemukan.',
        statusCode: 404,
      );

  factory ApiException.clientError(String message, int statusCode) =>
      ApiException(
        type: ApiErrorType.clientError,
        message: message,
        statusCode: statusCode,
      );

  factory ApiException.serverError(String message, int statusCode) =>
      ApiException(
        type: ApiErrorType.serverError,
        message: 'Server sedang bermasalah. Coba lagi nanti.',
        statusCode: statusCode,
      );

  factory ApiException.parseError(String message) => ApiException(
        type: ApiErrorType.parseError,
        message: 'Gagal memproses data.',
      );

  factory ApiException.unknown(String message) => ApiException(
        type: ApiErrorType.unknown,
        message: message.isEmpty ? 'Terjadi kesalahan.' : message,
      );

  final ApiErrorType type;
  final String message;
  final int? statusCode;

  /// Pesan ramah untuk ditampilkan ke user (ErrorCard).
  String get userMessage => message;

  @override
  String toString() =>
      'ApiException(type: $type, message: $message, statusCode: $statusCode)';
}

enum ApiErrorType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  clientError,
  serverError,
  parseError,
  unknown,
}
