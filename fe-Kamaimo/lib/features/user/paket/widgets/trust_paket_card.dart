import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Kartu jaminan: "Jaminan Harga Transparan & Operator Berlisensi".
class TrustPaketCard extends StatelessWidget {
  const TrustPaketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.shadowCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: AppColors.emerald100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_rounded,
              size: 25,
              color: AppColors.emerald600,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jaminan Harga Transparan &\nOperator Berlisensi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    height: 1.3,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Standar resmi Dinas Pariwisata Sulawesi Tengah. Tanpa biaya siluman, langsung terhubung dengan pemandu HPI dan agen lokal bersertifikat.',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                    height: 1.45,
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
