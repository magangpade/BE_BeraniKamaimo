import 'package:flutter/material.dart';

/// Seed data Tab Eksplor — "Katalog Wisata & Kuliner" sesuai 2 PNG export
/// desain dari user (Tempat Menginap & Kuliner Khas).
///
/// CATATAN: data dummy hardcode gaya Tab Paket; foto diambil dari Wikimedia
/// Commons (bebas pakai) ke `assets/images/eksplor/`. Ganti ke API sesungguhnya
/// (hotel/kuliner) saat M2 sambung backend.
class HotelItem {
  final String foto; // path asset
  final String nama;
  final String wilayah; // samakan dengan chip: Palu | Luwuk | Ampana & Togean
  final String lokasi; // pill pin di atas foto
  final String tag; // pill kanan atas foto
  final String rating;
  final String ratingCount;
  final String highlight; // pill kanan bawah foto
  final int harga;
  final int? hargaCoret;
  final List<(IconData, String)> chips;

  const HotelItem({
    required this.foto,
    required this.nama,
    required this.wilayah,
    required this.lokasi,
    required this.tag,
    required this.rating,
    required this.ratingCount,
    required this.highlight,
    required this.harga,
    required this.chips,
    this.hargaCoret,
  });
}

class KulinerItem {
  final String foto;
  final String nama;
  final String warung;
  final String wilayah;
  final String? tag; // pill kiri atas foto ("Legendaris")
  final String deskripsi;
  final List<(String, ChipKind)> bahan;

  const KulinerItem({
    required this.foto,
    required this.nama,
    required this.warung,
    required this.wilayah,
    required this.deskripsi,
    required this.bahan,
    this.tag,
  });
}

/// Warna chip bahan kuliner (mint | peach/pink | cream) sesuai desain.
enum ChipKind { mint, peach, cream }

class EksplorSeed {
  EksplorSeed._();

  static const wilayah = ['Semua Wilayah', 'Palu', 'Luwuk', 'Ampana & Togean'];

  static const hotel = <HotelItem>[
    HotelItem(
      foto: 'assets/images/eksplor/hotel1.jpg',
      nama: 'Swiss–Belhotel Silae Palu',
      wilayah: 'Palu',
      lokasi: 'Teluk Palu, Palu Barat',
      tag: 'Bintang 4 Resor',
      rating: '4.7',
      ratingCount: '1.2k',
      highlight: 'Sea View',
      harga: 750000,
      hargaCoret: 1600000,
      chips: [
        (Icons.water_rounded, 'Kolam View Laut'),
        (Icons.apartment_rounded, '130 Kamar'),
        (Icons.king_bed_rounded, '2 King Bed Opsi'),
      ],
    ),
    HotelItem(
      foto: 'assets/images/eksplor/hotel2.jpg',
      nama: 'Tanjung Karang Beach Resort',
      wilayah: 'Donggala',
      lokasi: 'Tanjung Karang, Donggala',
      tag: 'Resor Pantai',
      rating: '4.6',
      ratingCount: '310',
      highlight: 'Private Beach',
      harga: 480000,
      hargaCoret: 850000,
      chips: [
        (Icons.waves_rounded, 'Panorama Laut'),
        (Icons.apartment_rounded, '58 Kamar'),
        (Icons.restore_rounded, 'Buffet Sarapan'),
      ],
    ),
    HotelItem(
      foto: 'assets/images/eksplor/hotel3.jpg',
      nama: 'Luwuk Bay Guest House',
      wilayah: 'Luwuk',
      lokasi: 'Luwuk Timur, Luwuk',
      tag: 'Guesthouse Pesisir',
      rating: '4.5',
      ratingCount: '812',
      highlight: 'Sunset Deck',
      harga: 320000,
      hargaCoret: 550000,
      chips: [
        (Icons.waves_rounded, 'Napas Pantai'),
        (Icons.king_bed_rounded, '2 Queen Bed'),
        (Icons.restore_rounded, 'Buffet Sarapan'),
      ],
    ),
    HotelItem(
      foto: 'assets/images/eksplor/hotel4.jpg',
      nama: 'Bukabuka Island Resort',
      wilayah: 'Ampana & Togean',
      lokasi: 'Pulau Buka-Buka, Togean',
      tag: 'Island Retreat',
      rating: '4.9',
      ratingCount: '96',
      highlight: 'Snorkeling Langsung',
      harga: 950000,
      chips: [
        (Icons.waves_rounded, 'Pasir Putih Privat'),
        (Icons.cottage_rounded, '12 Bungalow'),
        (Icons.scuba_diving_outlined, 'Snorkeling Gratis'),
      ],
    ),
  ];

  static const kuliner = <KulinerItem>[
    KulinerItem(
      foto: 'assets/images/eksplor/kuliner1.jpg',
      nama: 'Onyop (Kuah Asam Ikan Segar)',
      warung: 'R.M TINAKU 2 (Khas Kaili)',
      wilayah: 'Palu',
      deskripsi: 'Kuah asam pedas segar dari asam jawa muda santan, potongan '
          'ikan segar, dan cabai rawit hijau — makan siang legendaris '
          'pesisir Teluk Palu.',
      bahan: [
        ('🌿 Asam Jawa Muda', ChipKind.mint),
        ('🌶️ Cabai Rawit Hijau', ChipKind.peach),
        ('🍠 Singkong Rebus', ChipKind.cream),
      ],
    ),
    KulinerItem(
      foto: 'assets/images/eksplor/kuliner2.jpg',
      nama: 'Kaledo (Kaki Lemboe Asli)',
      warung: 'Kaledo Donggala',
      wilayah: 'Donggala',
      tag: 'Legendaris',
      deskripsi: 'Sup sumsum tulang kaki sapi empuk berkuah asam pedas khas '
          'rempah asam jawa mentah (uve kalopo) dan cabai rawit hijau yang '
          'disedot langsung dengan sedotan bambu.',
      bahan: [
        ('🌿 Asam Jawa Segar', ChipKind.mint),
        ('🌶️ Cabai Rawit Hijau', ChipKind.peach),
        ('🍠 Singkong Rebus', ChipKind.cream),
      ],
    ),
    KulinerItem(
      foto: 'assets/images/eksplor/kuliner3.jpg',
      nama: 'Lalampa (Ketan Bakar Isi Tuna)',
      warung: 'Raja Lalampa Toboli',
      wilayah: 'Palu',
      deskripsi: 'Beras ketan berisi ikan tuna bakar bumbu pedas, dibungkus '
          'daun pisang lalu dibakar — jajanan legendaris di jalur Toboli '
          'menuju Poso.',
      bahan: [
        ('🌾 Beras Ketan', ChipKind.mint),
        ('🐟 Tuna Bumbu', ChipKind.peach),
        ('🌿 Daun Pisang', ChipKind.cream),
      ],
    ),
    KulinerItem(
      foto: 'assets/images/eksplor/kuliner4.jpg',
      nama: 'Uta Dada (Kuah Kuning Rempah)',
      warung: 'R.M Uta Dada Palu',
      wilayah: 'Palu',
      tag: 'Autentik',
      deskripsi: 'Kuah kuning santan rempah dengan daging empuk dan sayuran '
          'khas punuk Kaili — hidangan hangat rumahan paling dicari saat '
          'musim hujan.',
      bahan: [
        ('🌶️ Kunyit Segar', ChipKind.mint),
        ('🥥 Santan Kental', ChipKind.peach),
        ('🍲 Daging Sapi', ChipKind.cream),
      ],
    ),
  ];

  /// "750000" → "Rp 750.000" (gaya format Tab Paket).
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
