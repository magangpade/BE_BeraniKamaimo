import 'event_data.dart';

/// Teks berbahasa Inggris untuk data Event yang tampil di katalog.
class EventLocale {
  EventLocale._();

  static const _names = <String, String>{
    'Festival Danau Poso ke-24': '24th Lake Poso Festival',
    'Pasar Kreatif Sulteng': 'Central Sulawesi Creative Market',
    'Festival Teluk Tomini (FTT)': 'Tomini Bay Festival (FTT)',
    'Jelajah Megalitikum Lore': 'Lore Megalithic Journey',
    'Pekan Kuliner Kaili': 'Kaili Culinary Week',
    'Festival Pantai Pasir Panjang': 'Pasir Panjang Beach Festival',
    'Gelar UMKM Kota Palu': 'Palu City MSME Fair',
    'Wisata Pulau Togean': 'Togean Island Tour',
    'Bazar Tenun Donggala': 'Donggala Weaving Bazaar',
  };

  static const _descriptions = <String, String>{
    'Festival Danau Poso ke-24':
        'Cultural parades, Mogele dance, and dragon boat races on Lake Poso.',
    'Pasar Kreatif Sulteng':
        'Local crafts, regional food, and live music at the creative market.',
    'Festival Teluk Tomini (FTT)':
        'A coastal carnival and local business expo by Tomini Bay.',
    'Jelajah Megalitikum Lore':
        'Explore ancient stone sites with local community guides.',
    'Pekan Kuliner Kaili':
        'Taste regional dishes and meet the people behind Kaili cuisine.',
    'Festival Pantai Pasir Panjang':
        'Boat races, coastal food, and beachside cultural performances.',
    'Gelar UMKM Kota Palu':
        'Kaili food, local crafts, and Central Sulawesi souvenirs.',
    'Wisata Pulau Togean':
        'Snorkeling, island exploration, and a night by the beach.',
    'Bazar Tenun Donggala':
        'Donggala woven fabrics, local crafts, and weaving demonstrations.',
  };

  static const _locations = <String, String>{
    'Tepian Danau Poso, Anjungan Tentena, Kab. Poso':
        'Lake Poso Waterfront, Tentena Pavilion, Poso Regency',
    'Taman GOR, Palu': 'Taman GOR, Palu',
    'Pesisir Teluk Tomini, Parigi Moutong': 'Tomini Bay Coast, Parigi Moutong',
    'Lembah Bada, Poso': 'Bada Valley, Poso',
    'Kota Palu': 'Palu City',
    'Pantai Pasir Panjang, Poso': 'Pasir Panjang Beach, Poso',
    'Taman GOR, Kota Palu': 'Taman GOR, Palu City',
    'Kepulauan Togean, Tojo Una-Una': 'Togean Islands, Tojo Una-Una',
    'Banawa, Donggala': 'Banawa, Donggala',
  };

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String name(EventItem item, bool isEnglish) =>
      isEnglish ? (_names[item.nama] ?? item.nama) : item.nama;

  static String description(EventItem item, bool isEnglish) =>
      isEnglish ? (_descriptions[item.nama] ?? item.deskripsi) : item.deskripsi;

  static String location(EventItem item, bool isEnglish) =>
      isEnglish ? (_locations[item.lokasi] ?? item.lokasi) : item.lokasi;

  static String cardLocation(EventItem item, bool isEnglish) =>
      item.nama == 'Festival Danau Poso ke-24'
      ? 'Tentena, Poso'
      : location(item, isEnglish);

  static String category(String kategori, bool isEnglish) {
    if (!isEnglish) {
      return kategori == 'UMKM'
          ? kategori
          : '${kategori[0]}${kategori.substring(1).toLowerCase()}';
    }
    return switch (kategori) {
      'BUDAYA' => 'Culture',
      'BAHARI' => 'Marine',
      'UMKM' => 'MSME',
      'EKOWISATA' => 'Ecotourism',
      _ => kategori,
    };
  }

  static String dateRange(EventItem item, bool isEnglish) {
    if (!isEnglish) return item.rentangTanggal;
    final end = item.end ?? item.start;
    final first = '${item.start.day} ${_months[item.start.month - 1]}';
    final last = '${end.day} ${_months[end.month - 1]} ${end.year}';
    return item.start.year == end.year
        ? '$first – $last'
        : '$first ${item.start.year} – $last';
  }
}
