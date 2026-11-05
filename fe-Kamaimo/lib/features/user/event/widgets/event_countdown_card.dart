import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Kartu hitung mundur real-time menuju tanggal mulai event.
/// Status: Segera Hadir -> Sedang Berlangsung -> Telah Selesai.
class EventCountdownCard extends StatefulWidget {
  final DateTime start;
  final DateTime? end;

  const EventCountdownCard({
    required this.start,
    this.end,
    super.key,
  });

  @override
  State<EventCountdownCard> createState() => _EventCountdownCardState();
}

class _EventCountdownCardState extends State<EventCountdownCard> {
  Timer? _timer;

  DateTime get _start =>
      DateTime(widget.start.year, widget.start.month, widget.start.day);

  DateTime get _finish {
    final end = widget.end ?? widget.start;
    return DateTime(end.year, end.month, end.day).add(const Duration(days: 1));
  }

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _schedule() {
    _timer?.cancel();
    _timer = null;
    final now = DateTime.now();
    if (now.isBefore(_start)) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {});
        if (!DateTime.now().isBefore(_start)) _schedule();
      });
    } else if (now.isBefore(_finish)) {
      _timer = Timer(_finish.difference(now), () {
        if (mounted) setState(() {});
        _schedule();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final beforeStart = now.isBefore(_start);
    final ongoing = !beforeStart && now.isBefore(_finish);
    final status = beforeStart
        ? 'Segera Hadir'
        : ongoing
            ? 'Sedang Berlangsung'
            : 'Telah Selesai';
    final header = beforeStart
        ? 'MENUJU HARI EVENT'
        : ongoing
            ? 'EVENT SEDANG BERLANGSUNG'
            : 'EVENT TELAH SELESAI';
    final remaining = beforeStart ? _start.difference(now) : Duration.zero;
    final totalDetik = remaining.inSeconds;
    final chipColor = beforeStart
        ? AppColors.emerald600
        : ongoing
            ? AppColors.earth
            : AppColors.textSecondary;
    final chipBackground = beforeStart
        ? AppColors.emerald50
        : ongoing
            ? AppColors.warning.withValues(alpha: 0.15)
            : AppColors.surfaceVariant;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.shadowSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 18,
                      color: AppColors.pine700,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        header,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine500,
                          letterSpacing: 0.8,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: chipBackground,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: chipColor),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: chipColor,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _Box(label: 'HARI', val: remaining.inDays),
              const SizedBox(width: 8),
              _Box(label: 'JAM', val: (totalDetik % 86400) ~/ 3600),
              const SizedBox(width: 8),
              _Box(label: 'MENIT', val: (totalDetik % 3600) ~/ 60),
              const SizedBox(width: 8),
              _Box(label: 'DETIK', val: totalDetik % 60, isHighlight: true),
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

  const _Box({
    required this.label,
    required this.val,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isHighlight
              ? const Color(0xFFFFF6F0)
              : const Color(0xFFF6F8F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlight
                ? const Color(0xFFFFE2CF)
                : const Color(0xFFE8ECE6),
          ),
        ),
        child: Column(
          children: [
            Text(
              '$val'.padLeft(2, '0'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: isHighlight
                    ? const Color(0xFF9A4C1B)
                    : AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
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
