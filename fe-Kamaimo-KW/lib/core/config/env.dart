import 'package:flutter/foundation.dart';

/// Konfigurasi environment via --dart-define.
/// Jalankan: flutter run --dart-define=API_BASE_URL=http://localhost:3000/api
class Env {
  Env._();

  static String get apiBaseUrl {
    const fromDefine = String.fromEnvironment('API_BASE_URL');
    if (fromDefine.isNotEmpty) return fromDefine;

    // Otomatis arahkan ke host loopback jika dijalankan di emulator Android
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000/api';
    }
    return 'http://localhost:3000/api';
  }
}
