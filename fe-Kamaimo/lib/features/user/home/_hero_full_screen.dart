import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Hero Section Full Screen per Figma design (node 4273:55)
/// Gambar full-screen + judul animasi per-huruf "Sulawesi Tengah" + tagline
class _HeroFullScreenSection extends StatelessWidget {
  const _HeroFullScreenSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        image: DecorationImage(
          image: AssetImage('assets/images/danau_paisu_pok.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient overlay for text readability (match Figma: rgba(18, 40, 29, 0.8))
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xCC12281D), // rgba(18, 40, 29, 0.8)
                  Color(0x0012281D), // transparent at top
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title animasi per huruf (3 kategori berdasarkan Figma spec)
                const Text(
                  'Sulawesi',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tengah',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 40,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 16),
                // Tagline
                const Text(
                  'Menunggu petualanganmu di jantung indonesia',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                // CTA Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.pine700,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pine700.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Mulai Jelajah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}