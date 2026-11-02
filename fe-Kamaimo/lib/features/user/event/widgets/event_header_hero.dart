import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Hero Tab Event: foto penuh layar + tombol kembali & bagikan di pojok.
/// Tombol "Bagikan" dicabut ke M2 (belum ada dependency url_launcher).
class EventHeaderHero extends StatelessWidget {
  final String foto;
  final VoidCallback onBack;
  final VoidCallback onShare;

  const EventHeaderHero({
    required this.foto,
    required this.onBack,
    required this.onShare,
  });

  static const double _height = 380;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foto hero + scrim bawah agar teks di card floating tetap readable.
          LayoutBuilder(
            builder: (context, _) => _heroImage(context),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.45],
                colors: [Color(0xCC1D3A30), Color(0x001D3A30)],
              ),
            ),
          ),
          // Tombol pojok kiri/kanan.
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: _GlassButton(
              icon: Icons.chevron_left_rounded,
              onTap: onBack,
              tooltip: 'Kembali',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: _GlassButton(
              icon: Icons.ios_share,
              onTap: onShare,
              tooltip: 'Bagikan',
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroImage(BuildContext context) {
    const fallbackAsset = 'assets/images/detail_wisata/hero_luk_panenteng.png';
    final f = foto.trim();
    if (f.startsWith('assets/')) {
      return Image.asset(
        f,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Image.asset(
          fallbackAsset,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(fallbackAsset, fit: BoxFit.cover);
  }
}

/// Tombol lingkaran kaca di pojok hero.
class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;

  const _GlassButton({
    required this.icon,
    this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantSoft,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.textOnPrimary.withValues(alpha: 0.15)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(icon, size: 20, color: AppColors.pine900),
          onPressed: onTap,
        ),
      ),
    );
  }
}
