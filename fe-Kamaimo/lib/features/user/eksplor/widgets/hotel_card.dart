import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kamaimo_image.dart';
import '../eksplor_data.dart';
import 'kontak_row.dart';

/// Kartu akomodasi Tab Eksplor (desain "Tempat Menginap"):
/// foto + rating/label bintang + pill lokasi/highlight → judul →
/// chips fasilitas → MULAI TARIF KAMAR → Telepon/Maps/Website.
class HotelCard extends StatelessWidget {
  final HotelItem item;
  final VoidCallback? onKontak;
  final void Function(HotelItem)? onTelepon;
  final void Function(HotelItem)? onMaps;
  final void Function(HotelItem)? onWebsite;

  const HotelCard({
    super.key,
    required this.item,
    this.onKontak,
    this.onTelepon,
    this.onMaps,
    this.onWebsite,
  });

  String _translateTag(String t, bool isEn) {
    if (!isEn) return t;
    switch (t) {
      case 'Bintang 4 Resor':
        return '4-Star Resort';
      case 'Resor Pantai':
        return 'Beach Resort';
      case 'Guesthouse Pesisir':
        return 'Coastal Guesthouse';
      case 'Akomodasi Nyaman':
        return 'Comfortable Stay';
      default:
        return t;
    }
  }

  String _translateHighlight(String h, bool isEn) {
    if (!isEn) return h;
    switch (h) {
      case 'Snorkeling Langsung':
        return 'Direct Snorkeling';
      case 'Pilihan Terbaik':
        return 'Best Choice';
      default:
        return h;
    }
  }

  String _translateChipLabel(String l, bool isEn) {
    if (!isEn) return l;
    switch (l) {
      case 'Kolam View Laut':
        return 'Ocean View Pool';
      case '2 King Bed Opsi':
        return '2 King Bed Options';
      case 'Panorama Laut':
        return 'Ocean Panorama';
      case 'Panorama Alam':
        return 'Nature Panorama';
      case 'Buffet Sarapan':
        return 'Breakfast Buffet';
      case 'Napas Pantai':
        return 'Beach Breeze';
      case 'Pasir Putih Privat':
        return 'Private White Sand';
      case 'Snorkeling Gratis':
        return 'Free Snorkeling';
      default:
        return l
            .replaceAll('Kamar', 'Rooms')
            .replaceAll('Tempat Tidur', 'Beds');
    }
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
                    item.nama,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                      letterSpacing: -0.3,
                      color: AppColors.pine900,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Chips fasilitas
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final (icon, label) in item.chips)
                        _FasilitasChip(
                          icon: icon,
                          label: _translateChipLabel(label, isEn),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.detailBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEn ? 'STARTING ROOM RATE' : 'MULAI TARIF KAMAR',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              isEn ? 'Starting from' : 'Mulai dari',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      EksplorSeed.formatRupiah(item.harga),
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.pine700,
                                        letterSpacing: -0.3,
                                        fontFamily: 'PlusJakartaSans',
                                      ),
                                    ),
                                    Text(
                                      isEn ? ' /night' : ' /mlm',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
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
                        if (item.hargaCoret != null)
                          Text(
                            EksplorSeed.formatRupiah(item.hargaCoret!),
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textTertiary,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        const SizedBox(height: 12),
                        KontakRow(
                          onTap: onKontak,
                          onTelepon:
                              onTelepon != null && item.telepon.isNotEmpty
                              ? () => onTelepon!(item)
                              : null,
                          onMaps: onMaps != null ? () => onMaps!(item) : null,
                          onWebsite:
                              onWebsite != null && item.website.isNotEmpty
                              ? () => onWebsite!(item)
                              : null,
                          itemName: item.nama,
                        ),
                      ],
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
              fallbackAsset: 'assets/images/eksplor/hotel1.jpg',
            ),
            const DecoratedBox(
              decoration: BoxDecoration(gradient: AppColors.cardImageOverlay),
            ),
            // Rating (kiri atas)
            Positioned(
              top: 12,
              left: 12,
              child: _Pill(
                bg: AppColors.glassBgStrong,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 13,
                      color: AppColors.starGold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isEn
                          ? '${item.rating} (${item.ratingCount} reviews)'
                          : '${item.rating} (${item.ratingCount} ulasan)',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.pine900,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Kategori (kanan atas)
            Positioned(
              top: 12,
              right: 12,
              child: _Pill(
                bg: AppColors.pine800,
                child: Text(
                  _translateTag(item.tag, isEn),
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnPrimary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
            // Lokasi (kiri bawah) + highlight (kanan bawah)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Flexible(
                    child: _Pill(
                      bg: const Color(0xCC1D3A30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 12,
                            color: AppColors.textOnPrimary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              item.lokasi,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textOnPrimary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  _Pill(
                    bg: const Color(0xCC1D3A30),
                    child: Text(
                      _translateHighlight(item.highlight, isEn),
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textOnPrimary,
                        fontFamily: 'PlusJakartaSans',
                      ),
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

/// Pill overlay foto (mint glass / pine gelap).
class _Pill extends StatelessWidget {
  final Color bg;
  final Widget child;

  const _Pill({required this.bg, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FasilitasChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FasilitasChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textBody),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textBody,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
