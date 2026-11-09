import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../eksplor_data.dart';

/// Header + filter Tab Eksplor: eyebrow "SULTENG TOURISM", judul
/// "Katalog Wisata & Kuliner", chip dinas, segmented 2 katalog,
/// search (hint berubah per tab), dan chip wilayah.
/// Sesuai 2 PNG export desain dari user (2026-10-29).
class EksplorHeader extends StatelessWidget {
  final int tabIndex; // 0 = Tempat Menginap | 1 = Kuliner Khas
  final TextEditingController searchController;
  final int wilayahIndex;
  final List<String> wilayahList;
  final ValueChanged<int> onTab;
  final ValueChanged<String> onQuery;
  final ValueChanged<int> onWilayah;

  const EksplorHeader({
    super.key,
    required this.tabIndex,
    required this.searchController,
    required this.wilayahIndex,
    this.wilayahList = EksplorSeed.wilayah,
    required this.onTab,
    required this.onQuery,
    required this.onWilayah,
  });

  static const _hints = [
    'Cari nama hotel, homestay, resort...',
    'Cari Kaledo, Onyop, Lalampa, Uta Dada...',
  ];

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final hints = isEn
        ? [
            'Search hotel, homestay, resort names...',
            'Search Kaledo, Onyop, Lalampa, Uta Dada...',
          ]
        : _hints;

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow + judul
          const Text(
            'SULTENG TOURISM',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              height: 1.4,
              letterSpacing: 0.5,
              color: AppColors.pine500,
              fontStyle: FontStyle.normal,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isEn ? 'Tourism & Culinary Catalog' : 'Katalog Wisata & Kuliner',
            key: const Key('eksplorJudul'),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.25,
              letterSpacing: -0.5,
              color: AppColors.pine900,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 10),

          // Chip dinas
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.emerald100,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Center(
              child: Text(
                isEn
                    ? 'TOURISM DEPARTMENT CURATED CATALOG'
                    : 'KATALOG PILIHAN DINAS PARIWISATA',
                key: const Key('eksplorChipDinas'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  color: AppColors.emerald600,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Segmented 2 katalog (kontainer mint berabu, aktif pine gelap)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              children: [
                _SegmentTab(
                  key: const Key('eksplorTabMenginap'),
                  label: isEn ? 'Places to Stay' : 'Tempat Menginap',
                  selected: tabIndex == 0,
                  onTap: () => onTab(0),
                ),
                _SegmentTab(
                  key: const Key('eksplorTabKuliner'),
                  label: isEn ? 'Local Culinary' : 'Kuliner Khas',
                  selected: tabIndex == 1,
                  onTap: () => onTab(1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Search (hint mengikuti tab aktif)
          Container(
            height: 44,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9999),
              boxShadow: AppColors.shadowCard,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    key: const Key('eksplorSearch'),
                    controller: searchController,
                    onChanged: onQuery,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pine900,
                      fontFamily: 'PlusJakartaSans',
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      filled: false,
                      fillColor: Colors.transparent,
                      hintText: hints[tabIndex],
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textTertiary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Chip wilayah (horizontal scroll)
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: wilayahList.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final raw = wilayahList[i];
                final label = (isEn && raw == 'Semua Wilayah')
                    ? 'All Regions'
                    : raw;
                return _WilayahChip(
                  label: label,
                  selected: i == wilayahIndex,
                  onTap: () => onWilayah(i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentTab({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.pine800 : Colors.transparent,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.textOnPrimary : AppColors.textBody,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ),
      ),
    );
  }
}

class _WilayahChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _WilayahChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.pine800 : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          border: selected
              ? Border.all(color: AppColors.pine800)
              : Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.textOnPrimary : AppColors.textBody,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ),
    );
  }
}
