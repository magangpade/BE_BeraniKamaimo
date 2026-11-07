import 'package:flutter/foundation.dart';

/// Konfigurasi environment via --dart-define.
/// Jalankan: flutter run --dart-define=API_BASE_URL=http://localhost:3000/api
class Env {
  Env._();

  static String get apiBaseUrl {
    const fromDefine = String.fromEnvironment('API_BASE_URL');
    if (fromDefine.isNotEmpty) return fromDefine;

    return 'https://beberanikamaimo-production.up.railway.app/api';
  }

  static String get serverBaseUrl {
    final base = apiBaseUrl;
    if (base.endsWith('/api')) {
      return base.substring(0, base.length - 4);
    }
    return base;
  }
}
