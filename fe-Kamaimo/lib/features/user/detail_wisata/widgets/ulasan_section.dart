import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../models/ulasan.dart';

/// Section "Ulasan Pengunjung" (TESTIMONI NYATA) sesuai frame 4714:452:
/// tombol Tulis Ulasan + kartu testimoni (avatar inisial, nama, bintang, quote).
///
/// CATATAN: backend belum punya relasi ulasan→desa; ulasan yang tampil
/// global dari `UlasanRepository.getAll()` (tidak disaring per destinasi).
class UlasanSection extends StatelessWidget {
  final List<Ulasan> ulasanList;
  final VoidCallback onTulisUlasan;

  const UlasanSection({
    super.key,
    required this.ulasanList,
    required this.onTulisUlasan,
  });

  /// Testimoni demo sesuai Figma (2 kartu). Backend belum punya relasi
  /// ulasan→desa; saat data ulasan kosong, tampilkan konten demo ini
  /// agar section sesuai desain (ganti saat data per-desa tersedia).
  static const List<_DemoTestimoni> _demoTestimoni = [
    _DemoTestimoni(
      ulasan: Ulasan(
        id: -1,
        nama: 'Rian Kusuma',
        rating: 5,
        komentar: 'Sewa kano transparan sangat recommended, pemandangan danau '
            'dari atas air bening banget. Pemandu lokalnya juga jago cerita '
            'mitos Sea-Sea, seru buat road trip keluarga.',
        createdAt: '2024-06-15',
      ),
      tipeWisatawan: 'Solo Traveler',
      avatarPeach: false,
    ),
    _DemoTestimoni(
      ulasan: Ulasan(
        id: -2,
        nama: 'Dinda Widyawati',
        rating: 5,
        komentar: 'Rute feri dari Pelabuhan Luwuk gampang banget diikuti, tapi '
            'jangan lupa cek jadwal pasang-surut pas mau snorkeling di area '
            'rumput laut.',
        createdAt: '2024-05-20',
      ),
      tipeWisatawan: 'Keluarga',
      avatarPeach: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final row = ulasanList.isEmpty
        ? _demoTestimoni
        : [
            // Ulasan asli: warna avatar selang-seling mint/peach.
            for (final (i, u) in ulasanList.indexed)
              _DemoTestimoni(
                ulasan: u,
                avatarPeach: i.isOdd,
              ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header: eyebrow + judul ... tombol Tulis Ulasan
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TESTIMONI NYATA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      letterSpacing: 0.6, // Figma 0.05em @12px
                      color: AppColors.pine500,
                    ),
                  ),
                  SizedBox(height: 2.5),
                  Text(
                    'Ulasan Pengunjung',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 28 / 20,
                      letterSpacing: -0.5,
                      color: AppColors.pine900,
                    ),
                  ),
                ],
              ),
            ),
            _TulisUlasanButton(onTap: onTulisUlasan),
          ],
        ),
        const SizedBox(height: 16),

        // Kartu testimoni (gap 14)
        for (var i = 0; i < row.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          _TestimonialCard(
            ulasan: row[i].ulasan,
            tipeWisatawan: row[i].tipeWisatawan,
            avatarPeach: row[i].avatarPeach,
          ),
        ],
      ],
    );
  }
}

/// Pair untuk render kartu testimoni (data demo atau asli).
class _DemoTestimoni {
  final Ulasan ulasan;
  final String? tipeWisatawan;
  final bool avatarPeach;

  const _DemoTestimoni({
    required this.ulasan,
    this.tipeWisatawan,
    this.avatarPeach = false,
  });
}

/// Tombol pill pine "Tulis Ulasan".
class _TulisUlasanButton extends StatelessWidget {
  final VoidCallback onTap;

  const _TulisUlasanButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.pine800,
      borderRadius: BorderRadius.circular(9999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000), // 0px 1px 2px rgba(0,0,0,0.05)
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_rounded, size: 16, color: AppColors.textOnPrimary),
              SizedBox(width: 6),
              Text(
                'Tulis Ulasan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 16 / 12,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kartu testimoni: avatar inisial + nama + meta + bintang, body quote.
class _TestimonialCard extends StatelessWidget {
  final Ulasan ulasan;
  final String? tipeWisatawan;
  final bool avatarPeach;

  const _TestimonialCard({
    required this.ulasan,
    this.tipeWisatawan,
    this.avatarPeach = false,
  });

  String get _initials {
    final parts = ulasan.nama.trim().split(RegExp(r'\s+'));
    final a = parts.isNotEmpty ? parts.first : '';
    final b = parts.length > 1 ? parts.last : '';
    final initials = [a.isNotEmpty ? a[0] : '', b.isNotEmpty ? b[0] : ''];
    return initials.join().toUpperCase();
  }

  String get _meta {
    final t = DateTime.tryParse(ulasan.createdAt);
    if (t == null) return ulasan.createdAt;
    const bulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    final label = '${bulan[t.month - 1]} ${t.year}';
    return tipeWisatawan == null ? label : '$tipeWisatawan \u2022 $label';
  }

  @override
  Widget build(BuildContext context) {
    final rating = ulasan.rating.clamp(1, 5);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.detailBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F1D3A30), // 0px 8px 30px -4px rgba(29,58,48,0.06)
            offset: Offset(0, 8),
            blurRadius: 30,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar inisial (mint / peach selang-seling sesuai Figma)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: avatarPeach
                      ? AppColors.peachSoft.withValues(alpha: 0.7)
                      : AppColors.mintSoftStrong,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  _initials,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 20 / 14,
                    color: AppColors.pine800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ulasan.nama,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 15 / 12,
                        color: AppColors.pine900,
                      ),
                    ),
                    Text(
                      _meta,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: 16.5 / 11,
                        color: AppColors.detailBody,
                      ),
                    ),
                  ],
                ),
              ),
              // Bintang rating (12.5px, gap 2 sesuai Figma)
              Row(
                children: [
                  for (var i = 1; i <= 5; i++) ...[
                    if (i > 1) const SizedBox(width: 2),
                    Icon(
                      Icons.star_rounded,
                      size: 12.5,
                      color: i <= rating
                          ? AppColors.starGold
                          : AppColors.detailBorder,
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '"${ulasan.komentar}"',
            style: const TextStyle(
              fontSize: 12,
              height: 19.5 / 12,
              color: AppColors.detailBody,
            ),
          ),
        ],
      ),
    );
  }
}
