/// Konfigurasi API endpoints.
class ApiConfig {
  ApiConfig._();

  // Domains & endpoints
  static const String user = '/user';
  static const String atraksi = '/atraksi';
  static const String tourPackage = '/tourPackage';
  static const String desaWisata = '/desaWisata';
  static const String jarak = '/jarak';
  static const String kuliner = '/kuliner';
  static const String rumahMakan = '/rumahMakan';
  static const String hotel = '/hotel';
  static const String ulasan = '/ulasan';
  static const String eventRating = '/event-rating';
  static const String visitor = '/visitor';
  static const String pageview = '/pageview';
  static const String kunjunganTuris = '/kunjunganTuris';
  static const String weather = '/weather';
  static const String gis = '/gis';

  // Sub-routes (contoh)
  static const String login = '$user/login';
  static const String insertUlasan = '$ulasan/insert';
  static const String deleteFoto = '$atraksi/foto';
  static const String gisMarkers = '$gis/markers';
}
