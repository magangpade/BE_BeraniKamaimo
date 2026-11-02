import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../paket_data.dart';

/// Kartu paket besar utk carousel: foto + overlay (durasi, rating, tag, judul),
/// lalu blok info: harga, deskripsi, fasilitas 2×2, CTA WhatsApp.
class FeaturedPaketCard extends StatelessWidget {
  final PaketItem item;
  final VoidCallback onWhatsApp;

  const FeaturedPaketCard({required this.item, required this.onWhatsApp});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.shadowCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            // ── Foto + overlay ──
            SizedBox(
              height: 216,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.foto, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppColors.cardImageOverlay,
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 14,
                    child: _GlassPill(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 12,
                            color: AppColors.pine700,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            item.durasi,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 14,
                    top: 14,
                    child: _GlassPill(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item.rating}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          Text(
                            ' (${item.ratingCount})',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pine900.withValues(alpha: 0.6),
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 60,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 22,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.emerald100,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            item.tag,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: AppColors.emerald600,
                              letterSpacing: 0.3,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          item.nama,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.15,
                            letterSpacing: -0.4,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ── Info area ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'MULAI DARI',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textTertiary,
                            letterSpacing: 0.4,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.emerald100,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            item.tipe,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.emerald600,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          PaketSeed.formatRupiah(item.harga),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.pine900,
                            letterSpacing: -0.3,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        Text(
                          ' ${item.satuan}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppColors.divider),
                    const SizedBox(height: 12),
                    Text(
                      item.deskripsi,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBody,
                        height: 1.45,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      'FASILITAS TERMASUK:',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: AppColors.pine700,
                        letterSpacing: 0.4,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 96,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _FasilitasChip(f: item.fasilitas[0]),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _FasilitasChip(f: item.fasilitas[1]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _FasilitasChip(f: item.fasilitas[2]),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _FasilitasChip(f: item.fasilitas[3]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // CTA WhatsApp — ponytail: url_launcher masuk di M2-1.10
                    GestureDetector(
                      onTap: onWhatsApp,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.pine900,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 9),
                            Text(
                              'Hubungi Agen via WhatsApp',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill kaca putih utk info di atas foto.
class _GlassPill extends StatelessWidget {
  final Widget child;

  const _GlassPill({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xF2FFFFFF), // 95% putih
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
      child: child,
    );
  }
}

/// Chip fasilitas 2×2: ikon + label, tinggi tetap.
class _FasilitasChip extends StatelessWidget {
  final (IconData, String) f;

  const _FasilitasChip({required this.f});

  @override
  Widget build(BuildContext context) {
    final (icon, label) = f;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.mapBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.pine700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: AppColors.pine900,
                height: 1.2,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
