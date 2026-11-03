import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../eksplor_data.dart';
import 'kontak_row.dart';

/// Kartu kuliner Tab Eksplor (desain "Kuliner Khas"):
/// foto + nama kuliner/nama RM di atas foto (+ tag) → deskripsi →
/// chips bahan → Telepon/Maps/Website.
class KulinerCard extends StatelessWidget {
  final KulinerItem item;
  final VoidCallback onKontak;

  const KulinerCard({super.key, required this.item, required this.onKontak});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _media(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.deskripsi,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    height: 1.55,
                    color: AppColors.textBody,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 12),
                // Chips bahan
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final (label, kind) in item.bahan)
                      _BahanChip(label: label, kind: kind),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.only(top: 14),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.detailBorder),
                    ),
                  ),
                  child: KontakRow(onTap: onKontak),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _media() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              item.foto,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const ColoredBox(
                color: AppColors.mapBackground,
                child: Center(
                  child: Icon(Icons.restaurant_rounded,
                      size: 44, color: AppColors.pine500),
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(gradient: AppColors.cardImageOverlay),
            ),
            // Tag (kiri atas)
            if (item.tag != null)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.goldChipBg,
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: AppColors.goldChipBorder),
                  ),
                  child: Text(
                    item.tag!,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.goldChipText,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
              ),
            // Nama kuliner + RM (kiri bawah, di atas gradient)
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      letterSpacing: -0.3,
                      color: AppColors.textOnPrimary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '🍲 ${item.warung}',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.starGold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BahanChip extends StatelessWidget {
  final String label;
  final ChipKind kind;

  const _BahanChip({required this.label, required this.kind});

  @override
  Widget build(BuildContext context) {
    const kinds = {
      ChipKind.mint: (
        backgroundColor: AppColors.emerald100,
        text: AppColors.emerald600,
      ),
      ChipKind.peach: (
        backgroundColor: Color(0xFFFDE7E5),
        text: Color(0xFFB3402F),
      ),
      ChipKind.cream: (
        backgroundColor: AppColors.goldChipBg,
        text: AppColors.goldChipText,
      ),
    };
    final colors = kinds[kind]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(9999),
        border: kind == ChipKind.cream
            ? Border.all(color: AppColors.goldChipBorder)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: colors.text,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    );
  }
}
