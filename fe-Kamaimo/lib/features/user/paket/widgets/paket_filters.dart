import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../paket_data.dart';

/// Chips kategori paket: Semua (aktif gelap) / Bahari / Budaya / Trekking.
class PaketFilters extends StatelessWidget {
  final int kategoriIndex;
  final ValueChanged<int> onKategori;

  const PaketFilters({
    super.key,
    required this.kategoriIndex,
    required this.onKategori,
  });

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider>().isEnglish;
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: PaketSeed.kategori.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final active = i == kategoriIndex;
          return GestureDetector(
            onTap: () => onKategori(i),
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: active ? AppColors.pine700 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: active ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                isEnglish
                    ? const ['All', 'Marine', 'Culture', 'Trekking'][i]
                    : PaketSeed.kategori[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w600,
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
