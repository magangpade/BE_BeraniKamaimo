import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';

/// Baris 3 tombol aksi kartu katalog Eksplor: Telepon (WA), Maps, Website.
class KontakRow extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTelepon;
  final VoidCallback? onMaps;
  final VoidCallback? onWebsite;
  final String? itemName;

  const KontakRow({
    super.key,
    this.onTap,
    this.onTelepon,
    this.onMaps,
    this.onWebsite,
    this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final phoneAction = onTelepon ?? onTap;
    final mapAction = onMaps ?? onTap;
    final websiteAction = onWebsite ?? onTap;
    return Row(
      children: [
        if (phoneAction != null) ...[
          _KontakBtn(
            label: isEn ? 'Call' : 'Telepon',
            icon: Icons.call_rounded,
            iconColor: AppColors.emerald600,
            onTap: phoneAction,
          ),
        ],
        if (mapAction != null) ...[
          if (phoneAction != null) const SizedBox(width: 10),
          _KontakBtn(
            label: 'Maps',
            icon: Icons.travel_explore_rounded,
            iconColor: AppColors.pine900,
            onTap: mapAction,
          ),
        ],
        if (websiteAction != null) ...[
          if (phoneAction != null || mapAction != null)
            const SizedBox(width: 10),
          _KontakBtn(
            label: 'Website',
            icon: Icons.public_rounded,
            iconColor: AppColors.emerald600,
            onTap: websiteAction,
          ),
        ],
      ],
    );
  }
}

class _KontakBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

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
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.detailBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
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
