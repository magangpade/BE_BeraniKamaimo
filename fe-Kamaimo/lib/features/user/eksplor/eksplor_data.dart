import 'package:flutter/material.dart';
import '../../../models/hotel.dart';
import '../../../models/kuliner.dart';

/// Seed data Tab Eksplor — "Katalog Wisata & Kuliner" sesuai 2 PNG export
/// desain dari user (Tempat Menginap & Kuliner Khas).
class HotelItem {
  final int? id;
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
  final String telepon;
  final String website;
  final String linkGmaps;

  const HotelItem({
    this.id,
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
    this.telepon = '',
    this.website = '',
    this.linkGmaps = '',
  });

  factory HotelItem.fromModel(Hotel h) {
    return HotelItem(
      id: h.id,
      foto: h.foto != null && h.foto!.isNotEmpty ? h.foto! : 'assets/images/eksplor/hotel1.jpg',
      nama: h.nama_hotel,
      wilayah: h.wilayah != null && h.wilayah!.isNotEmpty
          ? h.wilayah!
          : (h.lokasi.contains('Palu')
              ? 'Palu'
              : (h.lokasi.contains('Luwuk') ? 'Luwuk' : 'Ampana & Togean')),
      lokasi: h.lokasi,
      tag: h.tag != null && h.tag!.isNotEmpty ? h.tag! : 'Akomodasi Nyaman',
      rating: h.rating,
      ratingCount: h.rating_count,
      highlight: h.highlight != null && h.highlight!.isNotEmpty
          ? h.highlight!
          : 'Pilihan Terbaik',
      harga: h.harga_minimum > 0 ? h.harga_minimum : 450000,
      hargaCoret: h.harga_maximum > 0 ? h.harga_maximum : null,
      telepon: h.telepon,
      website: h.website,
      linkGmaps: h.linkGmaps,
      chips: [
        (Icons.apartment_rounded, '${h.jumlah_kamar > 0 ? h.jumlah_kamar : 24} Kamar'),
        (Icons.king_bed_rounded, '${h.jumlah_tempatTidur > 0 ? h.jumlah_tempatTidur : 2} Tempat Tidur'),
        (Icons.waves_rounded, 'Panorama Alam'),
      ],
    );
  }
}

class KulinerItem {
  final int? id;
  final String foto;
  final String nama;
  final String warung;
  final String wilayah;
  final String? tag; // pill kiri atas foto ("Legendaris")
  final String deskripsi;
  final List<(IconData, String, ChipKind)> bahan;
  final String linkGmaps;
  final String telepon;

  const KulinerItem({
    this.id,
    required this.foto,
    required this.nama,
    required this.warung,
    required this.wilayah,
    required this.deskripsi,
    required this.bahan,
    this.tag,
    this.linkGmaps = '',
    this.telepon = '',
  });

  factory KulinerItem.fromModel(Kuliner k) {
    List<(IconData, String, ChipKind)> bahanList = [];
    if (k.bahan != null && k.bahan!.isNotEmpty) {
      final parts = k.bahan!.split(',');
      for (int i = 0; i < parts.length; i++) {
        final p = parts[i].trim();
        final kind = i % 3 == 0
            ? ChipKind.mint
            : (i % 3 == 1 ? ChipKind.peach : ChipKind.cream);
        final cleanText = p.replaceFirst(RegExp(r'^[^\w\s]+\s*'), '');
        final l = p.toLowerCase();
        IconData icon = KulinerIcons.asamJawa;
        if (l.contains('cabai') || l.contains('pedas') || l.contains('rica')) {
          icon = KulinerIcons.cabai;
        } else if (l.contains('tuna') || l.contains('ikan')) {
          icon = KulinerIcons.tuna;
        } else if (l.contains('pisang')) {
          icon = KulinerIcons.daunPisang;
        } else if (l.contains('santan')) {
          icon = KulinerIcons.santan;
        } else if (l.contains('daging') || l.contains('ayam') || l.contains('sapi') || l.contains('tulang') || l.contains('rusuk')) {
          icon = KulinerIcons.daging;
        } else if (l.contains('ketan') || l.contains('beras') || l.contains('singkong') || l.contains('ubi')) {
          icon = KulinerIcons.singkong;
        } else if (l.contains('kunyit') || l.contains('jahe')) {
          icon = KulinerIcons.kunyit;
        }
        bahanList.add((icon, cleanText.isNotEmpty ? cleanText : p, kind));
      }
    } else {
      bahanList = const [
        (KulinerIcons.asamJawa, 'Rempah Tradisional', ChipKind.mint),
        (KulinerIcons.cabai, 'Bumbu Khas Sulteng', ChipKind.peach),
        (KulinerIcons.daging, 'Resep Warisan', ChipKind.cream),
      ];
    }

    return KulinerItem(
      id: k.id,
      foto: k.foto != null && k.foto!.isNotEmpty ? k.foto! : 'assets/images/eksplor/kuliner1.jpg',
      nama: k.nama_makanan,
      warung: k.warung != null && k.warung!.isNotEmpty
          ? k.warung!
          : (k.lokasi.isNotEmpty ? 'Khas ${k.lokasi}' : 'Khas Sulawesi Tengah'),
      wilayah: k.wilayah != null && k.wilayah!.isNotEmpty
          ? k.wilayah!
          : (k.lokasi.contains('Donggala') ? 'Donggala' : 'Palu'),
      tag: k.tag,
      deskripsi: k.deskripsi_id,
      bahan: bahanList,
      linkGmaps: k.linkGmaps ?? '',
    );
  }
}

/// Warna chip bahan kuliner (mint | peach/pink | cream) sesuai desain.
enum ChipKind { mint, peach, cream }

/// Ikon bahan kuliner (pengganti emoji agar konsisten dengan ikon app).
class KulinerIcons {
  KulinerIcons._();

  static const asamJawa = Icons.eco_rounded;
  static const cabai = Icons.local_fire_department_rounded;
  static const singkong = Icons.grain_rounded;
  static const tuna = Icons.set_meal_rounded;
  static const daunPisang = Icons.spa_rounded;
  static const kunyit = Icons.eco_rounded;
  static const santan = Icons.water_drop_rounded;
  static const daging = Icons.dinner_dining_rounded;
}

class EksplorSeed {
  EksplorSeed._();

  static const wilayah = [
    'Semua Wilayah',
    'Palu',
    'Donggala',
    'Luwuk',
    'Ampana & Togean',
  ];

  static const hotel = <HotelItem>[
    HotelItem(
      id: 22,
      foto: '/uploads/1774568877468.jpg',
      nama: 'Hotel Santika Palu',
      wilayah: 'Palu',
      lokasi: 'Jl. Moh. Hatta No.18, Palu Timur',
      tag: 'Bintang 4 Resor',
      rating: '4.7',
      ratingCount: '120',
      highlight: 'Pilihan Terbaik',
      harga: 571463,
      hargaCoret: 761671,
      chips: [
        (Icons.apartment_rounded, '144 Kamar'),
        (Icons.king_bed_rounded, '226 Tempat Tidur'),
        (Icons.wifi_rounded, 'WiFi & Kolam Renang'),
      ],
      telepon: '+62 451 424888',
      website: 'mysantika.com',
      linkGmaps: 'https://maps.google.com/?q=Hotel+Santika+Palu',
    ),
    HotelItem(
      id: 26,
      foto: '/uploads/1774570141538.jpg',
      nama: 'Rama Garden Hotel',
      wilayah: 'Palu',
      lokasi: 'Jl. Tj. Santigi No.26, Palu Selatan',
      tag: 'Hotel Nyaman',
      rating: '4.7',
      ratingCount: '120',
      highlight: 'Asri & Tenang',
      harga: 350000,
      hargaCoret: 600000,
      chips: [
        (Icons.apartment_rounded, '95 Kamar'),
        (Icons.king_bed_rounded, '131 Tempat Tidur'),
        (Icons.park_rounded, 'Taman Asri'),
      ],
      telepon: '081145602200',
      linkGmaps: 'https://maps.google.com/?q=Rama+Garden+Hotel+Palu',
    ),
    HotelItem(
      id: 34,
      foto: '/uploads/1774574714116.jpg',
      nama: 'Aston Palu Hotel & Conference Center',
      wilayah: 'Palu',
      lokasi: 'Jl. Wolter Monginsidi No.60, Palu Selatan',
      tag: 'Bintang 4 Konferensi',
      rating: '4.8',
      ratingCount: '240',
      highlight: 'Pusat Kota',
      harga: 727721,
      hargaCoret: 1200000,
      chips: [
        (Icons.apartment_rounded, '139 Kamar'),
        (Icons.king_bed_rounded, '159 Tempat Tidur'),
        (Icons.meeting_room_rounded, 'Ballroom & Resto'),
      ],
      telepon: '+62 811 4255 0027',
      website: 'astonhotelsinternational.com',
      linkGmaps: 'https://maps.google.com/?q=Aston+Palu+Hotel',
    ),
    HotelItem(
      id: 45,
      foto: '/uploads/1774596057314.jpg',
      nama: 'Jazz Hotel',
      wilayah: 'Palu',
      lokasi: 'Jl. Zebra II No.11, Birobuli Utara',
      tag: 'Modern Populer',
      rating: '4.7',
      ratingCount: '120',
      highlight: 'Dekat Bandara',
      harga: 350000,
      hargaCoret: 483498,
      chips: [
        (Icons.apartment_rounded, '59 Kamar'),
        (Icons.king_bed_rounded, '93 Tempat Tidur'),
        (Icons.local_cafe_rounded, 'Cafe & Resto'),
      ],
      telepon: '+62 821-8865-0387',
      linkGmaps: 'https://maps.google.com/?q=Jazz+Hotel+Palu',
    ),
    HotelItem(
      id: 46,
      foto: '/uploads/1774596473766.jpg',
      nama: 'Sutan Raja Hotel Palu',
      wilayah: 'Palu',
      lokasi: 'Jl. DR. Abdurrahman Saleh No.45, Palu Selatan',
      tag: 'Bintang 4 Mewah',
      rating: '4.7',
      ratingCount: '180',
      highlight: 'Fasilitas Lengkap',
      harga: 606420,
      hargaCoret: 1100000,
      chips: [
        (Icons.apartment_rounded, '121 Kamar'),
        (Icons.king_bed_rounded, '156 Tempat Tidur'),
        (Icons.pool_rounded, 'Kolam Renang Besar'),
      ],
      telepon: '+62 811-412-136',
      linkGmaps: 'https://maps.google.com/?q=Sutan+Raja+Hotel+Palu',
    ),
    HotelItem(
      id: 47,
      foto: '/uploads/1774603126444.jpg',
      nama: 'Best Western Plus Coco Hotel',
      wilayah: 'Palu',
      lokasi: 'Jl. Basuki Rahmat No. 127, Palu Selatan',
      tag: 'Bintang 4 Internasional',
      rating: '4.8',
      ratingCount: '310',
      highlight: 'Premium Stay',
      harga: 756575,
      hargaCoret: 846000,
      chips: [
        (Icons.apartment_rounded, '138 Kamar'),
        (Icons.king_bed_rounded, '221 Tempat Tidur'),
        (Icons.fitness_center_rounded, 'Fitness & Spa'),
      ],
      telepon: '+62 451 481500',
      linkGmaps: 'https://maps.google.com/?q=Best+Western+Plus+Coco+Hotel+Palu',
    ),
  ];

  static const kuliner = <KulinerItem>[
    KulinerItem(
      id: 4,
      foto: '/uploads/1774538101428.jpeg',
      nama: 'Ayam Panggang Biromaru',
      warung: 'Kuliner Khas Sigi',
      wilayah: 'Sigi',
      tag: 'Legendaris',
      deskripsi: 'Ayam panggang Biromaru adalah kuliner legendaris khas kabupaten Sigi, Sulawesi Tengah (populer di area Palu) yang menggunakan ayam kampung muda dengan bumbu santan kental yang dipanggang berulang kali hingga gurih dan harum.',
      bahan: [
        (KulinerIcons.daging, 'Ayam Kampung Muda', ChipKind.mint),
        (KulinerIcons.santan, 'Kuah Santan Kental', ChipKind.peach),
        (KulinerIcons.cabai, 'Rica-Rica & Jeruk', ChipKind.cream),
      ],
    ),
    KulinerItem(
      id: 16,
      foto: '/uploads/1774937784596.jpg',
      nama: 'Kaledo (Kaki Lembu Donggala)',
      warung: 'Kuliner Khas Donggala',
      wilayah: 'Donggala',
      tag: 'Ikonik',
      deskripsi: 'Kaledo adalah ikon kuliner Sulawesi Tengah berupa sup tulang kaki sapi dengan sumsum melimpah, disajikan dalam kuah bening asam pedas segar dari asam jawa muda dan dinikmati dengan sedotan bambu serta ubi rebus.',
      bahan: [
        (KulinerIcons.daging, 'Tulang Kaki Sapi', ChipKind.mint),
        (KulinerIcons.asamJawa, 'Asam Jawa Segar', ChipKind.peach),
        (KulinerIcons.singkong, 'Singkong / Ubi Rebus', ChipKind.cream),
      ],
    ),
    KulinerItem(
      id: 17,
      foto: '/uploads/1774938780385.jpg',
      nama: 'Uvempoi',
      warung: 'Kuliner Tradisional Kaili',
      wilayah: 'Palu',
      tag: 'Autentik',
      deskripsi: 'Uvempoi adalah sup rusuk sapi khas suku Kaili dengan kuah asam segar beraroma rempah tradisional, dimasak hingga daging empuk meresap dan sangat nikmat disajikan hangat dengan burasa.',
      bahan: [
        (KulinerIcons.daging, 'Rusuk Sapi Segar', ChipKind.mint),
        (KulinerIcons.asamJawa, 'Kuah Asam Segar', ChipKind.peach),
        (KulinerIcons.singkong, 'Burasa Tradisional', ChipKind.cream),
      ],
    ),
    KulinerItem(
      id: 18,
      foto: '/uploads/1774940102823.jpg',
      nama: 'Utadada',
      warung: 'Kuliner Tradisional Kaili',
      wilayah: 'Palu',
      tag: 'Tradisional',
      deskripsi: 'Utadada adalah masakan khas Kaili berbahan dasar jeroan dan daging sapi yang dimasak dalam kuah santan kental gurih berempah kaya cita rasa yang hangat dan memikat.',
      bahan: [
        (KulinerIcons.daging, 'Olahan Sapi Pilihan', ChipKind.mint),
        (KulinerIcons.santan, 'Santan Rempah Kental', ChipKind.peach),
        (KulinerIcons.cabai, 'Bumbu Khas Kaili', ChipKind.cream),
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
