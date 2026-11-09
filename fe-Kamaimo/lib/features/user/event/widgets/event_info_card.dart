import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../event_locale.dart';

/// Kartu info floating di atas hero, menampilkan badge, rating, judul, lokasi.
class EventInfoCard extends StatelessWidget {
  final String badge;
  final String kategori;
  final double? rating;
  final int ratingCount;
  final String judul;
  final String lokasi;
  final VoidCallback? onRatingTap;

  const EventInfoCard({
    required this.badge,
    required this.kategori,
    required this.rating,
    required this.ratingCount,
    required this.judul,
    required this.lokasi,
    this.onRatingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
        boxShadow: AppColors.shadowFloating,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label KEN, kategori, dan rating.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (badge.trim().isNotEmpty) ...[
                Flexible(
                  child: _BadgeChip(
                    label: badge,
                    hasOutline: true,
                    color: AppColors.goldChipBorder,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              _KategoriChip(EventLocale.category(kategori, isEnglish)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              InkWell(
                key: const Key('event-rating-trigger'),
                onTap: onRatingTap,
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.emerald50,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: AppColors.emerald100),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating?.toStringAsFixed(1) ??
                            (isEnglish ? 'New' : 'Baru'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ratingCount >= 1000
                            ? '(${(ratingCount / 1000).toStringAsFixed(1)}k+)'
                            : '($ratingCount)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            judul == 'Pasar Kreatif Sulteng'
                ? 'Pasar Kreatif Sulawesi Tengah'
                : judul,
            style: const TextStyle(
              fontSize: 24,
              height: 1.18,
              fontWeight: FontWeight.w800,
              color: AppColors.pine900,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.place_rounded,
                size: 14,
                color: AppColors.pine700,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  lokasi,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Badge kategori UMKM/BUDAYA/Bahari/Ekowisata.
class _KategoriChip extends StatelessWidget {
  final String kategori;

  const _KategoriChip(this.kategori);

  @override
  Widget build(BuildContext context) {
    final label = kategori == 'UMKM' || kategori == 'MSME' || kategori.isEmpty
        ? kategori
        : '${kategori[0]}${kategori.substring(1).toLowerCase()}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.emerald50,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: AppColors.pine700,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }
}

/// Badge besar (contoh: Karisma Event Nusantara).
class _BadgeChip extends StatelessWidget {
  final String label;
  final bool hasOutline;
  final Color color;

  const _BadgeChip({
    required this.label,
    required this.hasOutline,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: hasOutline ? const Color(0xFFFAF3EC) : color,
        borderRadius: BorderRadius.circular(9999),
        border: hasOutline ? Border.all(color: color) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: hasOutline ? AppColors.orangeBadge : AppColors.orangeBadge,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }
}
