import 'package:flutter/material.dart';

/// Palet warna Berani Kamaimo — Pine aesthetic dari Figma design.
/// Referensi: node 4273:55 "Beranda - Berani Kamaimo (Aesthetic & Peta Interaktif)".
class AppColors {
  AppColors._();

  // ── Primary Pine (match Figma node 4273:55) ──
  static const Color pine900 = Color(0xFF1D3A30);    // heading utama
  static const Color pine800 = Color(0xFF15442D);    // navbar active, lang pill active
  static const Color pine700 = Color(0xFF2E5C43);    // tombol primer, pill active, harga
  static const Color pine600 = Color(0xFF35644A);    // logo background
  static const Color pine500 = Color(0xFF467A5C);    // label eyebrow, lokasi, link
  static const Color pine400 = Color(0xFF6B987B);    // secondary text

  // ── Accent Emerald ──
  static const Color emerald500 = Color(0xFF10B981); // CTA, success dot
  static const Color emerald600 = Color(0xFF065F46); // text pada badge hijau
  static const Color emerald100 = Color(0xFFD1FAE5); // badge background
  static const Color emerald50  = Color(0xFFECFDF5); // light badge bg

  // ── Surface & Background (match Figma) ──
  static const Color surface     = Color(0xFFFFFFFF);
  static const Color background  = Color(0xFFF8FAF4); // base halaman (node bg)
  static const Color surfaceElevated = Color(0xFFF2F4EE); // card gradient middle
  static const Color surfaceVariant = Color(0xFFEDEFE9); // event Detail button
  static const Color surfaceVariantSoft = Color(0xFFE7E9E3); // carousel Info Detail button
  static const Color mapBackground = Color(0xFFEAF2EB); // peta card bg

  // ── Text (match Figma node) ──
  static const Color textPrimary   = Color(0xFF1D3A30);  // heading (pine900)
  static const Color textBody      = Color(0xFF414943);  // body/desc
  static const Color textSecondary = Color(0xFF616E66);  // secondary
  static const Color textTertiary  = Color(0xFF717972);  // placeholder, caption, copyright
  static const Color textMuted     = Color(0xFF505953);  // nav inactive
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Border & Divider ──
  static const Color border       = Color(0xFFE2E8E0);  // card/cluster border
  static const Color borderLight  = Color(0x80E2E8E0);  // 50% opacity
  static const Color divider      = Color(0x80E2E8E0);  // divider dlm card carousel

  // ── Semantic / Marker ──
  static const Color error   = Color(0xFFE53935);
  static const Color warning = Color(0xFFF59E0B); // star, marker budaya, evebt icon
  static const Color info    = Color(0xFF3B82F6); // blue map marker
  static const Color success = Color(0xFF10B981);

  // ── Gold / Countdown chip ──
  static const Color goldChipBg     = Color(0xFFFFFBEB);
  static const Color goldChipBorder = Color(0x80FDE68A); // 50% #FDE68A
  static const Color goldChipText   = Color(0xFF92400E);
  static const Color orangeBadge    = Color(0xFFD97706); // badge THE SECRET PARADISE

  // ── Glass / Overlay ──
  static const Color glassBg       = Color(0xCCFFFFFF);    // 80% white
  static const Color glassBgStrong = Color(0xF2FFFFFF);    // 95% white
  static const Color glassBorder   = Color(0x80E5EAE2);

  // ── Shadows (match Figma spec) ──
  static const List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x0A1A3A2A), // 4% pine
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowFloating = [
    BoxShadow(
      color: Color(0x1F1A3A2A), // 12% pine900 - match Figma 0px 16px 36px -6px rgba(26, 58, 42, 0.12)
      blurRadius: 36,
      offset: Offset(0, 16),
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x0A1A3A2A), // 4% pine900
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  // ── Gradients ──
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFECFDF5), Color(0xFFF2F4EE), surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient cardImageOverlay = LinearGradient(
    colors: [Color(0x00000000), Color(0x8C000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Hero overlay gradient (match Figma: rgba(18, 40, 29, 0.8) to transparent)
  static const LinearGradient heroImageOverlay = LinearGradient(
    colors: [Color(0xCC12281D), Color(0x0012281D)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // ── Detail Wisata (frame 4714:452 "Detail Wisata - Luk Panenteng (Modern)") ──
  static const Color detailBackground = Color(0xFFF4F6F1); // bg halaman
  static const Color detailBorder     = Color(0xFFE4E8E0); // border card
  static const Color detailBody       = Color(0xFF4D554F); // body/desc
  static const Color earth            = Color(0xFF8D4E29); // jalur darat
  static const Color navySky          = Color(0xFF2D3C59); // jalur udara
  static const Color mintSoft         = Color(0x66BBEECD); // 40% #BBEECD (jalur laut)
  static const Color mintSoftStrong   = Color(0x99BBEECD); // 60% #BBEECD (avatar)
  static const Color peachSoft        = Color(0x80FFDBCA); // 50% #FFDBCA (jalur darat)
  static const Color creamCard        = Color(0xFFFAF8F5); // footer kartu
  static const Color starGold         = Color(0xFFE5BA41); // bintang rating
}
