import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../home/user_shell.dart';
import 'eksplor_data.dart';
import 'widgets/eksplor_header.dart';
import 'widgets/hotel_card.dart';
import 'widgets/kuliner_card.dart';
import 'widgets/trust_card.dart';

/// Tab Eksplor — "Katalog Wisata & Kuliner" (Tempat Menginap / Kuliner Khas)
/// sesuai 2 PNG export desain dari user (2026-10-29).
///
/// Data = seed dummy `EksplorSeed`; sambung API hotel/kuliner saat M2.
class EksplorScreen extends StatefulWidget {
  const EksplorScreen({super.key});

  @override
  State<EksplorScreen> createState() => _EksplorScreenState();
}

class _EksplorScreenState extends State<EksplorScreen> {
  final _search = TextEditingController();
  final _page = PageController(viewportFraction: 0.88);

  int _tab = 0; // 0 = Tempat Menginap | 1 = Kuliner Khas
  int _wilayah = 0;
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    _page.dispose();
    super.dispose();
  }

  List<HotelItem> get _hotels {
    final q = _query.trim().toLowerCase();
    return EksplorSeed.hotel.where((h) {
      final cocokWilayah =
          _wilayah == 0 || h.wilayah == EksplorSeed.wilayah[_wilayah];
      final cocokQuery = q.isEmpty ||
          h.nama.toLowerCase().contains(q) ||
          h.wilayah.toLowerCase().contains(q) ||
          h.lokasi.toLowerCase().contains(q) ||
          h.tag.toLowerCase().contains(q);
      return cocokWilayah && cocokQuery;
    }).toList();
  }

  List<KulinerItem> get _kuliners {
    final q = _query.trim().toLowerCase();
    return EksplorSeed.kuliner.where((k) {
      final cocokWilayah =
          _wilayah == 0 || k.wilayah == EksplorSeed.wilayah[_wilayah];
      final cocokQuery = q.isEmpty ||
          k.nama.toLowerCase().contains(q) ||
          k.warung.toLowerCase().contains(q) ||
          k.wilayah.toLowerCase().contains(q);
      return cocokWilayah && cocokQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        key: const Key('eksplorScroll'),
        slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: KamaimoBarDelegate(showToggle: false),
          ),
          SliverToBoxAdapter(
            child: EksplorHeader(
              tabIndex: _tab,
              searchController: _search,
              wilayahIndex: _wilayah,
              onTab: (i) => setState(() => _tab = i),
              onQuery: (v) => setState(() => _query = v),
              onWilayah: (i) => setState(() => _wilayah = i),
            ),
          ),
          SliverToBoxAdapter(child: _intro()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            sliver: SliverToBoxAdapter(child: _carousel()),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (_tab == 0) _trust(),
                const SizedBox(height: 28),
                const KamaimoFooter(),
                const KamaimoNavClearance(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Blok kontekstual di atas carousel per tab.
  Widget _intro() {
    final isHotel = _tab == 0;
    final jumlah = isHotel ? _hotels.length : _kuliners.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isHotel) ..._gastronomi(),
          // Bullet + label verifikasi (kuliner diberi angka, seperti desain)
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.pine800,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                isHotel
                    ? 'AKOMODASI TERVERIFIKASI PEMPROV'
                    : '$jumlah REKOMENDASI TERVERIFIKASI',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                  color: AppColors.pine500,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Intro besar tab Kuliner: chip "EKSPLORASI GASTRONOMI" + H2 + deskripsi.
  List<Widget> _gastronomi() {
    return [
      // Chip mint + ikon buku (kiri-aligned seperti desain)
      Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.mintSoftStrong,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book_rounded, size: 15, color: AppColors.pine800),
            SizedBox(width: 6),
            Text(
              'EKSPLORASI GASTRONOMI',
              key: Key('eksplorGastronomi'),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: AppColors.pine800,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'Cita Rasa Otentik Bumi Tadulako',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          height: 1.2,
          letterSpacing: -0.6,
          color: AppColors.pine900,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'Simfoni rempah segar, perasan asam alami, dan aroma gurih kelapa '
        'bakar warisan leluhur pesisir hingga pegunungan.',
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          height: 1.55,
          color: AppColors.textBody,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      const SizedBox(height: 18),
    ];
  }

  Widget _trust() => const TrustCard();

  Widget _carousel() {
    final isHotel = _tab == 0;
    final kosong = isHotel ? _hotels.isEmpty : _kuliners.isEmpty;

    if (kosong) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Text(
            'Belum ada katalog untuk pencarian ini',
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

    final cards = <Widget>[];
    if (isHotel) {
      cards.addAll([
        for (final h in _hotels) HotelCard(item: h, onKontak: _onKontak),
      ]);
    } else {
      cards.addAll([
        for (final k in _kuliners) KulinerCard(item: k, onKontak: _onKontak),
      ]);
    }

    return SizedBox(
      height: 640,
      child: PageView.builder(
        controller: _page,
        itemCount: cards.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: cards[i],
        ),
      ),
    );
  }

  void _onKontak() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kontak resmi: aktif saat data API (M2)')),
    );
  }
}
