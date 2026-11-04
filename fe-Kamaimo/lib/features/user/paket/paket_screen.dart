import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/tour_package_repository.dart';
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
  List<PaketItem> _items = PaketSeed.items;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchPaket());
  }

  Future<void> _fetchPaket() async {
    setState(() => _loading = true);
    try {
      final repo = context.read<TourPackageRepository>();
      final list = await repo.getAll();
      if (list.isNotEmpty && mounted) {
        setState(() {
          _items = list.map((tp) => PaketItem.fromModel(tp)).toList();
        });
      }
    } catch (_) {}
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  Future<void> _onWhatsApp(PaketItem item) async {
    String phone = item.kontak.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.isEmpty) phone = '6281234567890';
    if (phone.startsWith('0')) phone = '62${phone.substring(1)}';
    final text = 'Halo, saya ingin menanyakan reservasi paket wisata "${item.nama}" (${item.durasi}). Apakah kuota masih tersedia?';
    final url = 'https://wa.me/$phone?text=${Uri.encodeComponent(text)}';
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hubungi operator di WhatsApp: +$phone')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final shown = _items.where((p) {
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
                        padEnds: false,
                        itemCount: shown.length,
                        itemBuilder: (ctx, i) => Container(
                          padding: EdgeInsets.only(
                            left: 12,
                            right: i == shown.length - 1 ? 12 : 0,
                          ),
                          child: FeaturedPaketCard(
                            item: shown[i],
                            onWhatsApp: () => _onWhatsApp(shown[i]),
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
