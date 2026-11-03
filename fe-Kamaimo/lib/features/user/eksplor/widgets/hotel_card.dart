import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../eksplor_data.dart';
import 'kontak_row.dart';

/// Kartu akomodasi Tab Eksplor (desain "Tempat Menginap"):
/// foto + rating/label bintang + pill lokasi/highlight → judul →
/// chips fasilitas → MULAI TARIF KAMAR → Telepon/Maps/Website.
class HotelCard extends StatelessWidget {
  final HotelItem item;
  final VoidCallback onKontak;

  const HotelCard({super.key, required this.item, required this.onKontak});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _media(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                    letterSpacing: -0.3,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 10),
                // Chips fasilitas
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final (icon, label) in item.chips)
                      _FasilitasChip(icon: icon, label: label),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.detailBorder),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MULAI TARIF KAMAR',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: AppColors.textTertiary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Text(
                            'Mulai dari',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    EksplorSeed.formatRupiah(item.harga),
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.pine700,
                                      letterSpacing: -0.3,
                                      fontFamily: 'PlusJakartaSans',
                                    ),
                                  ),
                                  const Text(
                                    ' /mlm',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textTertiary,
                                      fontFamily: 'PlusJakartaSans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (item.hargaCoret != null)
                        Text(
                          EksplorSeed.formatRupiah(item.hargaCoret!),
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      const SizedBox(height: 12),
                      KontakRow(onTap: onKontak),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _media() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              item.foto,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const ColoredBox(
                color: AppColors.mapBackground,
                child: Center(
                  child: Icon(Icons.hotel_rounded,
                      size: 44, color: AppColors.pine500),
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(gradient: AppColors.cardImageOverlay),
            ),
            // Rating (kiri atas)
            Positioned(
              top: 12,
              left: 12,
              child: _Pill(
                bg: AppColors.glassBgStrong,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 13, color: AppColors.starGold),
                    const SizedBox(width: 4),
                    Text(
                      '${item.rating} (${item.ratingCount} ulasan)',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.pine900,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Kategori (kanan atas)
            Positioned(
              top: 12,
              right: 12,
              child: _Pill(
                bg: AppColors.pine800,
                child: Text(
                  item.tag,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnPrimary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
            // Lokasi (kiri bawah) + highlight (kanan bawah)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Flexible(
                    child: _Pill(
                      bg: const Color(0xCC1D3A30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 12, color: AppColors.textOnPrimary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              item.lokasi,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textOnPrimary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  _Pill(
                    bg: const Color(0xCC1D3A30),
                    child: Text(
                      item.highlight,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textOnPrimary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill overlay foto (mint glass / pine gelap).
class _Pill extends StatelessWidget {
  final Color bg;
  final Widget child;

  const _Pill({required this.bg, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FasilitasChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FasilitasChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textBody),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textBody,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
