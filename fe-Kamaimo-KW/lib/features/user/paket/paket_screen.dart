import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../home/user_shell.dart';
import 'paket_data.dart';
import 'widgets/featured_paket_card.dart';
import 'widgets/paket_filters.dart';
import 'widgets/paket_header.dart';
import 'widgets/trust_paket_card.dart';

// Tab Paket — Figma 4965:1243 "Paket Wisata Sulteng (Modern)".
class PaketScreen extends StatefulWidget {
  const PaketScreen({super.key});

  @override
  State<PaketScreen> createState() => _PaketScreenState();
}

class _PaketScreenState extends State<PaketScreen> {
  final PageController _page = PageController(viewportFraction: 0.86);
  int _kategori = 0;
  String _query = '';

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final shown = PaketSeed.items.where((p) {
      final cocokKategori =
          _kategori == 0 ||
          p.kategori == PaketSeed.kategori[_kategori].toUpperCase();
      final cocokQuery =
          q.isEmpty ||
          p.nama.toLowerCase().contains(q) ||
          p.wilayah.toLowerCase().contains(q) ||
          p.kategori.toLowerCase().contains(q);
      return cocokKategori && cocokQuery;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        key: const Key('paketScroll'),
        slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: KamaimoBarDelegate(showToggle: false),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaketHeader(onChanged: (v) => setState(() => _query = v)),
                const SizedBox(height: 14),
                PaketFilters(
                  kategoriIndex: _kategori,
                  onKategori: (i) => setState(() => _kategori = i),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            sliver: SliverToBoxAdapter(
              child: shown.isEmpty
                  ? const _EmptyPaket()
                  : SizedBox(
                      height: 578,
                      child: PageView.builder(
                        controller: _page,
                        itemCount: shown.length,
                        itemBuilder: (ctx, i) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: FeaturedPaketCard(
                            item: shown[i],
                            onWhatsApp: _onWhatsApp,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 20),
                TrustPaketCard(),
                SizedBox(height: 28),
                KamaimoFooter(),
                KamaimoNavClearance(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onWhatsApp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chat WhatsApp: aktif saat data API (M2)')),
    );
  }
}

class _EmptyPaket extends StatelessWidget {
  const _EmptyPaket();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Text(
          'Belum ada paket untuk filter ini',
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
}
