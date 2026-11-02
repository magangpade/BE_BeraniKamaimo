import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Kartu hitung mundur (countdown) menuju festival.
/// Menggunakan 4 kotak: Hari, Jam, Menit, Detik.
class EventCountdownCard extends StatelessWidget {
  final int hari;
  final int jam;
  final int menit;
  final int detik;

  const EventCountdownCard({
    required this.hari,
    required this.jam,
    required this.menit,
    required this.detik,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppColors.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.schedule_rounded, size: 14, color: AppColors.pine700),
                  SizedBox(width: 6),
                  Text(
                    'MENUJU UPACARA PEMBUKAAN',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.pine500,
                      letterSpacing: 0.8,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.emerald50,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: AppColors.emerald500),
                    SizedBox(width: 4),
                    Text(
                      'Segera Hadir',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.emerald600,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _Box(label: 'HARI', val: hari),
              const SizedBox(width: 8),
              _Box(label: 'JAM', val: jam),
              const SizedBox(width: 8),
              _Box(label: 'MENIT', val: menit),
              const SizedBox(width: 8),
              _Box(label: 'DETIK', val: detik, isHighlight: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final String label;
  final int val;
  final bool isHighlight;

  const _Box({required this.label, required this.val, this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              '$val'.padLeft(2, '0'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isHighlight ? AppColors.warning : AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: AppColors.textTertiary,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
