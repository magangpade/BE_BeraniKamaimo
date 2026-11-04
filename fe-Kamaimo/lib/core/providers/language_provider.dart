import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const _prefKey = 'app_locale';
  String _currentLocale = 'id';

  String get currentLocale => _currentLocale;
  bool get isEnglish => _currentLocale == 'en';

  LanguageProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefKey);
      if (saved != null && (saved == 'id' || saved == 'en')) {
        _currentLocale = saved;
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> setLanguage(String lang) async {
    final lower = lang.toLowerCase();
    if (lower != 'id' && lower != 'en') return;
    if (_currentLocale == lower) return;
    _currentLocale = lower;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, lower);
    } catch (_) {}
  }

  void toggle() {
    setLanguage(isEnglish ? 'id' : 'en');
  }

  String tr({required String id, required String en}) {
    return isEnglish ? en : id;
  }
}
