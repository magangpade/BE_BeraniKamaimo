/// Konstanta aplikasi Berani Kamaimo.
class AppConstants {
  AppConstants._();

  // App
  static const String appName = 'Berani Kamaimo';
  static const String appVersion = '0.1.0';
  static const String appTagline = 'Menunggu petualanganmu di jantung indonesia';

  // Locale
  static const String defaultLocale = 'id';
  static const String supportedLocales = 'id,en';

  // Network
  static const Duration httpTimeout = Duration(seconds: 30);
  static const int pageSize = 5;

  // Storage Keys
  static const String keyVisitorUid = 'visitor_uid';
  static const String keyLocale = 'locale';
  static const String keyAdminToken = 'admin_token';
  static const String keyAdminData = 'admin_data';

  // Routes
  static const String routeSambutan = '/sambutan';
  static const String routeHome = '/home';
  static const String routeDetailDesa = '/detail-desa';
  static const String routeDetailEvent = '/detail-event';
  static const String routePaketWisata = '/paket-wisata';
  static const String routeKuliner = '/kuliner';
  static const String routeHotel = '/hotel';
  static const String routeAdminLogin = '/admin-login';
  static const String routeAdminDashboard = '/admin-dashboard';
}
