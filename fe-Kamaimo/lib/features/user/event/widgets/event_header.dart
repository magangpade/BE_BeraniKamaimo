import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Panel hero Tab Event: judul, subjudul, dan search bar.
class EventHeader extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const EventHeader({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFECFDF5),
                Color(0xFFF2F4EE),
                Color(0xFFFFFFFF),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    height: 1.3,
                    fontFamily: 'PlusJakartaSans',
                  ),
                  children: const [
                    TextSpan(text: 'Temukan cerita di setiap '),
                    TextSpan(
                      text: 'event Sulteng',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.pine700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Dari festival budaya hingga pesona bahari. Pilih momen terbaik untuk jelajah Sulawesi Tengah.',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBody,
                  height: 1.4,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 13),
              Container(
                height: 46,
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        size: 18, color: AppColors.textTertiary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: onChanged,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Cari event atau lokasi...',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          right: -12,
          top: -26,
          child: _Glow(),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: const BoxDecoration(
        color: Color(0x40B7E4C7),
        shape: BoxShape.circle,
      ),
    );
  }
}
