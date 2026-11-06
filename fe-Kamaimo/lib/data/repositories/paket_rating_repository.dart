import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan rating pribadi paket pada perangkat sampai API rating paket tersedia.
class PaketRatingRepository {
  static const _keyPrefix = 'paket_my_rating_v1_';

  Future<int?> getMyRating(String packageKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_keyPrefix$packageKey');
  }

  Future<bool> submit(String packageKey, int rating) async {
    if (rating < 1 || rating > 5) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('$_keyPrefix$packageKey', rating);
  }
}
