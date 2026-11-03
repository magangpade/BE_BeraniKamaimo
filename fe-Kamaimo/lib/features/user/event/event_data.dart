/// Seed data Tab Event — dummy, meniru desain Figma Tab Event.
/// ponytail: data hardcode + aset dari folder lain; ganti ke /atraksi saat sambung API.
class EventItem {
  final String foto;
  final String kategori; // BUDAYA | BAHARI | UMKM | EKOWISATA
  final String lokasi;
  final String wilayah; // opsi dropdown "Semua wilayah"
  final String nama;
  final String deskripsi;
  final String rentangTanggal; // tampil di card
  final DateTime start;
  final int? harga; // null = Gratis
  final double rating;
  final int ratingCount;

  const EventItem({
    required this.foto,
    required this.kategori,
    required this.lokasi,
    required this.wilayah,
    required this.nama,
    required this.deskripsi,
    required this.rentangTanggal,
    required this.start,
    this.harga,
    this.rating = 4.7,
    this.ratingCount = 1100,
  });
}

class EventSeed {
  EventSeed._();

  static final featured = EventItem(
    foto: 'assets/images/beranda/thumb_event1.png',
    kategori: 'BUDAYA',
    lokasi: 'Tentena, Poso',
    wilayah: 'Poso',
    nama: 'Festival Danau Poso ke-24',
    deskripsi:
        'Parade budaya, tari mogele, & lomba perahu naga di tepian Danau Poso.',
    rentangTanggal: '24 - 26 Oktober 2026',
    start: DateTime(2026, 10, 24),
    rating: 4.5,
    ratingCount: 1200,
  );

  static final List<EventItem> agenda = [
    EventItem(
      foto: 'assets/images/beranda/thumb_event1.png',
      kategori: 'UMKM',
      lokasi: 'Taman GOR, Palu',
      wilayah: 'Palu',
      nama: 'Pasar Kreatif Sulteng',
      deskripsi: 'Kriya lokal, kuliner khas, dan musik serba.',
      rentangTanggal: '31 Oktober - 1 November 2026',
      start: DateTime(2026, 10, 31),
      rating: 4.7,
      ratingCount: 11000,
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_pulo_dua.png',
      kategori: 'BAHARI',
      lokasi: 'Banggai Moutong',
      wilayah: 'Banggai',
      nama: 'Festival Teluk Tomini (FTT)',
      deskripsi: 'Karnaval bahari & expo UMKM di tepi teluk.',
      rentangTanggal: '18 - 20 November 2026',
      start: DateTime(2026, 11, 18),
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_bada.png',
      kategori: 'BUDAYA',
      lokasi: 'Lembah Bada, Poso',
      wilayah: 'Poso',
      nama: 'Jelajah Megalitikum Lore',
      deskripsi: 'Jelajah situs purba bersama penduduk lokal.',
      rentangTanggal: '25 - 29 November 2026',
      start: DateTime(2026, 11, 25),
      harga: 150000,
    ),
    EventItem(
      foto: 'assets/images/beranda/kartu_kolam_kaca.png',
      kategori: 'UMKM',
      lokasi: 'Anguja Nusantara, Palu',
      wilayah: 'Palu',
      nama: 'Pekan Kuliner Kaili',
      deskripsi: 'Cicipi kuliner nusantara rasa khas Kaili.',
      rentangTanggal: '12 - 13 Desember 2026',
      start: DateTime(2026, 12, 12),
    ),
    EventItem(
      foto: 'assets/images/detail_wisata/hero_luk_panenteng.png',
      kategori: 'BAHARI',
      lokasi: 'Pantai Pasir Panjang, Poso',
      wilayah: 'Poso',
      nama: 'Festival Pantai Pasir Panjang',
      deskripsi: 'Lomba perahu, festival kuliner pesisir, dan pertunjukan seni pantai.',
      rentangTanggal: '6 - 8 Oktober 2026',
      start: DateTime(2026, 10, 6),
    ),
    EventItem(
      foto: 'assets/images/beranda/kartu_sombori.png',
      kategori: 'UMKM',
      lokasi: 'Taman GOR, Kota Palu',
      wilayah: 'Palu',
      nama: 'Gelar UMKM Kota Palu',
      deskripsi: 'Bazar kuliner Kaili, kriya lokal, dan oleh-oleh khas Sulawesi Tengah.',
      rentangTanggal: '4 - 6 April 2026',
      start: DateTime(2026, 4, 6),
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_togean.png',
      kategori: 'BAHARI',
      lokasi: 'Kepulauan Togean, Tojo Una-Una',
      wilayah: 'Tojo Una-Una',
      nama: 'Wisata Pulau Togean',
      deskripsi: 'Snorkeling, jelajah pulau, dan pengalaman bermalam di tepi pantai.',
      rentangTanggal: '26 - 31 Agustus 2026',
      start: DateTime(2026, 8, 26),
    ),
    EventItem(
      foto: 'assets/images/beranda/kartu_sombori.png',
      kategori: 'UMKM',
      lokasi: 'Banawa, Donggala',
      wilayah: 'Donggala',
      nama: 'Bazar Tenun Donggala',
      deskripsi: 'Tenun khas Donggala, kerajinan lokal, dan demo menenun.',
      rentangTanggal: '14 - 18 Desember 2026',
      start: DateTime(2026, 12, 14),
    ),
  ];

  static List<String> get wilayahList {
    final set = <String>{};
    for (final e in agenda) {
      set.add(e.wilayah);
    }
    return set.toList();
  }

  static int hariMenuai(DateTime start, DateTime now) {
    final kini = DateTime(now.year, now.month, now.day);
    final mulai = DateTime(start.year, start.month, start.day);
    return mulai.difference(kini).inDays;
  }
}
