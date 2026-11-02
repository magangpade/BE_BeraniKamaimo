import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Kartu info floating di atas hero, menampilkan badge, rating, judul, lokasi.
class EventInfoCard extends StatelessWidget {
  final String badge;
  final String kategori;
  final double rating;
  final int ratingCount;
  final String judul;
  final String lokasi;

  const EventInfoCard({
    required this.badge,
    required this.kategori,
    required this.rating,
    required this.ratingCount,
    required this.judul,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: -40,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppColors.shadowCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge baris atas.
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _BadgeChip(label: badge, hasOutline: true, color: AppColors.goldChipBorder),
                _KategoriChip(kategori),
              ],
            ),
            const SizedBox(height: 8),
            // Rating & judul besar.
            Row(
              children: [
                const Icon(Icons.star_rounded, size: 14, color: AppColors.warning),
                const SizedBox(width: 4),
                Text(
                  '$rating'.replaceAll('.', ','),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '($ratingCount+)'.replaceAll('.', ','),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              judul,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.place_rounded, size: 14, color: AppColors.pine700),
                const SizedBox(width: 4),
                Text(
                  lokasi,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.pine700,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ],
        ),
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
    final bold = kategori == 'UMKM';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bold ? AppColors.pine700 : AppColors.emerald100,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        kategori,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: bold ? Colors.white : AppColors.emerald600,
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
        color: hasOutline ? Colors.white : color,
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