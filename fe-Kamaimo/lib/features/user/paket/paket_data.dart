import 'package:flutter/material.dart';

import '../../../models/tour_package.dart';

/// Seed data Tab Paket — dummy, meniru desain Figma 4965:1243 "Paket Wisata Sulteng (Modern)".
/// ponytail: data hardcode; ganti ke /tourPackage saat sambung API.
class PaketItem {
  final String foto;
  final String kategori; // BAHARI | BUDAYA | TREKKING
  final String wilayah;
  final String nama;
  final String? namaEn;
  final String tag; // chip emerald di atas foto
  final String? tagEn;
  final String durasi; // "4 Hari 3 Malam"
  final String? durasiEn;
  final String tipe; // chip kanan info: "Water Cottage"
  final String? tipeEn;
  final int harga;
  final String satuan; // "/orang" | "/tur"
  final double rating;
  final int ratingCount;
  final String kontak;
  final String deskripsi;
  final String? deskripsiEn;
  final List<(IconData, String)> fasilitas;
  final List<(IconData, String)>? fasilitasEn;

  String get ratingKey =>
      nama.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');

  const PaketItem({
    required this.foto,
    required this.kategori,
    required this.wilayah,
    required this.nama,
    this.namaEn,
    required this.tag,
    this.tagEn,
    required this.durasi,
    this.durasiEn,
    required this.tipe,
    this.tipeEn,
    required this.harga,
    required this.satuan,
    required this.deskripsi,
    this.deskripsiEn,
    this.rating = 4.8,
    this.ratingCount = 80,
    this.kontak = '',
    this.fasilitas = const [],
    this.fasilitasEn,
  });

  factory PaketItem.fromModel(TourPackage p) {
    String kat = 'BAHARI';
    final n = (p.nama_wisata_id + ' ' + p.lokasi_id).toLowerCase();
    if (n.contains('bada') ||
        n.contains('desa') ||
        n.contains('tenun') ||
        n.contains('budaya')) {
      kat = 'BUDAYA';
    } else if (n.contains('lindu') ||
        n.contains('paralayang') ||
        n.contains('salena') ||
        n.contains('valley')) {
      kat = 'TREKKING';
    }

    String wil = 'Sulteng';
    if (n.contains('poso'))
      wil = 'Poso';
    else if (n.contains('togean') ||
        n.contains('ampana') ||
        n.contains('kadidiri'))
      wil = 'Tojo Una-Una';
    else if (n.contains('banggai') || n.contains('paisupok'))
      wil = 'Banggai';
    else if (n.contains('morowali') ||
        n.contains('sombori') ||
        n.contains('sambori'))
      wil = 'Morowali';
    else if (n.contains('donggala') ||
        n.contains('towale') ||
        n.contains('tanjung karang'))
      wil = 'Donggala';
    else if (n.contains('palu') || n.contains('salena'))
      wil = 'Palu';
    else if (n.contains('sigi') || n.contains('lindu'))
      wil = 'Sigi';

    final rawFasilitas = (p.fasilitas ?? '')
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map((s) => (Icons.check_circle_outline, s))
        .toList();

    return PaketItem(
      foto: (p.media != null && p.media!.isNotEmpty)
          ? p.media!
          : 'assets/images/paket/foto_card1_togean.png',
      kategori: p.kategori?.isNotEmpty == true ? p.kategori! : kat,
      wilayah: p.wilayah?.isNotEmpty == true ? p.wilayah! : wil,
      nama: p.nama_wisata_id,
      namaEn: p.nama_wisata_en,
      tag: (p.tag != null && p.tag!.trim().isNotEmpty)
          ? p.tag!
          : 'Paket Populer',
      tagEn: (p.tag != null && p.tag!.trim().isNotEmpty)
          ? p.tag!
          : 'Popular Package',
      durasi: (p.durasi != null && p.durasi!.trim().isNotEmpty)
          ? p.durasi!
          : '3 Hari 2 Malam',
      durasiEn: (p.durasi != null && p.durasi!.trim().isNotEmpty)
          ? p.durasi!
          : '3 Days 2 Nights',
      tipe: (p.tipe != null && p.tipe!.trim().isNotEmpty)
          ? p.tipe!
          : 'Tur Terbimbing',
      tipeEn: (p.tipe != null && p.tipe!.trim().isNotEmpty)
          ? p.tipe!
          : 'Guided Tour',
      harga: p.harga > 0 ? p.harga : 1500000,
      satuan: p.satuan?.isNotEmpty == true ? p.satuan! : '/orang',
      deskripsi: p.deskripsi_id,
      deskripsiEn: p.deskripsi_en,
      rating: p.rating,
      ratingCount: p.ratingCount,
      kontak: p.kontak,
      fasilitas: rawFasilitas.isNotEmpty
          ? rawFasilitas
          : const [
              (Icons.directions_boat_rounded, 'Transportasi'),
              (Icons.hotel_rounded, 'Akomodasi'),
              (Icons.restaurant_rounded, 'Konsumsi'),
              (Icons.person_rounded, 'Pemandu Lokal'),
            ],
      fasilitasEn: const [
        (Icons.directions_boat_rounded, 'Transportation'),
        (Icons.hotel_rounded, 'Accommodation'),
        (Icons.restaurant_rounded, 'Meals Included'),
        (Icons.person_rounded, 'Local Guide'),
      ],
    );
  }

  String displayName(bool isEnglish) => isEnglish ? (namaEn ?? nama) : nama;
  String displayTag(bool isEnglish) => isEnglish ? (tagEn ?? tag) : tag;
  String displayDuration(bool isEnglish) =>
      isEnglish ? (durasiEn ?? durasi) : durasi;
  String displayType(bool isEnglish) => isEnglish ? (tipeEn ?? tipe) : tipe;
  String displayDescription(bool isEnglish) =>
      isEnglish ? (deskripsiEn ?? deskripsi) : deskripsi;
  String displayCategory(bool isEnglish) {
    if (!isEnglish) return kategori;
    return switch (kategori) {
      'BAHARI' => 'Marine',
      'BUDAYA' => 'Culture',
      'TREKKING' => 'Trekking',
      'EKOWISATA' => 'Ecotourism',
      'UMKM' => 'MSME',
      _ => kategori,
    };
  }

  List<(IconData, String)> displayFacilities(bool isEnglish) =>
      isEnglish ? (fasilitasEn ?? fasilitas) : fasilitas;
}

class PaketSeed {
  PaketSeed._();

  static const kategori = ['Semua', 'Bahari', 'Budaya', 'Trekking', 'Ekowisata', 'UMKM'];

  static const items = [
    PaketItem(
      foto: 'assets/images/paket/figma_package_asset_1.png',
      kategori: 'TREKKING',
      wilayah: 'Taman Nasional Lore Lindu',
      nama: 'Ekspedisi Lore Lindu & Puncak Rore Kautimbu',
      namaEn: 'Lore Lindu & Mount Rore Kautimbu Expedition',
      tag: 'TAMAN NASIONAL LORE LINDU',
      tagEn: 'LORE LINDU NATIONAL PARK',
      durasi: '3 Hari 2 Malam',
      durasiEn: '3 Days 2 Nights',
      tipe: 'Tenda Dome & Camp',
      tipeEn: 'Dome Tent & Camping',
      harga: 2150000,
      satuan: '/orang',
      rating: 4.9,
      ratingCount: 86,
      deskripsi: 'Perpaduan pendakian lintas hutan lumut endemik menuju Puncak Rore Kautimbu.',
      deskripsiEn: 'A guided trek through endemic moss forest toward the summit of Mount Rore Kautimbu.',
      fasilitas: [
        (Icons.restaurant_rounded, 'Makan Lengkap'),
        (Icons.badge_rounded, 'Porter & Guide HPI'),
        (Icons.terrain_rounded, 'Perlengkapan Camp'),
        (Icons.verified_user_rounded, 'Asuransi & Simaksi'),
      ],
      fasilitasEn: [
        (Icons.restaurant_rounded, 'Full Meals'),
        (Icons.badge_rounded, 'Porter & HPI Guide'),
        (Icons.terrain_rounded, 'Camping Gear'),
        (Icons.verified_user_rounded, 'Insurance & Permit'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/paket_togean.png',
      kategori: 'BAHARI',
      wilayah: 'Tojo Una-Una',
      nama: 'Eksotisme Kepulauan Togean',
      namaEn: 'The Exotic Togean Islands',
      tag: 'CAGAR BIOSFER UNESCO',
      tagEn: 'UNESCO BIOSPHERE RESERVE',
      durasi: '4 Hari 3 Malam',
      durasiEn: '4 Days 3 Nights',
      tipe: 'Water Cottage',
      tipeEn: 'Water Cottage',
      harga: 2850000,
      satuan: '/orang',
      rating: 4.9,
      ratingCount: 86,
      deskripsi: 'Berenang bersama ubur-ubur tanpa sengat Danau Mariona, snorkeling di gosong, dan berlabuh di pulau pribadi.',
      deskripsiEn: 'Swim with Mariona Lake’s stingless jellyfish, snorkel on the reef, and visit a private island.',
      fasilitas: [
        (Icons.restaurant_rounded, 'Makan Lengkap'),
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.directions_boat_rounded, 'Perahu Pribadi'),
        (Icons.photo_camera_rounded, 'Dokumentasi Drone'),
      ],
      fasilitasEn: [
        (Icons.restaurant_rounded, 'Full Meals'),
        (Icons.badge_rounded, 'Local HPI Guide'),
        (Icons.directions_boat_rounded, 'Private Boat'),
        (Icons.photo_camera_rounded, 'Drone Photos'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/paket_sambori.png',
      kategori: 'BAHARI',
      wilayah: 'Morowali',
      nama: 'Sombori Secret Paradise',
      namaEn: 'Sombori Secret Paradise',
      tag: 'THE SECRET PARADISE',
      tagEn: 'THE SECRET PARADISE',
      durasi: '3 Hari 2 Malam',
      durasiEn: '3 Days 2 Nights',
      tipe: 'Open Trip',
      tipeEn: 'Open Trip',
      harga: 350000,
      satuan: '/orang',
      rating: 4.95,
      ratingCount: 54,
      deskripsi: 'Laguna toska karst megah, tebing cadas, dan pasir putih Kepulauan Sombori bersama perahu eksklusif.',
      deskripsiEn: 'Explore Sombori’s turquoise karst lagoons, dramatic cliffs, and white-sand beaches by private boat.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.directions_boat_rounded, 'Perahu Pribadi'),
        (Icons.pool_rounded, 'Snorkeling Set'),
        (Icons.photo_camera_rounded, 'Dokumentasi Drone'),
      ],
      fasilitasEn: [
        (Icons.badge_rounded, 'Local HPI Guide'),
        (Icons.directions_boat_rounded, 'Private Boat'),
        (Icons.pool_rounded, 'Snorkeling Set'),
        (Icons.photo_camera_rounded, 'Drone Photos'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/figma_package_asset_4.png',
      kategori: 'BUDAYA',
      wilayah: 'Poso',
      nama: 'Misteri Lembah Bada & Megalitikum',
      namaEn: 'Bada Valley & Megalithic Mystery',
      tag: 'SITUS MEGALITIKUM',
      tagEn: 'MEGALITHIC SITE',
      durasi: '2 Hari 1 Malam',
      durasiEn: '2 Days 1 Night',
      tipe: 'Homestay Desa',
      tipeEn: 'Village Homestay',
      harga: 650000,
      satuan: '/orang',
      rating: 4.8,
      ratingCount: 112,
      deskripsi: 'Menelusuri patung megalitik seribu tahun, rumah adat, dan tradisi api abadi di Lembah Bada.',
      deskripsiEn: 'Discover thousand-year-old megaliths, traditional homes, and the eternal flame tradition in Bada Valley.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.restaurant_rounded, 'Makan Lengkap'),
        (Icons.cottage_rounded, 'Homestay Lokal'),
        (Icons.directions_bus_rounded, 'Transport Touring'),
      ],
      fasilitasEn: [
        (Icons.badge_rounded, 'Local HPI Guide'),
        (Icons.restaurant_rounded, 'Full Meals'),
        (Icons.cottage_rounded, 'Local Homestay'),
        (Icons.directions_bus_rounded, 'Tour Transport'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/figma_package_asset_3.png',
      kategori: 'TREKKING',
      wilayah: 'Poso',
      nama: 'Trekking Air Terjun Saluopa',
      namaEn: 'Saluopa Waterfall Trekking',
      tag: 'DANAU & AIR TERJUN',
      tagEn: 'LAKES & WATERFALLS',
      durasi: '1 Hari',
      durasiEn: '1 Day',
      tipe: 'Paket Harian',
      tipeEn: 'Day Tour',
      harga: 250000,
      satuan: '/orang',
      rating: 4.7,
      ratingCount: 78,
      deskripsi: 'Jemput dari Tentena, petualangan di 12 tangga air jernih menuju puncak Air Terjun Saluopa.',
      deskripsiEn: 'Start in Tentena and climb 12 clear-water tiers on an adventure to the top of Saluopa Waterfall.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.confirmation_number_rounded, 'Tiket Masuk'),
        (Icons.lunch_dining_rounded, 'Makan Siang'),
        (Icons.directions_walk_rounded, 'Trekking'),
      ],
      fasilitasEn: [
        (Icons.badge_rounded, 'Local HPI Guide'),
        (Icons.confirmation_number_rounded, 'Entry Ticket'),
        (Icons.lunch_dining_rounded, 'Lunch'),
        (Icons.directions_walk_rounded, 'Trekking'),
      ],
    ),
  ];

  /// "2850000" → "Rp 2.850.000" (format Rp Indonesia).
  static String formatRupiah(int nilai) {
    final digits = nilai.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return 'Rp $buffer';
  }
}
