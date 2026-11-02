import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../event_data.dart';

/// Kartu baris untuk,total section "Agenda mendatang".
class EventAgendaCard extends StatelessWidget {
  final EventItem item;
  final VoidCallback onTap;

  const EventAgendaCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
                            _CategoryChip(kategori: item.kategori),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.nama,
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
                            const Icon(Icons.calendar_month_rounded,
                                size: 10, color: AppColors.pine700),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                item.rentangTanggal,
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
                            const Icon(Icons.star_rounded,
                                size: 9, color: AppColors.warning),
                            const SizedBox(width: 2),
                            Text(
                              '${item.rating.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.pine900,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${item.ratingCount}+)',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBody,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.deskripsi,
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
              const Divider(
                height: 18,
                color: AppColors.divider,
              ),
              Row(
                children: [
                  Text(
                    item.harga == null ? 'Gratis' : _hargaLabel(item.harga!),
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Info Detail ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          Icon(Icons.arrow_forward_rounded,
                              size: 9, color: AppColors.pine900),
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

  static String _hargaLabel(int harga) {
    final s = harga.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final sisa = s.length - i;
      buf.write(s[i]);
      if (sisa > 1 && sisa % 3 == 1) buf.write('.');
    }
    return 'Mulai Rp$buf';
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