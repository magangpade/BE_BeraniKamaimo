import 'package:flutter/material.dart';

import '../../../../core/widgets/kamaimo_image.dart';

import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/kamaimo_image.dart';

/// Hero Tab Event: foto penuh layar + tombol kembali & bagikan di pojok.
class EventHeaderHero extends StatelessWidget {
  final String foto;
  final VoidCallback onBack;
  final VoidCallback onShare;

  const EventHeaderHero({
    required this.foto,
    required this.onBack,
    required this.onShare,
  });

  static const double _height = 295;

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foto hero + scrim bawah agar teks di card floating tetap readable.
          LayoutBuilder(builder: (context, _) => _heroImage(context)),
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
              tooltip: isEnglish ? 'Back' : 'Kembali',
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: _GlassButton(
              icon: Icons.ios_share,
              onTap: onShare,
              tooltip: isEnglish ? 'Share' : 'Bagikan',
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroImage(BuildContext context) {
    final f = foto.trim();
    return KamaimoImage(
      path: f,
      fit: BoxFit.cover,
      width: double.infinity,
      height: _height,
      fallbackAsset: 'assets/images/beranda/pasar_kreatif_hero.png',
    );
  }
}

/// Tombol lingkaran kaca di pojok hero.
class _GlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;

  const _GlassButton({required this.icon, this.onTap, required this.tooltip});

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
          border: Border.all(
            color: AppColors.textOnPrimary.withValues(alpha: 0.15),
          ),
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
