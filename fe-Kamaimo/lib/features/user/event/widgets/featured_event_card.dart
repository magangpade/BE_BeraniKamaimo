import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kamaimo_image.dart';
import '../event_data.dart';
import '../event_locale.dart';

/// Kartu featured "Event pilihan bulan ini".
class FeaturedEventCard extends StatelessWidget {
  final EventItem item;
  final VoidCallback onTap;
  final DateTime now;

  const FeaturedEventCard({
    required this.item,
    required this.onTap,
    required this.now,
  });

  static const _bulanAbbr = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MEI',
    'JUN',
    'JUL',
    'AGU',
    'SEP',
    'OKT',
    'NOV',
    'DES',
  ];

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final hari = EventSeed.hariMenuai(item.start, now);
    final chipCountdown = hari <= 0
        ? (isEnglish ? 'Today' : 'Hari ini')
        : (isEnglish ? 'In $hari days' : '$hari hari lagi');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppColors.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: SizedBox(
              height: 175,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  KamaimoImage(path: item.foto, fit: BoxFit.cover),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        chipCountdown,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: AppColors.earth,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Container(
                      width: 60,
                      height: 64,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${item.start.day}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          Text(
                            '${isEnglish ? const ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'][item.start.month - 1] : _bulanAbbr[item.start.month - 1]} ${item.start.year}',
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _CategoryChip(
                      kategori: item.kategori,
                      isEnglish: isEnglish,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        EventLocale.cardLocation(item, isEnglish),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pine700,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  EventLocale.name(item, isEnglish),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  EventLocale.description(item, isEnglish),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                    height: 1.4,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 11,
                      color: AppColors.pine700,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        EventLocale.dateRange(item, isEnglish),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    key: const Key('featured-event-detail-button'),
                    onTap: onTap,
                    child: Container(
                      width: isEnglish ? 110 : 95,
                      height: 27,
                      decoration: BoxDecoration(
                        color: AppColors.pine700,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isEnglish ? 'View Details ' : 'Info Detail ',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 10,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Semua kategori memakai warna label yang sama.
class _CategoryChip extends StatelessWidget {
  final String kategori;
  final bool isEnglish;

  const _CategoryChip({required this.kategori, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: AppColors.emerald50,
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Text(
        EventLocale.category(kategori, isEnglish),
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: AppColors.pine700,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }
}
