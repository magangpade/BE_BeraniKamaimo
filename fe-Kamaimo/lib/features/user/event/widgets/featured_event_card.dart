import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../event_data.dart';

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
    'JAN', 'FEB', 'MAR', 'APR', 'MEI', 'JUN',
    'JUL', 'AGU', 'SEP', 'OKT', 'NOV', 'DES',
  ];

  @override
  Widget build(BuildContext context) {
    final hari = EventSeed.hariMenuai(item.start, now);
    final chipCountdown = hari <= 0 ? 'Hari ini' : '$hari hari lagi';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.foto, fit: BoxFit.cover),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      height: 23,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        chipCountdown,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Container(
                      width: 56,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${item.start.day}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          Text(
                            '${_bulanAbbr[item.start.month - 1]} ${item.start.year}',
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
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _CategoryChip(kategori: item.kategori),
                    const SizedBox(width: 6),
                    Container(
                      height: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item.lokasi,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textBody,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.deskripsi,
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
                    const Icon(Icons.calendar_month_rounded,
                        size: 11, color: AppColors.pine700),
                    const SizedBox(width: 4),
                    Text(
                      item.rentangTanggal,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine900,
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
                          color: AppColors.pine700,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Info Detail ',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            Icon(Icons.arrow_forward_rounded,
                                size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip kategori: UMKM = pine penuh, lainnya = mint lembut.
class _CategoryChip extends StatelessWidget {
  final String kategori;

  const _CategoryChip({required this.kategori});

  @override
  Widget build(BuildContext context) {
    final dark = kategori == 'UMKM';
    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: dark ? AppColors.pine700 : AppColors.emerald100,
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.center,
      child: Text(
        kategori[0] + kategori.substring(1).toLowerCase(),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w800,
          color: dark ? Colors.white : AppColors.emerald600,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }
}
