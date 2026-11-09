import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kamaimo_image.dart';
import '../eksplor_data.dart';
import 'kontak_row.dart';

/// Kartu kuliner Tab Eksplor (desain "Kuliner Khas"):
/// foto + nama kuliner/nama RM di atas foto (+ tag) → deskripsi →
/// chips bahan → Telepon/Maps/Website.
class KulinerCard extends StatelessWidget {
  final KulinerItem item;
  final VoidCallback? onKontak;
  final void Function(KulinerItem)? onTelepon;
  final void Function(KulinerItem)? onMaps;
  final void Function(KulinerItem)? onWebsite;

  const KulinerCard({
    super.key,
    required this.item,
    this.onKontak,
    this.onTelepon,
    this.onMaps,
    this.onWebsite,
  });

  String _translateDeskripsi(String d, bool isEn) {
    if (!isEn) return d;
    if (d.startsWith('Kuah asam pedas segar')) {
      return 'Fresh spicy-sour broth made with young tamarind, coconut milk, fresh fish cuts, and green bird\'s eye chili — a legendary lunch along Palu Bay.';
    }
    if (d.startsWith('Sup sumsum tulang kaki sapi')) {
      return 'Tender beef leg bone marrow soup in a signature spicy-sour raw tamarind (uve kalopo) and green chili broth, sipped directly with a bamboo straw.';
    }
    if (d.startsWith('Beras ketan berisi ikan tuna')) {
      return 'Glutinous rice stuffed with spicy grilled tuna, wrapped in banana leaves and char-grilled — a legendary snack along the Toboli route to Poso.';
    }
    if (d.startsWith('Kuah kuning santan rempah')) {
      return 'Spiced yellow coconut milk broth with tender meat and traditional Kaili highland vegetables — a warm, sought-after homestyle dish during the rainy season.';
    }
    return d;
  }

  String _translateBahan(String b, bool isEn) {
    if (!isEn) return b;
    switch (b) {
      case '🌿 Asam Jawa Muda':
        return '🌿 Young Tamarind';
      case '🌿 Asam Jawa Segar':
        return '🌿 Fresh Tamarind';
      case '🌶️ Cabai Rawit Hijau':
        return '🌶️ Green Chili';
      case '🍠 Singkong Rebus':
        return '🍠 Boiled Cassava';
      case '🌾 Beras Ketan':
        return '🌾 Glutinous Rice';
      case '🐟 Tuna Bumbu':
        return '🐟 Spiced Tuna';
      case '🌿 Daun Pisang':
        return '🌿 Banana Leaf';
      case '🌶️ Kunyit Segar':
        return '🌶️ Fresh Turmeric';
      case '🥥 Santan Kental':
        return '🥥 Rich Coconut Milk';
      case '🍲 Daging Sapi':
        return '🍲 Beef';
      case '🌿 Rempah Tradisional':
        return '🌿 Traditional Spices';
      case '🌶️ Bumbu Khas Sulteng':
        return '🌶️ Central Sulawesi Spices';
      case '🍲 Resep Warisan':
        return '🍲 Heritage Recipe';
      default:
        return b;
    }
  }

  String _translateTag(String t, bool isEn) {
    if (!isEn) return t;
    if (t == 'Legendaris') return 'Legendary';
    if (t == 'Autentik') return 'Authentic';
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;

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
          _media(isEn),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _translateDeskripsi(item.deskripsi, isEn),
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
                      for (final (icon, label, kind) in item.bahan)
                        _BahanChip(
                          icon: icon,
                          label: _translateBahan(label, isEn),
                          kind: kind,
                        ),
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
                    child: KontakRow(
                      onTap: onKontak,
                      onTelepon: onTelepon != null ? () => onTelepon!(item) : null,
                      onMaps: onMaps != null ? () => onMaps!(item) : null,
                      onWebsite: onWebsite != null ? () => onWebsite!(item) : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _media(bool isEn) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            KamaimoImage(
              path: item.foto,
              fit: BoxFit.cover,
              fallbackAsset: 'assets/images/eksplor/kuliner1.jpg',
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
                    _translateTag(item.tag!, isEn),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        size: 12,
                        color: AppColors.starGold,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          item.warung,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.starGold,
                            fontFamily: 'PlusJakartaSans',
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
      ),
    );
  }
}

class _BahanChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final ChipKind kind;

  const _BahanChip({
    required this.icon,
    required this.label,
    required this.kind,
  });

  @override
  Widget build(BuildContext context) {
    const kinds = {
      ChipKind.mint: (
        backgroundColor: AppColors.emerald100,
        text: AppColors.emerald600,
      ),
      ChipKind.peach: (
        backgroundColor: AppColors.peachChipBg,
        text: AppColors.peachChipText,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colors.text),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: colors.text,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
