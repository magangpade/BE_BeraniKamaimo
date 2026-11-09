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
    final labels = [
      for (var i = 0; i < PaketSeed.kategori.length; i++)
        isEnglish ? const ['All', 'Marine', 'Culture', 'Trekking'][i] : PaketSeed.kategori[i],
    ];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final active = i == kategoriIndex;
          return GestureDetector(
            onTap: () => onKategori(i),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: active ? AppColors.pine700 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: active ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                labels[i],
                maxLines: 1,
                style: TextStyle(
                  fontSize: 12,
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
