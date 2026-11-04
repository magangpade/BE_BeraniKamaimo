import 'package:flutter/material.dart';
import '../../../models/tour_package.dart';

/// Seed data Tab Paket — dummy, meniru desain Figma 4965:1243 "Paket Wisata Sulteng (Modern)".
class PaketItem {
  final int? id;
  final String foto;
  final String kategori; // BAHARI | BUDAYA | TREKKING
  final String wilayah;
  final String nama;
  final String tag; // chip emerald di atas foto
  final String durasi; // "4 Hari 3 Malam"
  final String tipe; // chip kanan info: "Water Cottage"
  final int harga;
  final String satuan; // "/orang" | "/tur"
  final double rating;
  final int ratingCount;
  final String deskripsi;
  final List<(IconData, String)> fasilitas;
  final String kontak;

  const PaketItem({
    this.id,
    required this.foto,
    required this.kategori,
    required this.wilayah,
    required this.nama,
    required this.tag,
    required this.durasi,
    required this.tipe,
    required this.harga,
    required this.satuan,
    required this.deskripsi,
    this.rating = 4.8,
    this.ratingCount = 80,
    this.fasilitas = const [],
    this.kontak = '6281234567890',
  });

  factory PaketItem.fromModel(TourPackage tp) {
    List<(IconData, String)> fasList = [];
    if (tp.fasilitas != null && tp.fasilitas!.isNotEmpty) {
      final parts = tp.fasilitas!.split(',');
      for (final p in parts) {
        final t = p.trim();
        IconData ic = Icons.check_circle_outline_rounded;
        if (t.toLowerCase().contains('makan')) ic = Icons.restaurant_rounded;
        if (t.toLowerCase().contains('guide')) ic = Icons.badge_rounded;
        if (t.toLowerCase().contains('perahu') || t.toLowerCase().contains('kapal')) ic = Icons.directions_boat_rounded;
        if (t.toLowerCase().contains('drone') || t.toLowerCase().contains('foto')) ic = Icons.photo_camera_rounded;
        if (t.toLowerCase().contains('snorkel')) ic = Icons.pool_rounded;
        if (t.toLowerCase().contains('transport') || t.toLowerCase().contains('bus')) ic = Icons.directions_bus_rounded;
        if (t.toLowerCase().contains('homestay') || t.toLowerCase().contains('hotel')) ic = Icons.cottage_rounded;
        fasList.add((ic, t));
      }
    } else {
      fasList = const [
        (Icons.badge_rounded, 'Guide HPI Berlisensi'),
        (Icons.restaurant_rounded, 'Makan & Minum'),
        (Icons.directions_boat_rounded, 'Transport Lokal'),
        (Icons.photo_camera_rounded, 'Dokumentasi'),
      ];
    }

    return PaketItem(
      id: tp.id,
      foto: tp.media != null && tp.media!.isNotEmpty ? tp.media! : 'assets/images/paket/paket_togean.png',
      kategori: tp.kategori.toUpperCase(),
      wilayah: tp.lokasi_id,
      nama: tp.nama_wisata_id,
      tag: tp.tipe.toUpperCase(),
      durasi: tp.durasi,
      tipe: tp.tipe,
      harga: tp.harga,
      satuan: '/orang',
      rating: double.tryParse(tp.rating) ?? 4.8,
      ratingCount: tp.rating_count,
      deskripsi: tp.deskripsi_id,
      fasilitas: fasList,
      kontak: tp.kontak.isNotEmpty ? tp.kontak : '6281234567890',
    );
  }
}

class PaketSeed {
  PaketSeed._();

  static const kategori = ['Semua', 'Bahari', 'Budaya', 'Trekking'];

  static const items = [
    PaketItem(
      foto: 'assets/images/paket/paket_togean.png',
      kategori: 'BAHARI',
      wilayah: 'Tojo Una-Una',
      nama: 'Eksotisme Kepulauan Togean',
      tag: 'CAGAR BIOSFER UNESCO',
      durasi: '4 Hari 3 Malam',
      tipe: 'Water Cottage',
      harga: 2850000,
      satuan: '/orang',
      rating: 4.9,
      ratingCount: 86,
      deskripsi: 'Berenang bersama ubur-ubur tanpa sengat Danau Mariona, snorkeling di gosong, dan berlabuh di pulau pribadi.',
      fasilitas: [
        (Icons.restaurant_rounded, 'Makan Lengkap'),
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.directions_boat_rounded, 'Perahu Pribadi'),
        (Icons.photo_camera_rounded, 'Dokumentasi Drone'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/paket_sambori.png',
      kategori: 'BAHARI',
      wilayah: 'Morowali',
      nama: 'Sombori Secret Paradise',
      tag: 'THE SECRET PARADISE',
      durasi: '3 Hari 2 Malam',
      tipe: 'Open Trip',
      harga: 350000,
      satuan: '/orang',
      rating: 4.95,
      ratingCount: 54,
      deskripsi: 'Laguna toska karst megah, tebing cadas, dan pasir putih Kepulauan Sombori bersama perahu eksklusif.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.directions_boat_rounded, 'Perahu Pribadi'),
        (Icons.pool_rounded, 'Snorkeling Set'),
        (Icons.photo_camera_rounded, 'Dokumentasi Drone'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/paket_megalitikum.png',
      kategori: 'BUDAYA',
      wilayah: 'Poso',
      nama: 'Misteri Lembah Bada & Megalitikum',
      tag: 'SITUS MEGALITIKUM',
      durasi: '2 Hari 1 Malam',
      tipe: 'Homestay Desa',
      harga: 650000,
      satuan: '/orang',
      rating: 4.8,
      ratingCount: 112,
      deskripsi: 'Menelusuri patung megalitik seribu tahun, rumah adat, dan tradisi api abadi di Lembah Bada.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.restaurant_rounded, 'Makan Lengkap'),
        (Icons.cottage_rounded, 'Homestay Lokal'),
        (Icons.directions_bus_rounded, 'Transport Touring'),
      ],
    ),
    PaketItem(
      foto: 'assets/images/paket/paket_poso.png',
      kategori: 'TREKKING',
      wilayah: 'Poso',
      nama: 'Trekking Air Terjun Saluopa',
      tag: 'DANAU & AIR TERJUN',
      durasi: '1 Hari',
      tipe: 'Paket Harian',
      harga: 250000,
      satuan: '/orang',
      rating: 4.7,
      ratingCount: 78,
      deskripsi: 'Jemput dari Tentena, petualangan di 12 tangga air jernih menuju puncak Air Terjun Saluopa.',
      fasilitas: [
        (Icons.badge_rounded, 'Guide HPI Lokal'),
        (Icons.confirmation_number_rounded, 'Tiket Masuk'),
        (Icons.lunch_dining_rounded, 'Makan Siang'),
        (Icons.directions_walk_rounded, 'Perjalanan Hidup'),
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
