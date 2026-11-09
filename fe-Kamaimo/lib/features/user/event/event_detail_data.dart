import 'event_rundown_data.dart';

/// Detail data untuk satu event (terdiri dari badge, rating, tentang, program, rundown, lokasi, akses, organizer).
class EventDetail {
  final String
  badge; // badge di header (contoh: "Karisma Event Nusantara (KEN) RI")
  final double rating; // rating (4.7)
  final int ratingCount; // jumlah rating
  final String lokasi; // lokasi di header (Taman GOR, ...)
  final String tentang; // tentang festival (paragraf singkat)
  final List<String> program; // nama program utama (3 item)
  final List<String> programImages;
  final List<Map<String, dynamic>> rundown; // jadwal per hari
  final String zonaWita; // "Zona WITA (UTC+8)"
  final String mapsUrl; // URL Google Maps
  final String mapLabel;
  final String? mapAsset;
  final String region;
  final double? mapLatitude;
  final double? mapLongitude;
  final List<Map<String, dynamic>> akses; // akses transportir
  final List<String> organizer; // organisator

  EventDetail({
    required this.badge,
    required this.rating,
    required this.ratingCount,
    required this.lokasi,
    required this.tentang,
    required this.program,
    this.programImages = const [],
    required this.rundown,
    required this.zonaWita,
    required this.mapsUrl,
    this.mapLabel = '',
    this.mapAsset,
    this.region = '',
    this.mapLatitude,
    this.mapLongitude,
    required this.akses,
    required this.organizer,
  });

  EventDetail withText({String? lokasi, String? tentang,
    List<String>? program, List<Map<String, dynamic>>? rundown}) => EventDetail(
    badge: badge, rating: rating, ratingCount: ratingCount,
    lokasi: lokasi ?? this.lokasi, tentang: tentang ?? this.tentang,
    program: program ?? this.program, programImages: programImages,
    rundown: rundown ?? this.rundown,
    zonaWita: zonaWita, mapsUrl: mapsUrl, mapLabel: mapLabel,
    mapAsset: mapAsset, region: region, mapLatitude: mapLatitude,
    mapLongitude: mapLongitude, akses: akses, organizer: organizer,
  );
}

// Data detail untuk setiap event — data ini bisa diisi dari API nanti.
class EventDetailSeed {
  EventDetailSeed._();

  static final pasarKreatif = EventDetail(
    badge: 'Karisma Event Nusantara (KEN) RI',
    rating: 4.7,
    ratingCount: 1100,
    lokasi: 'Taman GOR, Besusu Tengah, Kota Palu',
    tentang: 'Pasar Kreatif Sulteng menghadirkan ruang untuk mengenalkan karya dan cita rasa lokal dalam suasana terbuka di Taman GOR, Palu. Pengunjung dapat menjelajahi beragam kriya buatan pelaku kreatif, menemukan kuliner khas daerah, serta menikmati musik senja bersama keluarga dan teman.',
    program: [
      'Jelajah Kriya Lokal|Temukan produk kriya dan karya kreatif dari pelaku lokal. Lihat pilihan produk...',
      'Cita Rasa Kuliner Daerah|Jelajahi pilihan kuliner khas dan sajian lokal di area acara. Temukan hidangan...',
      'Musik Senja|Nikmati suasana sore di Taman GOR dengan iringan musik. Cocok sebagai...',
    ],
    programImages: [
      'assets/images/beranda/pasar_kreatif_program_2.png',
      'assets/images/beranda/pasar_kreatif_program_4.png',
      'assets/images/beranda/pasar_kreatif_map_1.png',
    ],
    rundown: EventRundownData.pasarKreatif,
    zonaWita: 'Zona WITA (UTC+8)',
    mapsUrl: 'https://maps.google.com/?q=Taman+GOR+Kota+Palu',
    mapLabel: 'Taman GOR, Kota Palu',
    mapAsset: 'assets/images/beranda/pasar_kreatif_map_2.png',
    region: 'Palu',
    akses: [
      {
        'title': 'Dari Terminal Tipo',
        'detail': '±25 menit Naik Bus Trans Palu Koridor 4B melintasi perkotaan (7,4 km).',
      },
      {
        'title': 'Dari Kota Palu (Bandara SIS Al-Jufri)',
        'detail': '±14 - 25 menit via Jl. Abdul Rahman Saleh ke Jl. Moh Hatta (5,7 km).',
      },
    ],
    organizer: [
      'Dispar Sulteng & Pemkot Palu',
      'Agenda resmi Kalender',
      'Pariwisata Sulawesi Tengah',
      '2026',
    ],
  );

  static final danauPoso = EventDetail(
    badge: 'Karisma Event Nusantara (KEN) RI',
    rating: 4.9,
    ratingCount: 1200,
    lokasi: 'Tepian Danau Poso, Anjungan Tentena, Kab. Poso',
    tentang: 'Kemeriahan kebudayaan tertua di Sulawesi Tengah kembali hadir di tepian Danau Poso. Saksikan tarian kolosal masyarakat Pamona, parade perahu hias, pameran kriya, dan sajian kuliner danau. Festival ini menjadi ruang pertemuan warga dan pengunjung untuk menikmati tradisi Tentena dalam suasana terbuka.',
    program: [
      'Tarian Massal Kolosal Motaro|Tarian penyambutan masyarakat Pamona yang meramaikan panggung utama festival.',
      'Parade Perahu Hias Pamona|Perahu kayu berhias melintas di tepian danau bersama para peserta.',
      'Festival Kuliner Ikan Sogili Bakar|Jelajahi sajian ikan dan kuliner khas Poso di area festival.',
      'Kriya Tenun & Musik Etnik|Temukan karya kriya lokal dan nikmati pertunjukan musik malam.',
    ],
    rundown: [
      _day('Hari 1 (24 Okt)', [
        _slot(
          '08.30 – 11.30 WITA',
          'Panggung Utama',
          'Karnaval Budaya & Defile Kecamatan',
          'Pawai busana adat Pamona dengan iringan suling lembang dan gendang tradisional.',
        ),
        _slot(
          '14.00 – 17.00 WITA',
          'Anjungan Danau',
          'Pembukaan & Tarian Kolosal Motaro',
          'Pembukaan festival dilanjutkan persembahan tarian kolosal di tepi danau.',
          color: 'slate',
        ),
        _slot(
          '19.30 – 22.00 WITA',
          'Plaza Kuliner',
          'Malam Harmoni Danau & Akustik Etnik',
          'Pertunjukan musik dan ruang menikmati kuliner khas Poso.',
          color: 'earth',
        ),
      ]),
      _day('Hari 2 (25 Okt)', [
        _slot(
          '09.00 – 12.00 WITA',
          'Tepi Danau',
          'Parade Perahu Hias Pamona',
          'Perahu peserta melintas di hadapan pengunjung di kawasan Tentena.',
        ),
        _slot(
          '15.00 – 17.00 WITA',
          'Area Kriya',
          'Pameran Kriya & Tenun',
          'Pelaku kreatif memperkenalkan tenun dan kerajinan Sulawesi Tengah.',
          color: 'slate',
        ),
        _slot(
          '19.00 – 21.00 WITA',
          'Panggung Utama',
          'Pentas Musik Etnik',
          'Musisi lokal membawakan repertoar bernuansa budaya Pamona.',
          color: 'earth',
        ),
      ]),
      _day('Hari 3 (26 Okt)', [
        _slot(
          '09.00 – 11.30 WITA',
          'Plaza Kuliner',
          'Jelajah Kuliner Danau',
          'Cicipi hidangan khas Poso dari pelaku kuliner setempat.',
        ),
        _slot(
          '14.00 – 16.00 WITA',
          'Panggung Utama',
          'Pertunjukan Budaya Pamona',
          'Rangkaian tari dan musik tradisi sebagai penutup festival.',
          color: 'slate',
        ),
      ]),
    ],
    zonaWita: 'Zona WITA (UTC+8)',
    mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Anjungan+Danau+Poso+Tentena',
    mapLabel: 'Anjungan Danau Poso, Tentena',
    region: 'Tentena, Poso',
    mapLatitude: -1.76,
    mapLongitude: 120.65,
    akses: [
      {
        'title': 'Dari Bandara Kasiguncu Poso',
        'detail': 'Lanjutkan perjalanan darat menuju Tentena dan kawasan anjungan danau.',
      },
      {
        'title': 'Dari Kota Palu',
        'detail': 'Ikuti jalur darat menuju Poso dan Tentena; periksa kondisi rute sebelum berangkat.',
      },
    ],
    organizer: [
      'Dispar Sulteng & Pemkab Poso',
      'Agenda budaya Sulawesi Tengah',
    ],
  );

  static Map<String, dynamic> _day(
    String hari,
    List<Map<String, dynamic>> items,
  ) => {'hari': hari, 'items': items};

  static Map<String, dynamic> _slot(
    String jam,
    String chip,
    String judul,
    String deskripsi, {
    String color = 'mint',
  }) => {
    'jam': jam,
    'chip': chip,
    'chipColor': color,
    'dotColor': color == 'earth' ? 'earth' : 'mint',
    'judul': judul,
    'deskripsi': deskripsi,
  };

  static EventDetail _custom({
    required String lokasi,
    required String tentang,
    required List<String> program,
    required List<Map<String, dynamic>> rundown,
    required String region,
    required String mapLabel,
    required double latitude,
    required double longitude,
    required List<Map<String, String>> akses,
    required String organizer,
    List<String> programImages = const [],
  }) => EventDetail(
    badge: 'Event Sulawesi Tengah',
    rating: 0,
    ratingCount: 0,
    lokasi: lokasi,
    tentang: tentang,
    program: program,
    programImages: programImages,
    rundown: rundown,
    zonaWita: 'Zona WITA (UTC+8)',
    mapsUrl: Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': mapLabel,
    }).toString(),
    mapLabel: mapLabel,
    region: region,
    mapLatitude: latitude,
    mapLongitude: longitude,
    akses: akses,
    organizer: [organizer, 'Agenda Event Sulawesi Tengah'],
  );

  static final telukTomini = _custom(
    lokasi: 'Pesisir Teluk Tomini, Kab. Parigi Moutong',
    tentang: 'Festival Teluk Tomini mempertemukan pesona pesisir dengan karya kreatif masyarakat Parigi Moutong. Pengunjung dapat menyaksikan karnaval budaya, mengenal produk UMKM, dan menikmati sajian kuliner laut. Seluruh kegiatan dirancang sebagai ruang berkumpul di kawasan teluk.',
    program: [
      'Karnaval Pesisir Tomini|Parade busana dan pertunjukan budaya masyarakat pesisir.',
      'Expo UMKM Lokal|Temukan kerajinan dan produk unggulan pelaku usaha setempat.',
      'Kuliner Laut & Musik|Nikmati sajian pesisir bersama penampilan musik lokal.',
    ],
    rundown: EventRundownData.telukTomini,
    region: 'Parigi Moutong',
    mapLabel: 'Teluk Tomini, Parigi Moutong',
    latitude: -0.8,
    longitude: 120.19,
    akses: [
      {
        'title': 'Dari Kota Palu',
        'detail':
            'Ikuti jalur darat menuju Parigi Moutong dan pesisir Teluk Tomini.',
      },
      {
        'title': 'Dari pusat Parigi',
        'detail': 'Lanjutkan ke area festival sesuai titik acara yang diumumkan penyelenggara.',
      },
    ],
    organizer: 'Pemerintah Daerah Parigi Moutong',
  );

  static final megalitikumLore = _custom(
    lokasi: 'Lembah Bada, Kab. Poso',
    tentang: 'Jelajah Megalitikum Lore mengajak pengunjung mengenal tinggalan batu purba di Lembah Bada. Perjalanan dipandu dengan cerita mengenai lanskap, kehidupan masyarakat, dan upaya menjaga situs. Kegiatan berlangsung dalam kelompok agar kunjungan tetap nyaman dan menghormati kawasan.',
    program: [
      'Jelajah Situs Megalit|Telusuri titik batu purba bersama pemandu lokal.',
      'Cerita Lembah Bada|Dengar kisah lanskap dan warisan budaya masyarakat setempat.',
      'Kriya & Kuliner Desa|Kenali hasil karya dan sajian warga sekitar.',
    ],
    rundown: EventRundownData.megalitikumLore,
    region: 'Poso',
    mapLabel: 'Lembah Bada, Poso',
    latitude: -1.78,
    longitude: 120.23,
    akses: [
      {
        'title': 'Dari Kota Poso',
        'detail':
            'Lanjutkan perjalanan darat menuju kawasan Lore dan Lembah Bada.',
      },
      {
        'title': 'Menuju titik kumpul',
        'detail': 'Konfirmasi titik temu dan kondisi jalan dengan penyelenggara sebelum berangkat.',
      },
    ],
    organizer: 'Komunitas Wisata Lembah Bada',
  );

  static final kulinerKaili = _custom(
    lokasi: 'Kota Palu, Sulawesi Tengah',
    tentang: 'Pekan Kuliner Kaili memperkenalkan cita rasa khas Palu dalam suasana pasar terbuka. Pengunjung dapat mencicipi hidangan pilihan, berbincang dengan pelaku kuliner, dan mengikuti demonstrasi memasak. Kegiatan ini memberi ruang bagi usaha lokal untuk memperkenalkan resep dan cerita di balik sajiannya.',
    program: [
      'Jelajah Rasa Kaili|Cicipi hidangan khas dari stan pelaku kuliner lokal.',
      'Demo Masak Daerah|Saksikan proses mengolah bahan dan bumbu pilihan.',
      'Bincang Pelaku Kuliner|Dengar cerita usaha dan tradisi rasa dari pembuatnya.',
    ],
    rundown: EventRundownData.kulinerKaili,
    region: 'Palu',
    mapLabel: 'Kota Palu, Sulawesi Tengah',
    latitude: -0.9,
    longitude: 119.87,
    akses: [
      {
        'title': 'Dari Bandara SIS Al-Jufri',
        'detail': 'Lanjutkan ke pusat Kota Palu dengan transportasi setempat.',
      },
      {
        'title': 'Dari pusat kota',
        'detail': 'Gunakan titik acara terbaru yang dibagikan penyelenggara untuk petunjuk akhir.',
      },
    ],
    organizer: 'Pelaku Kuliner Kota Palu',
  );

  static final pantaiPasirPanjang = _custom(
    lokasi: 'Pantai Pasir Panjang, Kab. Poso',
    tentang: 'Festival Pantai Pasir Panjang mengajak pengunjung menikmati aktivitas budaya dan kuliner di tepi laut Poso. Lomba perahu menjadi sorotan utama, diselingi pertunjukan seni dan pasar makanan pesisir. Ruang acara dibuat santai agar keluarga dapat menikmati pantai sepanjang hari.',
    program: [
      'Lomba Perahu Pesisir|Saksikan peserta berlomba di perairan sekitar pantai.',
      'Kuliner Pantai|Temukan olahan laut dan jajanan dari pelaku usaha setempat.',
      'Seni Senja|Nikmati pertunjukan musik dan tari di tepi pantai.',
    ],
    rundown: EventRundownData.pantaiPasirPanjang,
    region: 'Poso',
    mapLabel: 'Pantai Pasir Panjang, Poso',
    latitude: -1.4,
    longitude: 120.75,
    akses: [
      {
        'title': 'Dari Kota Poso',
        'detail': 'Ikuti jalan menuju kawasan pantai sesuai titik acara penyelenggara.',
      },
      {
        'title': 'Dari luar Poso',
        'detail': 'Rencanakan perjalanan menuju Kota Poso sebelum melanjutkan ke pantai.',
      },
    ],
    organizer: 'Komunitas Pesisir Poso',
  );

  static final umkmPalu = _custom(
    lokasi: 'Taman GOR, Kota Palu',
    tentang: 'Gelar UMKM Kota Palu menghadirkan produk usaha lokal dalam satu kawasan yang mudah dijelajahi. Pengunjung dapat menemukan kriya, oleh-oleh, dan sajian kuliner Kaili, sekaligus mengenal pembuatnya. Panggung acara memberi ruang bagi demonstrasi produk dan hiburan ringan.',
    program: [
      'Bazar Produk Lokal|Belanja kriya, fesyen, dan oleh-oleh karya pelaku UMKM Palu.',
      'Cita Rasa Kaili|Cicipi kuliner khas dari stan makanan setempat.',
      'Demo Produk Kreatif|Saksikan pelaku usaha memperlihatkan proses dan karya mereka.',
    ],
    rundown: EventRundownData.umkmPalu,
    region: 'Palu',
    mapLabel: 'Taman GOR, Kota Palu',
    latitude: -0.9,
    longitude: 119.87,
    akses: [
      {
        'title': 'Dari Terminal Tipo',
        'detail':
            'Lanjutkan perjalanan menuju kawasan Taman GOR di pusat Kota Palu.',
      },
      {
        'title': 'Dari Bandara SIS Al-Jufri',
        'detail': 'Gunakan transportasi darat menuju Taman GOR, Kota Palu.',
      },
    ],
    organizer: 'Pelaku UMKM & Pemkot Palu',
  );

  static final pulauTogean = _custom(
    lokasi: 'Kepulauan Togean, Kab. Tojo Una-Una',
    tentang: 'Wisata Pulau Togean menawarkan perjalanan beberapa hari untuk menikmati laut dan kehidupan pulau. Rangkaian kegiatan mencakup penyeberangan, jelajah pulau, dan kesempatan snorkeling di lokasi yang sesuai kondisi. Waktu senggang memberi ruang untuk mengenal masyarakat setempat dan menikmati suasana tepi pantai.',
    program: [
      'Jelajah Pulau|Singgah di beberapa pulau dan menikmati bentang alam laut.',
      'Snorkeling|Kenali kehidupan bawah air dengan mengikuti arahan pemandu.',
      'Malam di Tepi Pantai|Beristirahat dan menikmati suasana pulau setelah perjalanan.',
    ],
    rundown: EventRundownData.pulauTogean,
    region: 'Tojo Una-Una',
    mapLabel: 'Kepulauan Togean, Tojo Una-Una',
    latitude: -0.42,
    longitude: 121.88,
    akses: [
      {
        'title': 'Dari Ampana',
        'detail':
            'Lanjutkan dengan penyeberangan menuju pulau sesuai jadwal kapal.',
      },
      {
        'title': 'Dari luar Tojo Una-Una',
        'detail': 'Rencanakan kedatangan ke Ampana sebelum waktu keberangkatan kapal.',
      },
    ],
    organizer: 'Pemandu Wisata Kepulauan Togean',
  );

  static final tenunDonggala = _custom(
    lokasi: 'Banawa, Kab. Donggala',
    tentang: 'Bazar Tenun Donggala mempertemukan pengunjung dengan perajin dan karya tekstil khas daerah. Selain melihat pilihan kain, pengunjung dapat mengikuti demonstrasi menenun dan mendengar cerita tentang motif. Kegiatan dilengkapi stan kriya serta sajian lokal dalam suasana pasar yang akrab.',
    program: [
      'Galeri Tenun Donggala|Lihat ragam motif dan pilihan kain karya perajin.',
      'Demo Menenun|Saksikan tahapan pembuatan kain langsung dari pembuatnya.',
      'Pasar Kriya & Kuliner|Temukan produk kreatif dan sajian lokal Donggala.',
    ],
    rundown: EventRundownData.tenunDonggala,
    region: 'Donggala',
    mapLabel: 'Banawa, Donggala',
    latitude: -0.67,
    longitude: 119.74,
    akses: [
      {
        'title': 'Dari Kota Palu',
        'detail': 'Ikuti jalur darat menuju Banawa, Kabupaten Donggala.',
      },
      {
        'title': 'Dari pusat Donggala',
        'detail': 'Lanjutkan ke titik bazar sesuai informasi penyelenggara.',
      },
    ],
    organizer: 'Perajin Tenun Donggala',
  );

  static EventDetail of(String eventName) {
    if (eventName == 'Pasar Kreatif Sulawesi Tengah' ||
        eventName == 'Pasar Kreatif Sulteng') {
      return pasarKreatif;
    }
    if (eventName == 'Festival Danau Poso ke-24') return danauPoso;
    if (eventName == 'Festival Teluk Tomini (FTT)') return telukTomini;
    if (eventName == 'Jelajah Megalitikum Lore') return megalitikumLore;
    if (eventName == 'Pekan Kuliner Kaili') return kulinerKaili;
    if (eventName == 'Festival Pantai Pasir Panjang') return pantaiPasirPanjang;
    if (eventName == 'Gelar UMKM Kota Palu') return umkmPalu;
    if (eventName == 'Wisata Pulau Togean') return pulauTogean;
    if (eventName == 'Bazar Tenun Donggala') return tenunDonggala;

    // Konten umum hanya untuk event baru yang belum masuk katalog seed.
    return EventDetail(
      badge: 'Event Sulawesi Tengah',
      rating: 0,
      ratingCount: 0,
      lokasi: 'Sulawesi Tengah',
      tentang: 'Informasi lengkap tentang acara ini sedang disiapkan oleh penyelenggara. Periksa kembali halaman Event untuk pembaruan program, jadwal, dan lokasi kegiatan.',
      program: [
        'Program acara|Rincian kegiatan akan diumumkan oleh penyelenggara.',
      ],
      rundown: [
        _day('Jadwal', [
          _slot(
            'Akan diumumkan',
            'Area Acara',
            'Rundown sedang disiapkan',
            'Periksa kembali informasi dari penyelenggara.',
          ),
        ]),
      ],
      zonaWita: 'Zona WITA (UTC+8)',
      mapsUrl: '',
      mapLabel: eventName,
      akses: [
        {
          'title': 'Informasi perjalanan',
          'detail': 'Lokasi dan akses akan diumumkan oleh penyelenggara.',
        },
      ],
      organizer: ['Penyelenggara Event', 'Informasi resmi menyusul'],
    );
  }
}
