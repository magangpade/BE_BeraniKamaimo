/// Interface penyimpanan token admin.
/// Implementasi M0 = in-memory. M3 diganti flutter_secure_storage.
abstract class TokenStore {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
}

/// Stub in-memory untuk M0-M2.
class InMemoryTokenStore implements TokenStore {
  String? _token;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }

  @override
  Future<void> clearToken() async {
    _token = null;
  }
}