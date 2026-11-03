import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Baris 3 tombol aksi kartu katalog Eksplor: Telepon (WA), Maps, Website.
/// Aksi placeholder → snackbar sesuai konvensi Tab Paket (aktif di M2).
class KontakRow extends StatelessWidget {
  final VoidCallback onTap;

  const KontakRow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _KontakBtn(
          label: 'Telepon',
          icon: Icons.chat_rounded,
          iconColor: AppColors.emerald600,
          onTap: onTap,
        ),
        const SizedBox(width: 10),
        _KontakBtn(
          label: 'Maps',
          icon: Icons.travel_explore_rounded,
          iconColor: AppColors.pine900,
          onTap: onTap,
        ),
        const SizedBox(width: 10),
        _KontakBtn(
          label: 'Website',
          icon: Icons.public_rounded,
          iconColor: AppColors.emerald600,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _KontakBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _KontakBtn({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.detailBorder),
            ),
            child: Column(
              children: [
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
