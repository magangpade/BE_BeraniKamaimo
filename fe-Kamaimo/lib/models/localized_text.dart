/// Helper `LocalizedText` untuk menangani field `_id`/`_en` di model.
class LocalizedText {
  LocalizedText._();

  /// Nilai Bahasa Indonesia (`_id`).
  static String id(String id, String? en) => en ?? id;

  /// Nilai Bahasa Inggris (`_en`), fallback ke `id`.
  static String en(String id, String? en) => en ?? id;

  /// Resolve berdasarkan locale aktif.
  /// Jika `locale` == 'en' → pakai `_en`, lain pakai `_id`.
  static String resolve(String id, String? en, String locale) {
    if (locale == 'en' || locale == 'en_US') {
      return en ?? id;
    }
    return id ?? en ?? '';
  }
}