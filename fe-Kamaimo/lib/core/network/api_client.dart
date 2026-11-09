import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../config/env.dart';
import 'api_exception.dart';
import 'token_store.dart';

/// Http client wrapper. Semua request melalui sini.
class ApiClient {
  ApiClient({http.Client? httpClient, required this._tokenStore})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final TokenStore _tokenStore;

  static const Duration _timeout = Duration(seconds: 30);

  /// Upload foto admin sebagai multipart dan kembalikan path yang dapat
  /// langsung disimpan pada field `foto` konten.
  Future<String> uploadDesaPhoto({
    required String filename,
    required Uint8List bytes,
  }) => _uploadImage('/desaWisata/upload', filename: filename, bytes: bytes);

  Future<String> uploadImage({
    required String filename,
    required Uint8List bytes,
  }) => _uploadImage('/uploads/image', filename: filename, bytes: bytes);

  Future<String> _uploadImage(String endpoint, {
    required String filename,
    required Uint8List bytes,
  }) async {
    final extension = filename.split('.').last.toLowerCase();
    final mimeType = switch (extension) {
      'jpg' || 'jpeg' => MediaType('image', 'jpeg'),
      'png' => MediaType('image', 'png'),
      'webp' => MediaType('image', 'webp'),
      _ => throw ApiException.clientError('Format foto tidak didukung.', 400),
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Env.apiBaseUrl}$endpoint'),
    );
    final token = await _tokenStore.getToken();
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    request.files.add(
      http.MultipartFile.fromBytes(
        'foto',
        bytes,
        filename: filename,
        contentType: mimeType,
      ),
    );
    final stream = await _httpClient.send(request).timeout(_timeout);
    final response = await http.Response.fromStream(stream).timeout(_timeout);
    final result = _handleResponse(response);
    if (result is Map && result['foto'] is String) {
      return result['foto'] as String;
    }
    throw ApiException.parseError('Path foto tidak tersedia.');
  }

  /// GET request (otomatis mengekstrak data dari { success, data, message }).
  Future<dynamic> get(String endpoint) async {
    try {
      final uri = Uri.parse('${Env.apiBaseUrl}$endpoint');
      final headers = await _buildHeaders();

      final response = await _httpClient
          .get(uri, headers: headers)
          .timeout(
            _timeout,
            onTimeout: () {
              throw ApiException.timeout();
            },
          );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  /// POST request.
  Future<Map<String, dynamic>> post(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final uri = Uri.parse('${Env.apiBaseUrl}$endpoint');
      final headers = await _buildHeaders();

      final response = await _httpClient
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(
            _timeout,
            onTimeout: () {
              throw ApiException.timeout();
            },
          );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded is Map<String, dynamic> ? decoded : {'data': decoded};
      }
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] as String? ?? 'Error')
          : 'Error';
      throw ApiException.clientError(message, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request.
  Future<Map<String, dynamic>> put(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final uri = Uri.parse('${Env.apiBaseUrl}$endpoint');
      final headers = await _buildHeaders();

      final response = await _httpClient
          .put(uri, headers: headers, body: jsonEncode(body))
          .timeout(
            _timeout,
            onTimeout: () {
              throw ApiException.timeout();
            },
          );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded is Map<String, dynamic> ? decoded : {'data': decoded};
      }
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] as String? ?? 'Error')
          : 'Error';
      throw ApiException.clientError(message, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request.
  Future<Map<String, dynamic>> patch(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final uri = Uri.parse('${Env.apiBaseUrl}$endpoint');
      final headers = await _buildHeaders();

      final response = await _httpClient
          .patch(uri, headers: headers, body: jsonEncode(body))
          .timeout(
            _timeout,
            onTimeout: () {
              throw ApiException.timeout();
            },
          );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded is Map<String, dynamic> ? decoded : {'data': decoded};
      }
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] as String? ?? 'Error')
          : 'Error';
      throw ApiException.clientError(message, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request.
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final uri = Uri.parse('${Env.apiBaseUrl}$endpoint');
      final headers = await _buildHeaders();

      final response = await _httpClient
          .delete(uri, headers: headers)
          .timeout(
            _timeout,
            onTimeout: () {
              throw ApiException.timeout();
            },
          );

      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded is Map<String, dynamic> ? decoded : {'data': decoded};
      }
      final message = decoded is Map<String, dynamic>
          ? (decoded['message'] as String? ?? 'Error')
          : 'Error';
      throw ApiException.clientError(message, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  /// Build headers + token interceptor.
  Future<Map<String, String>> _buildHeaders() async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = await _tokenStore.getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// Handle response: decode JSON, unwrap data, cek status, throw ApiException.
  dynamic _handleResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (body is Map && body.containsKey('data')) {
          return body['data'];
        }
        return body;
      }

      // Error status
      final message = body is Map
          ? (body['message']?.toString() ?? 'Unknown error')
          : 'Unknown error';
      if (response.statusCode == 401) {
        throw ApiException.unauthorized(message);
      } else if (response.statusCode == 403) {
        throw ApiException.forbidden(message);
      } else if (response.statusCode == 404) {
        throw ApiException.notFound(message);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        throw ApiException.clientError(message, response.statusCode);
      } else if (response.statusCode >= 500) {
        throw ApiException.serverError(message, response.statusCode);
      }

      throw ApiException.unknown(message);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException.parseError('Gagal parse response: $e');
    }
  }
}
