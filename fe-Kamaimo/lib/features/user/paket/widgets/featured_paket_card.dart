import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kamaimo_image.dart';
import '../paket_data.dart';

/// Kartu paket besar utk carousel: foto + overlay (durasi, rating, tag, judul),
/// lalu blok info: harga, deskripsi, fasilitas 2×2, CTA WhatsApp.
class FeaturedPaketCard extends StatelessWidget {
  final PaketItem item;
  final VoidCallback onWhatsApp;
  final VoidCallback onRate;

  const FeaturedPaketCard({
    super.key,
    required this.item,
    required this.onWhatsApp,
    required this.onRate,
  });

  String _whatsappLabel(bool isEnglish) {
    return isEnglish
        ? 'Contact Agent on WhatsApp'
        : 'Hubungi Agen via WhatsApp';
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider>().isEnglish;
    final facilities = item.displayFacilities(isEnglish);
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
                  KamaimoImage(path: item.foto, fit: BoxFit.cover),
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
                            item.displayDuration(isEnglish),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
                    child: Semantics(
                      key: Key('paket-rating-trigger-${item.ratingKey}'),
                      button: true,
                      label: isEnglish
                          ? 'Rating ${item.rating}, ${item.ratingCount} reviews'
                          : 'Rating ${item.rating}, ${item.ratingCount} ulasan',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onRate,
                          borderRadius: BorderRadius.circular(9999),
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.pine900,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                                Text(
                                  ' (${item.ratingCount})',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.pine900.withValues(
                                      alpha: 0.6,
                                    ),
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 14,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: AppColors.emerald100,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            item.displayTag(isEnglish),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.emerald600,
                              letterSpacing: 0.2,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          item.displayName(isEnglish),
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
                        Text(
                          isEnglish ? 'STARTING AT' : 'MULAI DARI',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textTertiary,
                            letterSpacing: 0.4,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.emerald100,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            item.displayType(isEnglish),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.emerald600,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
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
                          isEnglish ? ' /person' : ' ${item.satuan}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.displayDescription(isEnglish),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBody,
                        height: 1.35,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    if (facilities.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        isEnglish ? 'INCLUDED:' : 'FASILITAS TERMASUK:',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine700,
                          letterSpacing: 0.2,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: facilities.length <= 2 ? 39 : 84,
                        child: LayoutBuilder(
                          builder: (context, constraints) => Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              for (final facility in facilities.take(4))
                                SizedBox(
                                  width: (constraints.maxWidth - 8) / 2,
                                  height: 39,
                                  child: _FasilitasChip(f: facility),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Semantics(
                      button: true,
                      label: _whatsappLabel(isEnglish),
                      child: InkWell(
                        onTap: onWhatsApp,
                        borderRadius: BorderRadius.circular(9999),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.pine900,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.chat_bubble_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 9),
                              Flexible(
                                child: Text(
                                  _whatsappLabel(isEnglish),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ),
                            ],
                          ),
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
      height: 44,
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
