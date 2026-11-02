import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bagian Jadwal + Tiket + Tombol Simpan Kalender.
class EventScheduleSection extends StatelessWidget {
  final String jadwal;
  final String tiket;
  final VoidCallback onSaveCalendar;

  const EventScheduleSection({
    required this.jadwal,
    required this.tiket,
    required this.onSaveCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.calendar_month_rounded,
                  title: 'Jadwal Acara',
                  subtitle: jadwal,
                  footer: '2 Hari Penuh',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _InfoTile(
                  icon: Icons.confirmation_number_rounded,
                  title: 'Tiket Masuk',
                  subtitle: tiket,
                  footer: 'Terbuka Umum',
                  highlight: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onSaveCalendar,
              icon: const Icon(Icons.event_available_rounded, size: 16, color: Colors.white),
              label: const Text(
                'Simpan ke Kalender Saya',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pine700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String footer;
  final bool highlight;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.footer,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppColors.shadowCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: AppColors.pine700),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTertiary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: highlight ? AppColors.emerald600 : AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                Text(
                  footer,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
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
