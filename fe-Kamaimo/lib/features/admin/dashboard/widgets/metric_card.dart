import 'package:flutter/material.dart';

/// Card metrik dashboard admin — responsif mobile/desktop.
/// Menampilkan: title, visits, visitors dengan ikon dan gradient pine.
class MetricCard extends StatelessWidget {
  final String title;
  final int visits;
  final int visitors;
  final IconData icon;
  final List<Color> gradientColors;

  const MetricCard({
    super.key,
    required this.title,
    required this.visits,
    required this.visitors,
    required this.icon,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;
    const secondaryColor = Colors.white70;

    final double titleSize = MediaQuery.of(context).size.width < 600 ? 11 : 13;
    final double valueSize = MediaQuery.of(context).size.width < 600 ? 18 : 22;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'PlusJakartaSans',
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kunjungan',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: MediaQuery.of(context).size.width < 600 ? 8 : 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Text(
                      '$visits',
                      style: TextStyle(
                        color: textColor,
                        fontSize: valueSize,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Pengunjung Unik',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: MediaQuery.of(context).size.width < 600 ? 8 : 10,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Text(
                      '$visitors',
                      style: TextStyle(
                        color: textColor,
                        fontSize: valueSize,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
