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
    return Row(
      children: [
        _KontakBtn(
          label: isEn ? 'Chat${_short(itemName, isEn)}' : 'Chat${_short(itemName, isEn)}',
          icon: Icons.chat_rounded,
          iconColor: AppColors.emerald600,
          onTap: onTelepon ?? onTap ?? () {},
        ),
        const SizedBox(width: 10),
        _KontakBtn(
          label: isEn ? 'Maps${_short(itemName, isEn)}' : 'Maps${_short(itemName, isEn)}',
          icon: Icons.travel_explore_rounded,
          iconColor: AppColors.pine900,
          onTap: onMaps ?? onTap ?? () {},
        ),
        const SizedBox(width: 10),
        _KontakBtn(
          label: isEn ? 'Web${_short(itemName, isEn)}' : 'Web${_short(itemName, isEn)}',
          icon: Icons.public_rounded,
          iconColor: AppColors.emerald600,
          onTap: onWebsite ?? onTap ?? () {},
        ),
      ],
    );
  }

  String _short(String? name, bool isEn) {
    if (name == null || name.trim().isEmpty) return '';
    final n = name.trim();
    final short = n.length > 12 ? '${n.substring(0, 12)}…' : n;
    return ' $short';
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
