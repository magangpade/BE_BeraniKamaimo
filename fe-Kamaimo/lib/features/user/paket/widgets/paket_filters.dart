import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../paket_data.dart';

/// Chips kategori paket: Semua (aktif gelap) / Bahari / Budaya / Trekking.
class PaketFilters extends StatelessWidget {
  final int kategoriIndex;
  final ValueChanged<int> onKategori;

  const PaketFilters({required this.kategoriIndex, required this.onKategori});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: PaketSeed.kategori.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (ctx, i) {
          final active = i == kategoriIndex;
          return GestureDetector(
            onTap: () => onKategori(i),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: active ? AppColors.pine700 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: active ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                PaketSeed.kategori[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : AppColors.pine900,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
