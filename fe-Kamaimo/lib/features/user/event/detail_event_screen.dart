import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kamaimo_image.dart';
import '../../../data/repositories/event_rating_repository.dart';
import 'event_data.dart';
import 'event_detail_data.dart';
import 'event_english_detail.dart';
import 'event_locale.dart';
import 'widgets/event_countdown_card.dart';
import 'widgets/event_header_hero.dart';
import 'widgets/event_info_card.dart';
import 'widgets/event_location_map.dart';
import 'widgets/event_rating_sheet.dart';
import 'widgets/event_schedule_section.dart';
import 'widgets/event_share_sheet.dart';

class DetailEventScreen extends StatefulWidget {
  final EventItem event;
  final EventRatingRepository? ratingRepository;

  const DetailEventScreen({
    required this.event,
    this.ratingRepository,
    super.key,
  });

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  static const _cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(24)),
    boxShadow: AppColors.shadowSoft,
  );
  late final EventDetail _detail;
  EventRatingRepository? _ratingRepository;
  EventRatingSummary? _ratingSummary;
  bool _ratingLoaded = false;
  bool get _isPasarKreatif => widget.event.nama == 'Pasar Kreatif Sulteng';

  @override
  void initState() {
    super.initState();
    _detail = widget.event.detail ?? EventDetailSeed.of(widget.event.nama);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ratingLoaded) return;
    _ratingLoaded = true;
    _ratingRepository =
        widget.ratingRepository ?? context.read<EventRatingRepository?>();
    _loadRating();
  }

  Future<void> _loadRating() async {
    final repository = _ratingRepository;
    if (repository == null) return;
    try {
      final summary = await repository.getSummary(widget.event.ratingKey);
      if (mounted) setState(() => _ratingSummary = summary);
    } catch (_) {
      // Data seed tetap terlihat saat API belum dapat dijangkau.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final d = !isEnglish ? _detail : widget.event.detail == null
        ? EventEnglishDetail.of(widget.event.nama, _detail)
        : _detail.withText(
            lokasi: EventLocale.location(widget.event, true),
            tentang: EventLocale.description(widget.event, true),
            program: widget.event.programEn,
            rundown: widget.event.rundownEn,
          );
    return Scaffold(
      backgroundColor: AppColors.detailBackground,
      body: CustomScrollView(
        slivers: [
          // HERO + INFO OVERLAY
          SliverToBoxAdapter(
            // Tinggi ini mencakup seluruh kartu info. Sebelumnya kartu keluar
            // dari batas Stack sehingga bagian bawah chip rating terlihat,
            // tetapi tidak ikut menerima sentuhan.
            child: SizedBox(
              height: 435,
              child: Stack(
                children: [
                  EventHeaderHero(
                    foto: widget.event.foto,
                    onBack: () => Navigator.of(context).pop(),
                    onShare: () => _share(),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    // Mempertahankan posisi visual kartu sebelumnya:
                    // batas bawah kartu berada 16 px sebelum countdown.
                    bottom: 16,
                    child: EventInfoCard(
                      badge: d.badge,
                      kategori: widget.event.kategori,
                      rating: _ratingSummary == null
                          ? (widget.event.ratingCount == 0
                                ? null
                                : widget.event.rating)
                          : _ratingSummary!.rating,
                      ratingCount:
                          _ratingSummary?.ratingCount ??
                          widget.event.ratingCount,
                      judul: EventLocale.name(widget.event, isEnglish),
                      lokasi: d.lokasi,
                      onRatingTap: _showRating,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // COUNTDOWN
          SliverToBoxAdapter(
            child: EventCountdownCard(
              start: widget.event.start,
              end: widget.event.end,
            ),
          ),

          // SCHEDULE + TICKET + SAVE CALENDAR
          SliverToBoxAdapter(
            child: EventScheduleSection(
              jadwal: _jadwal(isEnglish),
              jumlahHari:
                  (widget.event.end ?? widget.event.start)
                      .difference(widget.event.start)
                      .inDays +
                  1,
              tiket: widget.event.harga == null
                  ? (isEnglish ? 'FREE' : 'GRATIS')
                  : '${isEnglish ? 'From' : 'Mulai'} Rp${widget.event.harga}',
              onSaveCalendar: () => _saveCalendar(),
            ),
          ),

          // TENTANG FESTIVAL
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration,
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
                      Text(
                        isEnglish ? 'About the Festival' : 'Tentang Festival',
                        style: const TextStyle(
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
                    d.tentang,
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
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration,
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
                      Expanded(
                        child: Text(
                          isEnglish
                              ? 'Main Program Highlights'
                              : 'Rangkaian Program Utama',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.pine900,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Text(
                          'HIGHLIGHT',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isEnglish
                        ? 'Choose activities to discover the stories, creative work, and atmosphere of this event.'
                        : 'Pilih kegiatan yang ingin kamu ikuti untuk mengenal cerita, karya, dan suasana khas dari event ini.',
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...d.program.asMap().entries.map((e) {
                    final parts = e.value.split('|');
                    final foto = e.key < d.programImages.length
                        ? d.programImages[e.key]
                        : null;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F9F6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE4ECE4)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: foto == null || foto.isEmpty
                                ? Icon(
                                    _programIcon(parts.first),
                                    size: 32,
                                    color: AppColors.textTertiary,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: KamaimoImage(
                                      path: foto,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parts.first,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.pine900,
                                    height: 1.4,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  parts.length > 1
                                      ? parts[1]
                                      : (isEnglish
                                            ? 'View details →'
                                            : 'Lihat detail →'),
                                  style: TextStyle(
                                    fontSize: 11,
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
                  }).toList(),
                ],
              ),
            ),
          ),

          // JADWAL & RUNDOWN
          if (d.rundown.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(20),
                decoration: _cardDecoration,
                child: _RundownSection(
                  rundown: d.rundown,
                  zonaWita: d.zonaWita,
                ),
              ),
            ),

          // LOKASI & AKSES
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration,
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
                      Expanded(
                        child: Text(
                          isEnglish
                              ? 'Location & Travel Access'
                              : 'Lokasi & Akses Perjalanan',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            color: AppColors.pine900,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 116),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.emerald50,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          d.region,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.pine700,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  EventLocationMap(detail: d, onOpenMaps: _openMaps),
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
          if (d.organizer.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF0EA),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.pine700,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.organizer.first,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${d.organizer.skip(1).join(' ')} ${widget.event.start.year}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
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

  String _jadwal(bool isEnglish) {
    final mulai = widget.event.start;
    final akhir =
        widget.event.end ?? widget.event.start.add(const Duration(days: 1));
    final months = isEnglish
        ? const [
            'JAN',
            'FEB',
            'MAR',
            'APR',
            'MAY',
            'JUN',
            'JUL',
            'AUG',
            'SEP',
            'OCT',
            'NOV',
            'DEC',
          ]
        : const [
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
    final m1 = (mulai.month >= 1 && mulai.month <= 12)
        ? months[mulai.month - 1]
        : 'BLN';
    final m2 = (akhir.month >= 1 && akhir.month <= 12)
        ? months[akhir.month - 1]
        : 'BLN';
    if (mulai.year == akhir.year) {
      return '${mulai.day} $m1 - ${akhir.day} $m2 ${akhir.year}';
    }
    return '${mulai.day} $m1 ${mulai.year} - ${akhir.day} $m2 ${akhir.year}';
  }

  IconData _programIcon(String title) {
    final value = title.toLowerCase();
    if (value.contains('perahu') ||
        value.contains('pulau') ||
        value.contains('laut') ||
        value.contains('boat') ||
        value.contains('island') ||
        value.contains('sea')) {
      return Icons.sailing_rounded;
    }
    if (value.contains('kuliner') ||
        value.contains('rasa') ||
        value.contains('food') ||
        value.contains('flavor')) {
      return Icons.restaurant_rounded;
    }
    if (value.contains('tari') ||
        value.contains('musik') ||
        value.contains('seni') ||
        value.contains('dance') ||
        value.contains('music') ||
        value.contains('art')) {
      return Icons.theater_comedy_rounded;
    }
    if (value.contains('tenun') ||
        value.contains('kriya') ||
        value.contains('produk') ||
        value.contains('weav') ||
        value.contains('craft') ||
        value.contains('product')) {
      return Icons.palette_rounded;
    }
    if (value.contains('situs') ||
        value.contains('megalit') ||
        value.contains('site') ||
        value.contains('megalith')) {
      return Icons.landscape_rounded;
    }
    return Icons.celebration_rounded;
  }

  void _share() {
    const pasarKreatifPublicUrl = String.fromEnvironment(
      'PASAR_KREATIF_EVENT_URL',
    );
    showEventShareSheet(
      context,
      event: widget.event,
      publicUrl: _isPasarKreatif ? pasarKreatifPublicUrl : null,
    );
  }

  void _showRating() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (_) => EventRatingSheet(
        event: widget.event,
        initialRating: _ratingSummary?.myRating,
        onSubmit: (rating) async {
          final repository = _ratingRepository;
          if (repository == null) return false;
          final summary = await repository.submit(
            widget.event.ratingKey,
            rating,
          );
          if (mounted) setState(() => _ratingSummary = summary);
          return true;
        },
      ),
    );
  }

  Future<void> _saveCalendar() async {
    String date(DateTime value) =>
        '${value.year}${value.month.toString().padLeft(2, '0')}${value.day.toString().padLeft(2, '0')}';
    final end = (widget.event.end ?? widget.event.start).add(
      const Duration(days: 1),
    );
    final uri = Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': EventLocale.name(
        widget.event,
        context.read<LanguageProvider?>()?.isEnglish ?? false,
      ),
      'dates': '${date(widget.event.start)}/${date(end)}',
      'location': EventLocale.location(
        widget.event,
        context.read<LanguageProvider?>()?.isEnglish ?? false,
      ),
      'details': EventLocale.description(
        widget.event,
        context.read<LanguageProvider?>()?.isEnglish ?? false,
      ),
    });
    try {
      if (await launchUrl(uri, mode: LaunchMode.externalApplication)) return;
    } catch (_) {}
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (context.read<LanguageProvider?>()?.isEnglish ?? false)
                ? 'Calendar could not be opened.'
                : 'Kalender tidak dapat dibuka.',
          ),
        ),
      );
    }
  }

  Future<void> _openMaps() async {
    final uri = Uri.parse(
      _detail.mapsUrl.isNotEmpty
          ? _detail.mapsUrl
          : Uri.https('www.google.com', '/maps/search/', {
              'api': '1',
              'query': widget.event.lokasi,
            }).toString(),
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
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
            Image.asset(
              'assets/images/beranda/pasar_kreatif_rundown_calendar.png',
              width: 15,
              height: 17,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                (context.watch<LanguageProvider?>()?.isEnglish ?? false)
                    ? 'Schedule & Rundown'
                    : 'Jadwal & Rundown',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine900,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
            const SizedBox(width: 8),
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
        // Segmented tabs sesuai frame Figma.
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFECEFEA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(widget.rundown.length, (i) {
              final day = widget.rundown[i]['hari'] as String;
              final active = i == _activeTab;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _activeTab = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? AppColors.pine700 : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
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
        ),
        const SizedBox(height: 14), // Timeline items for active day
        ...(widget.rundown[_activeTab]['items'] as List).asMap().entries.map((
          entry,
        ) {
          final item = entry.value;
          final last =
              entry.key ==
              (widget.rundown[_activeTab]['items'] as List).length - 1;
          final chipColor = _chipColor(item['chipColor'] as String);
          final dotColor = _chipColor(
            (item['dotColor'] ?? item['chipColor']) as String,
          );
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
                        color: dotColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: dotColor.withValues(alpha: 0.2),
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    if (!last)
                      Container(width: 2, height: 92, color: AppColors.divider),
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
                          Expanded(
                            child: Text(
                              item['jam'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color:
                                    item['chipColor'] == 'yellow' ||
                                        item['chipColor'] == 'earth'
                                    ? AppColors.earth
                                    : AppColors.pine700,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ),
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
                        maxLines: 4,
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
      case 'slate':
        return AppColors.textSecondary;
      case 'earth':
        return AppColors.earth;
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
        color: const Color(0xFFF7F9F6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4ECE4)),
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
