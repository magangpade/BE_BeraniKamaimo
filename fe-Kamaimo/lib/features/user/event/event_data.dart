import '../../../models/atraksi.dart';

import 'dart:convert';

import 'event_detail_data.dart';

/// Seed data Tab Event — dummy, meniru desain Figma Tab Event.
/// ponytail: data hardcode + aset dari folder lain; ganti ke /atraksi saat sambung API.
class EventItem {
  final String foto;
  final String kategori; // BUDAYA | BAHARI | UMKM | EKOWISATA
  final String lokasi;
  final String? lokasiEn;
  final String wilayah; // opsi dropdown "Semua wilayah"
  final String nama;
  final String deskripsi;
  final String? deskripsiEn;
  final String rentangTanggal; // tampil di card
  final DateTime start;
  final DateTime? end;
  final int? harga; // null = Gratis
  final double rating;
  final int ratingCount;
  final EventDetail? detail;
  final List<String>? programEn;
  final List<Map<String, dynamic>>? rundownEn;

  /// Kunci rating stabil untuk Event seed. Event berbeda tetap terpisah.
  String get ratingKey {
    final rawSlug = nama
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    final slug = rawSlug.isEmpty
        ? 'event'
        : (rawSlug.length > 109 ? rawSlug.substring(0, 109) : rawSlug);
    final date =
        '${start.year.toString().padLeft(4, '0')}-'
        '${start.month.toString().padLeft(2, '0')}-'
        '${start.day.toString().padLeft(2, '0')}';
    return '$slug-$date';
  }

  const EventItem({
    required this.foto,
    required this.kategori,
    required this.lokasi,
    this.lokasiEn,
    required this.wilayah,
    required this.nama,
    required this.deskripsi,
    this.deskripsiEn,
    required this.rentangTanggal,
    required this.start,
    this.end,
    this.harga,
    this.rating = 0,
    this.ratingCount = 0,
    this.detail,
    this.programEn,
    this.rundownEn,
  });

  factory EventItem.fromModel(Atraksi a) {
    DateTime start = DateTime.tryParse(a.startdate) ?? DateTime.now();
    DateTime end = DateTime.tryParse(a.enddate) ?? start;

    final months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    String rentang = '${start.day} ${months[start.month]} ${start.year}';
    if (end.isAfter(start)) {
      rentang = '${start.day} - ${end.day} ${months[end.month]} ${end.year}';
    }

    String wil = 'Sulteng';
    final lok = (a.lokasi_id + ' ' + a.nameEvent).toLowerCase();
    if (lok.contains('poso'))
      wil = 'Poso';
    else if (lok.contains('sigi') ||
        lok.contains('kulawi') ||
        lok.contains('marawola'))
      wil = 'Sigi';
    else if (lok.contains('palu'))
      wil = 'Palu';
    else if (lok.contains('banggai'))
      wil = 'Banggai';
    else if (lok.contains('togean') ||
        lok.contains('ampana') ||
        lok.contains('tojo'))
      wil = 'Tojo Una-Una';
    else if (lok.contains('donggala'))
      wil = 'Donggala';
    else if (lok.contains('parigi'))
      wil = 'Parigi Moutong';
    else if (lok.contains('morowali'))
      wil = 'Morowali';
    else if (lok.contains('lupi'))
      wil = 'Donggala';

    List<dynamic> parseList(String? raw) {
      if (raw == null || raw.isEmpty) return [];
      try {
        final value = jsonDecode(raw);
        return value is List ? value : [];
      } catch (_) {
        return [];
      }
    }

    final programs = parseList(a.programJson);
    final rundown = parseList(a.rundownJson);
    final akses = parseList(a.aksesJson);
    final organizer = parseList(a.organizerJson);
    final detail = EventDetail(
      badge: a.badge ?? '',
      rating: a.rating,
      ratingCount: a.ratingCount,
      lokasi: a.lokasi_id,
      tentang: a.deskripsi_id,
      program: programs
          .map(
            (p) => p is Map
                ? '${p['title'] ?? ''}|${p['description'] ?? ''}'
                : '$p',
          )
          .toList(),
      programImages: programs
          .map((p) => p is Map ? '${p['image'] ?? ''}' : '')
          .toList(),
      rundown: rundown
          .whereType<Map>()
          .map((r) => Map<String, dynamic>.from(r))
          .toList(),
      zonaWita: 'Zona WITA (UTC+8)',
      mapsUrl: a.mapsUrl ?? '',
      mapLabel: a.mapLabel ?? a.lokasi_id,
      region: a.wilayah ?? '',
      mapLatitude: a.latitude,
      mapLongitude: a.longitude,
      akses: akses
          .whereType<Map>()
          .map((r) => Map<String, dynamic>.from(r))
          .toList(),
      organizer: organizer.map((e) => '$e').toList(),
    );
    final programEn = programs.map((p) {
      if (p is! Map) return '$p';
      final title = '${p['title_en'] ?? ''}'.trim();
      final description = '${p['description_en'] ?? ''}'.trim();
      return '${title.isNotEmpty ? title : p['title'] ?? ''}|${description.isNotEmpty ? description : p['description'] ?? ''}';
    }).toList();
    final rundownEn = rundown.whereType<Map>().map((day) {
      final items = day['items'] is List ? day['items'] as List : [];
      return <String, dynamic>{
        ...Map<String, dynamic>.from(day),
        'hari': '${day['hari'] ?? ''}'.replaceFirst('Hari', 'Day'),
        'items': items.whereType<Map>().map((item) {
          final copy = Map<String, dynamic>.from(item);
          for (final key in ['judul', 'deskripsi']) {
            final translated = '${copy['${key}_en'] ?? ''}'.trim();
            if (translated.isNotEmpty) copy[key] = translated;
          }
          return copy;
        }).toList(),
      };
    }).toList();
    return EventItem(
      foto: a.foto ?? 'assets/images/beranda/thumb_event1.png',
      kategori: a.kategori,
      lokasi: a.lokasi_id,
      lokasiEn: a.lokasi_en,
      wilayah: a.wilayah?.isNotEmpty == true ? a.wilayah! : wil,
      nama: a.nameEvent,
      deskripsi: a.deskripsi_id,
      deskripsiEn: a.deskripsi_en,
      rentangTanggal: rentang,
      start: start,
      end: end,
      harga: a.harga,
      rating: a.rating,
      ratingCount: a.ratingCount,
      detail: detail,
      programEn: programEn,
      rundownEn: rundownEn,
    );
  }
}

class EventSeed {
  EventSeed._();

  static final featured = EventItem(
    foto: 'assets/images/beranda/thumb_event1.png',
    kategori: 'BUDAYA',
    lokasi: 'Tepian Danau Poso, Anjungan Tentena, Kab. Poso',
    wilayah: 'Poso',
    nama: 'Festival Danau Poso ke-24',
    deskripsi:
        'Parade budaya, tari mogele, & lomba perahu naga di tepian Danau Poso.',
    rentangTanggal: '24 - 26 Oktober 2026',
    start: DateTime(2026, 10, 24),
    end: DateTime(2026, 10, 26),
    rating: 4.9,
    ratingCount: 1200,
  );

  static final List<EventItem> agenda = [
    EventItem(
      foto: 'assets/images/beranda/pasar_kreatif_hero.png',
      kategori: 'UMKM',
      lokasi: 'Taman GOR, Palu',
      wilayah: 'Palu',
      nama: 'Pasar Kreatif Sulteng',
      deskripsi: 'Kriya lokal, kuliner khas, dan musik serba.',
      rentangTanggal: '31 Oktober - 1 November 2026',
      start: DateTime(2026, 10, 31),
      end: DateTime(2026, 11, 1),
      rating: 4.7,
      ratingCount: 1100,
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_pulo_dua.png',
      kategori: 'BAHARI',
      lokasi: 'Pesisir Teluk Tomini, Parigi Moutong',
      wilayah: 'Parigi Moutong',
      nama: 'Festival Teluk Tomini (FTT)',
      deskripsi: 'Karnaval bahari & expo UMKM di tepi teluk.',
      rentangTanggal: '18 - 20 November 2026',
      start: DateTime(2026, 11, 18),
      end: DateTime(2026, 11, 20),
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_bada.png',
      kategori: 'BUDAYA',
      lokasi: 'Lembah Bada, Poso',
      wilayah: 'Poso',
      nama: 'Jelajah Megalitikum Lore',
      deskripsi: 'Jelajah situs purba bersama penduduk lokal.',
      rentangTanggal: '28 - 29 November 2026',
      start: DateTime(2026, 11, 28),
      end: DateTime(2026, 11, 29),
      harga: 150000,
    ),
    EventItem(
      foto: 'assets/images/beranda/kartu_kolam_kaca.png',
      kategori: 'UMKM',
      lokasi: 'Kota Palu',
      wilayah: 'Palu',
      nama: 'Pekan Kuliner Kaili',
      deskripsi: 'Cicipi kuliner nusantara rasa khas Kaili.',
      rentangTanggal: '12 - 13 Desember 2026',
      start: DateTime(2026, 12, 12),
      end: DateTime(2026, 12, 13),
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
      end: DateTime(2026, 10, 8),
    ),
    EventItem(
      foto: 'assets/images/beranda/kartu_sombori.png',
      kategori: 'UMKM',
      lokasi: 'Taman GOR, Kota Palu',
      wilayah: 'Palu',
      nama: 'Gelar UMKM Kota Palu',
      deskripsi: 'Bazar kuliner Kaili, kriya lokal, dan oleh-oleh khas Sulawesi Tengah.',
      rentangTanggal: '4 - 6 April 2026',
      start: DateTime(2026, 4, 4),
      end: DateTime(2026, 4, 6),
    ),
    EventItem(
      foto: 'assets/images/destinasi/card_togean.png',
      kategori: 'BAHARI',
      lokasi: 'Kepulauan Togean, Tojo Una-Una',
      wilayah: 'Tojo Una-Una',
      nama: 'Wisata Pulau Togean',
      deskripsi:
          'Snorkeling, jelajah pulau, dan pengalaman bermalam di tepi pantai.',
      rentangTanggal: '28 - 31 Agustus 2026',
      start: DateTime(2026, 8, 28),
      end: DateTime(2026, 8, 31),
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
      end: DateTime(2026, 12, 18),
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
