import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Hero parallax-styled untuk Detail Wisata (frame 4714:452).
/// Foto destinasi + scrim pine + tombol glass + pill status buka.
class DetailHero extends StatelessWidget {
  final String foto;
  final String statusText;

  const DetailHero({
    super.key,
    required this.foto,
    required this.statusText,
  });

  static const double _height = 410;

  // Scrim multi-layer sesuai Figma:
  // linear-gradient(180deg, rgba(29,58,48,0.6) 0%, rgba(29,58,48,0) 30%, rgba(29,58,48,0.8) 78%)
  static const List<double> _scrimStops = [0.0, 0.30, 0.78, 1.0];
  static const List<Color> _scrimColors = [
    Color(0x991D3A30),
    Color(0x001D3A30),
    Color(0xCC1D3A30),
    Color(0xCC1D3A30),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (foto backend) + fallback foto hero demo Figma
          LayoutBuilder(
            builder: (context, _) => _heroImage(context),
          ),


          // Sophisticated Multi-layer Scrim Gradient
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: _scrimStops,
                colors: _scrimColors,
              ),
            ),
          ),

          // Floating Header Navigation (iOS Top Safe Area Aware)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GlassIconButton(
                  icon: Icons.chevron_left_rounded,
                  tooltip: 'Kembali',
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                const _GlassIconButton(
                  icon: Icons.ios_share,
                  tooltip: 'Bagikan',
                  onTap: null, // aksi share terpisah (M2)
                ),
              ],
            ),
          ),

          // Bottom Hero Overprint Tag: status buka (placeholder statis)
          Positioned(
            left: 30,
            bottom: 23,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.pine500.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: AppColors.textOnPrimary.withValues(alpha: 0.1)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.mintSoftStrong,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 16 / 12,
                        letterSpacing: 0.3, // Figma 0.025em @12px
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Resolusi foto: path asset (`assets/...`) → Image.asset,
  /// URL http(s) → Image.network dengan errorBuilder fallback,
  /// kosong/gagal → foto hero demo Figma (Luk Panenteng).
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
          errorBuilder: (_, _, _) => _fallbackImage(),
        ),
      );
    }
    if (f.startsWith('http://') || f.startsWith('https://')) {
      return Image.network(
        f,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Image.asset(fallbackAsset, fit: BoxFit.cover),
      );
    }
    return Image.asset(fallbackAsset, fit: BoxFit.cover);
  }

  Widget _fallbackImage() => Container(
        color: AppColors.surfaceElevated,
        child: const Center(
          child: Icon(
            Icons.landscape_rounded,
            size: 64,
            color: AppColors.pine500,
          ),
        ),
      );
}

/// Tombol glass pill 44x44 (white 80%, border white 40%, blur shadow).
class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  const _GlassIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.textOnPrimary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(9999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: AppColors.textOnPrimary.withValues(alpha: 0.4),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000), // 0px 8px 32px rgba(0,0,0,0.12)
                  offset: Offset(0, 8),
                  blurRadius: 32,
                ),
              ],
            ),
            child: Icon(icon, size: 22, color: AppColors.pine900),
          ),
        ),
      ),
    );
  }
}
