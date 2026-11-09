import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kamaimo_image.dart';
import '../../../data/repositories/paket_rating_repository.dart';
import '../../../data/repositories/tour_package_repository.dart';
import '../home/user_shell.dart';
import 'paket_data.dart';
import 'widgets/featured_paket_card.dart';
import 'widgets/paket_filters.dart';
import 'widgets/paket_header.dart';
import 'widgets/paket_rating_sheet.dart';
import 'widgets/trust_paket_card.dart';

// Tab Paket — Figma 5064:2245 "Paket Wisata Sulteng Trekking (Modern)".
class PaketScreen extends StatefulWidget {
  const PaketScreen({super.key});

  @override
  State<PaketScreen> createState() => _PaketScreenState();
}

class _PaketScreenState extends State<PaketScreen> {
  final PageController _page = PageController(viewportFraction: 0.86);
  final PaketRatingRepository _ratingRepository = PaketRatingRepository();
  int _kategori = 0;
  String _query = '';
  List<PaketItem> _pakets = [];
  bool _loadedBackend = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchPaket());
  }

  Future<void> _fetchPaket() async {
    try {
      final repo = context.read<TourPackageRepository>();
      final list = await repo.getAll();
      if (mounted) {
        setState(() {
          _pakets = list.map((p) => PaketItem.fromModel(p)).toList();
          _loadedBackend = true;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider>().isEnglish;
    final q = _query.trim().toLowerCase();
    final sourceList = _loadedBackend ? _pakets : PaketSeed.items;
    final shown = sourceList.where((p) {
      final cocokKategori =
          _kategori == 0 ||
          p.kategori == PaketSeed.kategori[_kategori].toUpperCase();
      final cocokQuery =
          q.isEmpty ||
          p.nama.toLowerCase().contains(q) ||
          p.displayName(true).toLowerCase().contains(q) ||
          p.wilayah.toLowerCase().contains(q) ||
          p.kategori.toLowerCase().contains(q) ||
          p.displayCategory(true).toLowerCase().contains(q);
      return cocokKategori && cocokQuery;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        key: const Key('paketScroll'),
        slivers: [
          const SliverPersistentHeader(
            pinned: true,
            delegate: KamaimoBarDelegate(showToggle: true),
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
                  ? _EmptyPaket(isEnglish: isEnglish)
                  : SizedBox(
                      height: 550,
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
                            onRate: () => _showRating(shown[i]),
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

  Future<void> _onWhatsApp(PaketItem item) async {
    final isEnglish = context.read<LanguageProvider>().isEnglish;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _PaketWhatsAppSheet(
        item: item,
        isEnglish: isEnglish,
        onContinue: () => _openWhatsApp(item, isEnglish),
      ),
    );
  }

  Future<void> _openWhatsApp(PaketItem item, bool isEnglish) async {
    final message = isEnglish
        ? 'Hello, I am interested in the ${item.displayName(true)} package. Could you share more details?'
        : 'Halo, saya tertarik dengan paket ${item.nama}. Boleh minta informasi lebih lanjut?';
    var phone = item.kontak.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.startsWith('0')) phone = '62${phone.substring(1)}';
    final uri = Uri.https('wa.me', phone.isEmpty ? '/' : '/$phone', {
      'text': message,
    });
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEnglish
                ? 'WhatsApp could not be opened on this device.'
                : 'WhatsApp tidak dapat dibuka di perangkat ini.',
          ),
        ),
      );
    }
  }

  Future<void> _showRating(PaketItem item) async {
    final isEnglish = context.read<LanguageProvider>().isEnglish;
    final initialRating = await _ratingRepository.getMyRating(item.ratingKey);
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaketRatingSheet(
        item: item,
        isEnglish: isEnglish,
        initialRating: initialRating,
        onSubmit: (rating) => _ratingRepository.submit(item.ratingKey, rating),
      ),
    );
  }
}

class _EmptyPaket extends StatelessWidget {
  final bool isEnglish;

  const _EmptyPaket({required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Text(
          isEnglish
              ? 'No packages match these filters'
              : 'Belum ada paket untuk filter ini',
          style: const TextStyle(
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

class _PaketWhatsAppSheet extends StatelessWidget {
  final PaketItem item;
  final bool isEnglish;
  final VoidCallback onContinue;

  const _PaketWhatsAppSheet({
    required this.item,
    required this.isEnglish,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F7F3),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              isEnglish ? 'Contact the tour agent' : 'Hubungi agen wisata',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.pine900,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isEnglish
                  ? 'You are about to ask for more information about this package.'
                  : 'Anda akan meminta informasi lebih lanjut tentang paket ini.',
              style: const TextStyle(fontSize: 13, color: AppColors.textBody),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: KamaimoImage(path: item.foto, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.displayName(isEnglish),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.pine900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.wilayah,
                          style: const TextStyle(color: AppColors.textBody),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${PaketSeed.formatRupiah(item.harga)} ${isEnglish ? '/person' : item.satuan}',
                          style: const TextStyle(
                            color: AppColors.emerald600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onContinue,
                icon: const Icon(Icons.chat_rounded),
                label: Text(
                  isEnglish ? 'Continue to WhatsApp' : 'Lanjutkan ke WhatsApp',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.pine900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(minimumSize: const Size(120, 44)),
                child: Text(isEnglish ? 'Cancel' : 'Batal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
