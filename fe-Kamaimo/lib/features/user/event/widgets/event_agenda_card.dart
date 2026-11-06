import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../event_data.dart';
import '../event_locale.dart';

/// Kartu baris untuk,total section "Agenda mendatang".
class EventAgendaCard extends StatelessWidget {
  final EventItem item;
  final VoidCallback onTap;

  const EventAgendaCard({required this.item, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppColors.shadowCard,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 96,
                      height: 96,
                      child: Image.asset(item.foto, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _CategoryChip(
                              kategori: item.kategori,
                              isEnglish: isEnglish,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          EventLocale.name(item, isEnglish),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.pine900,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              size: 10,
                              color: AppColors.pine700,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                EventLocale.dateRange(item, isEnglish),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBody,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.place_rounded,
                              size: 10,
                              color: AppColors.pine700,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                EventLocale.cardLocation(item, isEnglish),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBody,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          EventLocale.description(item, isEnglish),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBody,
                            height: 1.4,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 18, color: AppColors.divider),
              Row(
                children: [
                  Text(
                    item.harga == null
                        ? (isEnglish ? 'Free' : 'Gratis')
                        : _hargaLabel(item.harga!, isEnglish),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: item.harga == null
                          ? AppColors.emerald600
                          : AppColors.pine700,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onTap,
                    child: Container(
                      height: 29,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isEnglish ? 'View Details ' : 'Info Detail ',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 9,
                            color: AppColors.pine900,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _hargaLabel(int harga, bool isEnglish) {
    final s = harga.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final sisa = s.length - i;
      buf.write(s[i]);
      if (sisa > 1 && sisa % 3 == 1) buf.write('.');
    }
    return isEnglish ? 'From Rp$buf' : 'Mulai Rp$buf';
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
