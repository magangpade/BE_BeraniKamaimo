import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';

/// Chips kategori + dropdown tanggal & wilayah.
class EventFilters extends StatelessWidget {
  final int kategoriIndex;
  final int tanggalIndex;
  final String? wilayah;
  final List<String> wilayahList;
  final ValueChanged<int> onKategori;
  final ValueChanged<int> onTanggal;
  final ValueChanged<String?> onWilayah;

  const EventFilters({
    required this.kategoriIndex,
    required this.tanggalIndex,
    required this.wilayah,
    required this.wilayahList,
    required this.onKategori,
    required this.onTanggal,
    required this.onWilayah,
  });

  static const labels = ['Semua', 'Budaya', 'Bahari', 'UMKM', 'EKOWISATA'];
  static const tanggalOptions = [
    'Semua tanggal',
    'Bulan ini',
    'Bulan depan',
    'Tahun ini',
  ];

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final visibleCategories = isEnglish
        ? const ['All', 'Culture', 'Marine', 'MSME', 'Ecotourism']
        : labels;
    final visibleDates = isEnglish
        ? const ['All dates', 'This month', 'Next month', 'This year']
        : tanggalOptions;
    final allRegions = isEnglish ? 'All regions' : 'Semua wilayah';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: visibleCategories.length,
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
                    visibleCategories[i],
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
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _DropdownPill(
                  icon: Icons.event_available_rounded,
                  label: visibleDates[tanggalIndex],
                  items: visibleDates,
                  selectedIndex: tanggalIndex,
                  onSelected: (v) => onTanggal(visibleDates.indexOf(v)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _DropdownPill(
                  icon: Icons.place_rounded,
                  label: wilayah ?? allRegions,
                  items: [allRegions, ...wilayahList],
                  onSelected: (v) => onWilayah(v == allRegions ? null : v),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DropdownPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<String> items;
  final int? selectedIndex;
  final ValueChanged<String> onSelected;

  const _DropdownPill({
    required this.icon,
    required this.label,
    required this.items,
    this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      onSelected: onSelected,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      itemBuilder: (ctx) => [
        for (final item in items)
          PopupMenuItem(
            value: item,
            height: 44,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: item == label ? AppColors.pine700 : AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
      ],
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 13, color: AppColors.pine700),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.pine900,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
