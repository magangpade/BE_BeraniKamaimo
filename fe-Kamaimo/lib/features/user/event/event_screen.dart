import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../home/user_shell.dart';
import 'detail_event_screen.dart';
import 'event_data.dart';
import 'widgets/event_agenda_card.dart';
import 'widgets/event_filters.dart';
import 'widgets/event_header.dart';
import 'widgets/featured_event_card.dart';

// Tab Event — Figma MAGANG-PADE (export PNG "Temukan cerita di setiap event Sulteng")
class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int _kategori = 0;
  int _tanggal = 0;
  String? _wilayah;
  String _query = '';

  DateTime get _now => DateTime.now();

  bool _lolosTanggal(EventItem e) {
    if (_tanggal == 0) return true;
    final kini = DateTime(_now.year, _now.month, _now.day);
    final start = DateTime(e.start.year, e.start.month, e.start.day);
    if (_tanggal == 1) {
      return start.year == _now.year && start.month == _now.month;
    }
    if (_tanggal == 2) {
      final depan = DateTime(_now.year, _now.month + 1);
      return start.year == depan.year && start.month == depan.month;
    }
    return start.year == _now.year;
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final shown = EventSeed.agenda.where((e) {
      final cocokKategori =
          _kategori == 0 || e.kategori == EventFilters.labels[_kategori].toUpperCase();
      final cocokWilayah = _wilayah == null || e.wilayah == _wilayah;
      final cocokQuery = q.isEmpty ||
          e.nama.toLowerCase().contains(q) ||
          e.lokasi.toLowerCase().contains(q);
      return cocokKategori && cocokWilayah && cocokQuery && _lolosTanggal(e);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        key: const Key('eventScroll'),
        slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: KamaimoBarDelegate(showToggle: false),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventHeader(
                    onChanged: (v) => setState(() => _query = v),
                  ),
                  const SizedBox(height: 13),
                  EventFilters(
                    kategoriIndex: _kategori,
                    tanggalIndex: _tanggal,
                    wilayah: _wilayah,
                    wilayahList: EventSeed.wilayahList,
                    onKategori: (i) => setState(() => _kategori = i),
                    onTanggal: (i) => setState(() => _tanggal = i),
                    onWilayah: (v) =>
                        setState(() => _wilayah = v == 'Semua wilayah' ? null : v),
                  ),
                  const _SectionHeader(
                    eyebrowIcon: Icons.auto_awesome_rounded,
                    eyebrow: 'JANGAN TERLEWATKAN',
                    judul: 'Event pilihan bulan ini',
                  ),
                  if (_kategori == 0 && q.isEmpty) ...[
                    FeaturedEventCard(
                      item: EventSeed.featured,
                      now: _now,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailEventScreen(event: EventSeed.featured),
                          ),
                        );
                      },
                    ),
                  ],
                  const _SectionHeader(
                    eyebrowIcon: Icons.map_rounded,
                    eyebrow: 'RENCANAKAN PERJALANANMU',
                    judul: 'Agenda mendatang',
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.separated(
              itemCount: shown.length + (shown.isEmpty ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                if (shown.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'Belum ada event untuk filter ini',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textTertiary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  );
                }
                final e = shown[i];
                return EventAgendaCard(
                  item: e,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailEventScreen(event: e),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10),
                KamaimoFooter(),
                KamaimoNavClearance(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData eyebrowIcon;
  final String eyebrow;
  final String judul;

  const _SectionHeader({
    required this.eyebrowIcon,
    required this.eyebrow,
    required this.judul,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(eyebrowIcon, size: 13, color: AppColors.pine500),
              const SizedBox(width: 6),
              Text(
                eyebrow,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine500,
                  letterSpacing: 0.8,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            judul,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.pine900,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}
