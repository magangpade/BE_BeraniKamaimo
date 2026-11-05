import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bagian Jadwal + Tiket + Tombol Simpan Kalender.
class EventScheduleSection extends StatelessWidget {
  final String jadwal;
  final String tiket;
  final int jumlahHari;
  final VoidCallback onSaveCalendar;

  const EventScheduleSection({
    required this.jadwal,
    required this.tiket,
    required this.jumlahHari,
    required this.onSaveCalendar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.shadowSoft,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.calendar_month_rounded,
                  title: 'Jadwal Acara',
                  subtitle: jadwal,
                  footer: '$jumlahHari Hari Penuh',
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
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onSaveCalendar,
              icon: const Icon(
                Icons.event_available_rounded,
                size: 16,
                color: Colors.white,
              ),
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
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFFCF8F5) : const Color(0xFFF7FAF7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlight ? const Color(0xFFF3E7DC) : const Color(0xFFE4ECE4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: highlight
                  ? const Color(0xFFF0E8E2)
                  : const Color(0xFFE8EFEB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: highlight ? AppColors.earth : AppColors.pine700,
            ),
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
