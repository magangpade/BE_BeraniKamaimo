import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';

/// Kartu "Jaminan Harga Resmi Dinas Pariwisata" — tab Tempat Menginap.
class TrustCard extends StatelessWidget {
  const TrustCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: AppColors.shadowCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.emerald100,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.shield_rounded,
              size: 22,
              color: AppColors.emerald600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEn
                      ? 'Official Tourism Office Price Guarantee'
                      : 'Jaminan Harga Resmi Dinas Pariwisata',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEn
                      ? 'All phone and WhatsApp numbers connect directly to the accommodation front desk without third-party intermediaries.'
                      : 'Semua nomor telepon dan WhatsApp terhubung langsung ke meja resepsionis penginapan tanpa perantara pihak ketiga.',
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: AppColors.textBody,
                    fontFamily: 'PlusJakartaSans',
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
