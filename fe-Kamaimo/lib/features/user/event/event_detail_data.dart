/// Detail data untuk satu event (terdiri dari badge, rating, tentang, program, rundown, lokasi, akses, organizer).
class EventDetail {
  final String badge; // badge di header (contoh: "Karisma Event Nusantara (KEN) RI")
  final double rating; // rating (4.7)
  final int ratingCount; // jumlah rating (11000)
  final String lokasi; // lokasi di header (Taman GOR, ...)
  final String tentang; // tentang festival (paragraf singkat)
  final List<String> program; // nama program utama (3 item)
  final List<Map<String, dynamic>> rundown; // jadwal per hari
  final String zonaWita; // "Zona WITA (UTC+8)"
  final String mapsUrl; // URL Google Maps
  final List<Map<String, dynamic>> akses; // akses transportir
  final List<String> organizer; // organisator

  EventDetail({
    required this.badge,
    required this.rating,
    required this.ratingCount,
    required this.lokasi,
    required this.tentang,
    required this.program,
    required this.rundown,
    required this.zonaWita,
    required this.mapsUrl,
    required this.akses,
    required this.organizer,
  });
}

// Data detail untuk setiap event — data ini bisa diisi dari API nanti.
class EventDetailSeed {
  EventDetailSeed._();

  static final pasarKreatif = EventDetail(
    badge: 'Karisma Event Nusantara (KEN) RI',
    rating: 4.7,
    ratingCount: 11000,
    lokasi: 'Taman GOR, Besusu Tengah, Kota Palu',
    tentang:
        'Pasar Kreatif Sulteng menghadirkan ruang untuk mengenalkan karya dan cita rasa lokal dalam suasana terbuka di Taman GOR, Palu. Pengunjung dapat menjelajahi beragam kriya buatan pelaku kreatif, menemukan kuliner khas daerah, serta menikmati musik senja bersama keluarga dan teman.',
    program: [
      'Jelajah Kriya Lokal: Temukan produk kriya dan karya kreatif dari pelaku lokal. Lihat pilihan produk kreatif.',
      'Cita Rasa Kuliner Daerah: Jelajahi pilihan kuliner khas dan sajian lokal di area acara. Temukan hidangan.',
      'Musik Senja: Nikmati suasana sore di Taman GOR dengan iringan musik. Cocok sebagai pelengkap akhir hari.',
    ],
    rundown: [
      {
        'hari': 'Hari 1 — 31 Okt 2026',
        'items': [
          {'jam': '08.30 WITA', 'chip': 'Area Pasar Kreatif', 'chipColor': 'mint', 'judul': 'Pembukaan Pasar Kreatif', 'deskripsi': 'Area Pasar Kreatif Sulteng dibuka untuk pengunjung. Nikmati stan kriya, fesyen, kerajinan tangan, serta kuliner khas Sulawesi Tengah.'},
          {'jam': '14.00 WITA', 'chip': 'Panggung Utama', 'chipColor': 'yellow', 'judul': 'Pembangunan Resmi', 'deskripsi': 'Pembukaan resmi oleh Kemenparekraf RI & atraksi perahu naga di pesisir Tentena.'},
          {'jam': '19.30 WITA', 'chip': 'Panggung Utama', 'chipColor': 'mint', 'judul': 'Musik Senja', 'deskripsi': 'Nikmati penampilan musik sambil bersantai di area acara.'},
        ],
      },
      {
        'hari': 'Hari 2 — 1 Nov 2026',
        'items': [
          {'jam': '08.30 WITA', 'chip': 'Area Pasar Kreatif', 'chipColor': 'mint', 'judul': 'Kerajinan Tangan', 'deskripsi': 'Nikmati kerajinan tangan dari pelaku lokal di area acara.'},
          {'jam': '16.00 WITA', 'chip': 'Panggung Utama', 'chipColor': 'yellow', 'judul': 'Penutup Hari Kedua', 'deskripsi': 'Penutup acara dengan terakher & penyuapan.'},
        ],
      },
    ],
    zonaWita: 'Zona WITA (UTC+8)',
    mapsUrl: 'https://maps.google.com/?q=Taman+GOR+Kota+Palu',
    akses: [
      {'title': 'Dari Terminal Tibo', 'detail': '±25 menit Naik Bus Trans Palu Koridor 4B melintasi perkotaan (7,4 km).'},
      {'title': 'Dari Kota Palu (Bandara SIS Al-Jufri)', 'detail': '±14 - 25 menit via Jl. Abdul Rahman Saleh ke Jl. Moh Hatta (5,7 km).'},
    ],
    organizer: [
      'Dispar Sulteng & Pemkot Palu',
      'Agenda resmi Kalender',
      'Pariwisata Sulawesi Tengah',
      '2026',
    ],
  );

  static EventDetail of(String eventName) {
    if (eventName == 'Pasar Kreatif Sulteng') return pasarKreatif;
    // fallback untuk event lainnya (belum diisi, gunakan data dasar)
    return EventDetail(
      badge: 'Karisma Event Nusantara (KEN) RI',
      rating: 4.5,
      ratingCount: 5000,
      lokasi: 'Lokasi belum diisi',
      tentang: 'Detail event ini masih dalam pengembangan.',
      program: ['Detail akan segera segera segera'],
      rundown: [{'hari': 'Hari 1', 'items': [{'jam': '-', 'chip': '-', 'chipColor': '-', 'judul': '-', 'deskripsi': '-'}]}, {'hari': 'Hari 2', 'items': [{'jam': '-', 'chip': '-', 'chipColor': '-', 'judul': '-', 'deskripsi': '-'}]}],
      zonaWita: 'Zona WITA (UTC+8)',
      mapsUrl: '#',
      akses: [{'title': '-', 'detail': '-'}],
      organizer: ['-'],
    );
  }
}