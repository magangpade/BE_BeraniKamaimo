import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

/// Widget jam & tanggal live untuk sidebar / topbar admin.
class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, d MMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm:ss');

    String dateStr;
    try {
      dateStr = dateFormat.format(_now);
    } catch (_) {
      const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      final dayName = days[_now.weekday - 1];
      final monthName = months[_now.month - 1];
      dateStr = '$dayName, ${_now.day} $monthName ${_now.year}';
    }

    final timeStr = timeFormat.format(_now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time_filled_rounded, size: 13, color: AppColors.emerald500),
              const SizedBox(width: 6),
              Text(
                timeStr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'WITA',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            dateStr,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
