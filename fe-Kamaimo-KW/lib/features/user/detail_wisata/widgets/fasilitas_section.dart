import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Section "Fasilitas Desa Wisata" (KENYAMANAN BERKELANJUTAN) sesuai
/// frame 4714:452: grid 2 kolom kartu premium (gambar/ikon + badge + harga).
///
/// CATATAN: Data fasilitas belum punya endpoint backend - konten di bawah
/// adalah placeholder demo sesuai Figma. Ganti ke data dinamis saat admin
/// CRUD fasilitas tersedia (M3).
class FasilitasSection extends StatelessWidget {
  final List<FasilitasItem> items;

  const FasilitasSection({super.key, this.items = _demoItems});

  static const _demoItems = <FasilitasItem>[
    FasilitasItem(
      image: 'assets/images/detail_wisata/fasilitas_kano.png',
      badge: 'Terpopuler',
      badgeStyle: BadgeStyle.dark,
      icon: Icons.kayaking_rounded,
      iconBadgeBg: AppColors.mintSoft,
      iconColor: AppColors.pine800,
      title: 'Sewa Kano Transparan',
      deskripsi: 'Kano bening akrilik untuk foto estetik di atas danau.',
      footerLabel: 'Mulai',
      harga: 'Rp 30.000',
      satuan: '/jam',
      hargaColor: AppColors.pine800,
    ),
    FasilitasItem(
      image: 'assets/images/detail_wisata/fasilitas_homestay.png',
      badge: '8 Kamar',
      badgeStyle: BadgeStyle.cream,
      icon: Icons.bed_rounded,
      iconBadgeBg: AppColors.peachSoft,
      iconColor: AppColors.earth,
      title: 'Homestay Kayu Pesisir',
      deskripsi: 'Pondok kayu estetik ramah lingkungan berdampingan.',
      footerLabel: 'Mulai',
      harga: 'Rp 175.000',
      satuan: '/malam',
      hargaColor: AppColors.earth,
    ),
    FasilitasItem(
      icon: Icons.hiking_rounded,
      iconBadgeBg: AppColors.mintSoft,
      iconColor: AppColors.pine800,
      title: 'Pemandu Pokdarwis',
      deskripsi:
          'Pemandu lokal berlisensi penunjuk spot foto & cerita mitos Sea-Sea.',
      footerLabel: 'Tersedia Harian',
    ),
    FasilitasItem(
      icon: Icons.outdoor_grill_rounded,
      iconBadgeBg: AppColors.peachSoft,
      iconColor: AppColors.earth,
      title: 'Kuliner Ikan Bakar',
      deskripsi:
          'Ikan kuah asam rica, ubi Banggai rebus empuk & kelapa muda segar.',
      footerLabel: 'Harga',
      harga: 'Rp 20.000+',
      satuan: '',
      hargaColor: AppColors.pine900,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        const Text(
          'KENYAMANAN BERKELANJUTAN',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            letterSpacing: 0.6, // Figma 0.05em @12px
            color: AppColors.pine500,
          ),
        ),
        const SizedBox(height: 2.5),
        const Text(
          'Fasilitas Desa Wisata',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 28 / 20,
            letterSpacing: -0.5,
            color: AppColors.pine900,
          ),
        ),
        const SizedBox(height: 16),

        // Grid 2 kolom (gap 14)
        ..._gridRows(items),
      ],
    );
  }

  List<Widget> _gridRows(List<FasilitasItem> items) {
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += 2) {
      final second = i + 1 < items.length ? items[i + 1] : null;
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _FasilitasCard(item: items[i])),
          const SizedBox(width: 14),
          if (second != null)
            Expanded(child: _FasilitasCard(item: second))
          else
            const Expanded(child: SizedBox()),
        ],
      ));
      if (i + 2 < items.length) rows.add(const SizedBox(height: 14));
    }
    return rows;
  }
}

// ─── Model + Kartu ─────────────────────────────────────────────────────────

/// Gaya badge overlay kartu fasilitas.
enum BadgeStyle { dark, cream }

class FasilitasItem {
  /// Foto media (path asset) — dipakai kartu gambar; null = kartu ikon.
  final String? image;
  final String? badge; // badge overlay di atas gambar
  final BadgeStyle badgeStyle;
  final IconData icon;
  final Color iconBadgeBg;
  final Color iconColor;
  final String title;
  final String deskripsi;
  final String? footerLabel;
  final String? harga;
  final String satuan;
  final Color hargaColor;

  const FasilitasItem({
    this.image,
    this.badge,
    this.badgeStyle = BadgeStyle.dark,
    required this.icon,
    required this.iconBadgeBg,
    required this.iconColor,
    required this.title,
    required this.deskripsi,
    this.footerLabel,
    this.harga,
    this.satuan = '',
    this.hargaColor = AppColors.pine800,
  });
}

class _FasilitasCard extends StatelessWidget {
  final FasilitasItem item;

  const _FasilitasCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final hasFooter =
        item.footerLabel != null || (item.harga?.isNotEmpty ?? false);

    return Container(
      padding: const EdgeInsets.all(12),
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
          // Media: foto Figma (kartu 1-2) / blok ikon pendek (kartu 3-4)
          // + badge overlay
          Stack(
            children: [
              Container(
                height: item.image != null ? 112 : 56,
                decoration: BoxDecoration(
                  color: item.image != null
                      ? AppColors.surfaceElevated
                      : item.iconBadgeBg.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: item.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item.image!,
                          width: double.infinity,
                          height: 112,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Icon(
                            item.icon,
                            size: 18,
                            color: item.iconColor,
                          ),
                        ),
                      )
                    : Icon(item.icon, size: 18, color: item.iconColor),
              ),
              if (item.badge != null) _badgeOverlay(item),
            ],
          ),
          const SizedBox(height: 6),

          // Judul
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 15 / 12,
              color: AppColors.pine900,
            ),
          ),
          const SizedBox(height: 4),

          // Deskripsi
          Text(
            item.deskripsi,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              height: 16.5 / 11,
              color: AppColors.detailBody,
            ),
          ),

          // Footer: label ... harga
          if (hasFooter) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.detailBorder),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.footerLabel ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 15 / 10,
                        color: AppColors.detailBody,
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            item.harga ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              height: 16 / 12,
                              color: item.hargaColor,
                            ),
                          ),
                          if (item.satuan.isNotEmpty)
                            Text(
                              item.satuan,
                              style: const TextStyle(
                                fontSize: 10,
                                height: 16 / 10,
                                color: AppColors.detailBody,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Positioned _badgeOverlay(FasilitasItem item) {
    final dark = item.badgeStyle == BadgeStyle.dark;
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: dark
              ? AppColors.pine900.withValues(alpha: 0.85)
              : AppColors.creamCard,
          borderRadius: BorderRadius.circular(9999),
          border: dark ? null : Border.all(color: AppColors.detailBorder),
        ),
        child: Text(
          item.badge!,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            height: 15 / 10,
            color: dark ? AppColors.textOnPrimary : AppColors.pine900,
          ),
        ),
      ),
    );
  }
}
