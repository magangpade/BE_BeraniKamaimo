import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'event_data.dart';
import 'event_detail_data.dart';
import 'widgets/event_countdown_card.dart';
import 'widgets/event_header_hero.dart';
import 'widgets/event_info_card.dart';
import 'widgets/event_schedule_section.dart';

class DetailEventScreen extends StatefulWidget {
  final EventItem event;

  const DetailEventScreen({required this.event, super.key});

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  late final EventDetail _detail;
  late final DateTime _start;

  @override
  void initState() {
    super.initState();
    _detail = EventDetailSeed.of(widget.event.nama);
    _start = DateTime(
      widget.event.start.year,
      widget.event.start.month,
      widget.event.start.day,
    );
  }

  Duration get _diff {
    final now = DateTime.now();
    final mulai = DateTime(_start.year, _start.month, _start.day);
    var d = mulai.difference(DateTime(now.year, now.month, now.day));
    if (d.isNegative) d = Duration.zero;
    return d;
  }

  @override
  Widget build(BuildContext context) {
    final d = _detail;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // HERO + INFO OVERLAY
          SliverToBoxAdapter(
            child: Stack(
              children: [
                EventHeaderHero(
                  foto: widget.event.foto,
                  onBack: () => Navigator.of(context).pop(),
                  onShare: () => _share(),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: -30,
                  child: EventInfoCard(
                    badge: d.badge,
                    kategori: widget.event.kategori,
                    rating: widget.event.rating,
                    ratingCount: widget.event.ratingCount,
                    judul: widget.event.nama,
                    lokasi: widget.event.lokasi,
                  ),
                ),
              ],
            ),
          ),

          // COUNTDOWN
          SliverToBoxAdapter(
            child: EventCountdownCard(
              hari: _diff.inDays,
              jam: (_diff.inSeconds % 86400) ~/ 3600,
              menit: (_diff.inSeconds % 3600) ~/ 60,
              detik: _diff.inSeconds % 60,
            ),
          ),

          // SCHEDULE + TICKET + SAVE CALENDAR
          SliverToBoxAdapter(
            child: EventScheduleSection(
              jadwal: _jadwal(),
              tiket: widget.event.harga == null
                  ? 'Tiket Masuk GRATIS, Terbuka Umum'
                  : 'Tiket Masuk Mulai Rp${widget.event.harga}, Terbuka Umum',
              onSaveCalendar: () => _saveCalendar(),
            ),
          ),

          // TENTANG FESTIVAL
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.emerald50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: AppColors.emerald600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Tentang Festival',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _detail.tentang,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBody,
                      height: 1.6,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // RANGKAIAN PROGRAM UTAMA
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Rangkaian Program Utama',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Text(
                          'HIGHLIGHT',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: AppColors.orangeBadge,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                   ...d.program.asMap().entries.map((e) {
                     final prog = e.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.image_rounded,
                              size: 32,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prog,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.pine900,
                                    height: 1.4,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Lihat detail →',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.pine700,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // JADWAL & RUNDOWN
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _RundownSection(rundown: d.rundown, zonaWita: d.zonaWita),
            ),
          ),

          // LOKASI & AKSES
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.emerald50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: AppColors.pine700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Lokasi & Akses Perjalanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => _openMaps(),
                        child: const Text(
                          'Buka Petunjuk di Google Maps',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.pine700,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Map placeholder
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_rounded,
                            size: 48,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            d.lokasi,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...d.akses.map(
                    (a) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _AccessTile(
                        title: a['title'] as String,
                        detail: a['detail'] as String,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FOOTER ORGANIZER
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: AppColors.shadowCard,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: d.organizer.map((o) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          o,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '© ${DateTime.now().year} Dinas Pariwisata Sulteng',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textTertiary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  String _jadwal() {
    final mulai = widget.event.start;
    final akhir = widget.event.start.add(const Duration(days: 1));
    final fmt = (DateTime d) => '${d.day} ${_month[d.month]} ${d.year}';
    return '${fmt(mulai)} - ${fmt(akhir)} • 2 Hari Penuh';
  }

  static const _month = [
    null,
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MEI',
    'JUN',
    'JUL',
    'AGU',
    'SEP',
    'OKT',
    'NOV',
    'DES',
  ];

  void _share() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Fitur bagikan akan hadir di M2.')),
  );

  void _saveCalendar() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Fitur simpan ke kalender akan hadir di M2.')),
  );

  void _openMaps() => ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Buka Google Maps — fitur M2.')));
}

/// Rundown section with tabs (Hari 1 / Hari 2) + timeline items
class _RundownSection extends StatefulWidget {
  final List<Map<String, dynamic>> rundown;
  final String zonaWita;

  const _RundownSection({required this.rundown, required this.zonaWita});

  @override
  State<_RundownSection> createState() => _RundownSectionState();
}

class _RundownSectionState extends State<_RundownSection> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.schedule_rounded,
                size: 18,
                color: AppColors.pine700,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Jadwal & Rundown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                widget.zonaWita,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppColors.pine700,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Tabs Hari 1 / Hari 2
        Row(
          children: List.generate(widget.rundown.length, (i) {
            final day = widget.rundown[i]['hari'] as String;
            final active = i == _activeTab;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _activeTab = i),
                child: Container(
                  margin: EdgeInsets.only(
                    right: i < widget.rundown.length - 1 ? 8 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.pine700 : Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: active ? null : Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                      color: active ? Colors.white : AppColors.pine900,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 14), // Timeline items for active day
        ...(widget.rundown[_activeTab]['items'] as List).map((item) {
          final chipColor = _chipColor(item['chipColor'] as String);
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline dot & line
                Column(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: chipColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Container(width: 2, color: AppColors.divider),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: chipColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              item['chip'] as String,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: chipColor,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item['jam'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.pine700,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['judul'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['deskripsi'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBody,
                          height: 1.4,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _chipColor(String c) {
    switch (c) {
      case 'mint':
        return AppColors.emerald600;
      case 'yellow':
        return AppColors.warning;
      default:
        return AppColors.pine700;
    }
  }
}

class _AccessTile extends StatelessWidget {
  final String title;
  final String detail;

  const _AccessTile({required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
            child: Icon(
              Icons.directions_bus_rounded,
              size: 18,
              color: AppColors.pine700,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                    height: 1.5,
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
