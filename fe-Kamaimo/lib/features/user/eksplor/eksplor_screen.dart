import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/hotel_repository.dart';
import '../../../data/repositories/kuliner_repository.dart';
import '../home/user_shell.dart';
import 'eksplor_data.dart';
import 'widgets/eksplor_header.dart';
import 'widgets/hotel_card.dart';
import 'widgets/kuliner_card.dart';
import 'widgets/trust_card.dart';

/// Tab Eksplor — "Katalog Wisata & Kuliner" (Tempat Menginap / Kuliner Khas)
/// Terhubung langsung dengan REST API Backend & fallback ke data seed lokal.
class EksplorScreen extends StatefulWidget {
  const EksplorScreen({super.key});

  @override
  State<EksplorScreen> createState() => _EksplorScreenState();
}

class _EksplorScreenState extends State<EksplorScreen> {
  final _search = TextEditingController();
  final _page = PageController(viewportFraction: 0.85);

  int _tab = 0; // 0 = Tempat Menginap | 1 = Kuliner Khas
  int _wilayah = 0;
  String _query = '';

  List<HotelItem> _allHotels = EksplorSeed.hotel;
  List<KulinerItem> _allKuliners = EksplorSeed.kuliner;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  @override
  void dispose() {
    _search.dispose();
    _page.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() => _loading = true);
    try {
      final hotelRepo = context.read<HotelRepository>();
      final hotels = await hotelRepo.getAll();
      if (hotels.isNotEmpty && mounted) {
        setState(() {
          _allHotels = hotels.map((h) => HotelItem.fromModel(h)).toList();
        });
      }
    } catch (_) {}

    try {
      final kulinerRepo = context.read<KulinerRepository>();
      final kuliners = await kulinerRepo.getAll();
      if (kuliners.isNotEmpty && mounted) {
        setState(() {
          _allKuliners = kuliners.map((k) => KulinerItem.fromModel(k)).toList();
        });
      }
    } catch (_) {}

    if (mounted) setState(() => _loading = false);
  }

  List<HotelItem> get _hotels {
    final q = _query.trim().toLowerCase();
    final targetWilayah = EksplorSeed.wilayah[_wilayah].toLowerCase();

    return _allHotels.where((h) {
      final cocokWilayah = _wilayah == 0 ||
          h.wilayah.toLowerCase().contains(targetWilayah) ||
          targetWilayah.contains(h.wilayah.toLowerCase()) ||
          h.lokasi.toLowerCase().contains(targetWilayah);

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
    final targetWilayah = EksplorSeed.wilayah[_wilayah].toLowerCase();

    return _allKuliners.where((k) {
      final cocokWilayah = _wilayah == 0 ||
          k.wilayah.toLowerCase().contains(targetWilayah) ||
          targetWilayah.contains(k.wilayah.toLowerCase()) ||
          k.warung.toLowerCase().contains(targetWilayah);

      final cocokQuery = q.isEmpty ||
          k.nama.toLowerCase().contains(q) ||
          k.warung.toLowerCase().contains(q) ||
          k.wilayah.toLowerCase().contains(q) ||
          k.deskripsi.toLowerCase().contains(q);
      return cocokWilayah && cocokQuery;
    }).toList();
  }

  Future<void> _launchUrlStr(String url) async {
    if (url.trim().isEmpty) return;
    try {
      final uri = Uri.parse(url.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (_) {
      if (mounted) {
        final isEn = context.read<LanguageProvider>().isEnglish;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEn ? 'Could not open link: $url' : 'Tidak dapat membuka tautan: $url',
            ),
          ),
        );
      }
    }
  }

  void _onTeleponHotel(HotelItem item) {
    String phone = item.telepon.replaceAll(RegExp(r'[^0-9]'), '');
    if (phone.startsWith('0')) {
      phone = '62${phone.substring(1)}';
    }
    if (phone.isNotEmpty) {
      final waUrl = 'https://wa.me/$phone?text=${Uri.encodeComponent('Halo ${item.nama}, saya ingin menanyakan reservasi kamar.')}';
      _launchUrlStr(waUrl);
    } else {
      _launchUrlStr('https://maps.google.com/?q=${Uri.encodeComponent('${item.nama} ${item.lokasi}')}');
    }
  }

  void _onMapsHotel(HotelItem item) {
    if (item.linkGmaps.isNotEmpty && item.linkGmaps.startsWith('http')) {
      _launchUrlStr(item.linkGmaps);
    } else {
      _launchUrlStr('https://maps.google.com/?q=${Uri.encodeComponent('${item.nama} ${item.lokasi}')}');
    }
  }

  void _onWebsiteHotel(HotelItem item) {
    if (item.website.isNotEmpty && item.website.startsWith('http')) {
      _launchUrlStr(item.website);
    } else {
      _launchUrlStr('https://www.google.com/search?q=${Uri.encodeComponent('${item.nama} Sulawesi Tengah')}');
    }
  }

  void _onTeleponKuliner(KulinerItem item) {
    if (item.telepon.isNotEmpty) {
      String phone = item.telepon.replaceAll(RegExp(r'[^0-9]'), '');
      if (phone.startsWith('0')) phone = '62${phone.substring(1)}';
      _launchUrlStr('https://wa.me/$phone');
    } else if (item.linkGmaps.isNotEmpty && item.linkGmaps.startsWith('http')) {
      _launchUrlStr(item.linkGmaps);
    } else {
      _launchUrlStr('https://maps.google.com/?q=${Uri.encodeComponent('${item.warung} ${item.nama}')}');
    }
  }

  void _onMapsKuliner(KulinerItem item) {
    if (item.linkGmaps.isNotEmpty && item.linkGmaps.startsWith('http')) {
      _launchUrlStr(item.linkGmaps);
    } else {
      _launchUrlStr('https://maps.google.com/?q=${Uri.encodeComponent('${item.warung} ${item.nama}')}');
    }
  }

  void _onWebsiteKuliner(KulinerItem item) {
    _launchUrlStr('https://www.google.com/search?q=${Uri.encodeComponent('Resep dan Rekomendasi ${item.nama} ${item.warung}')}');
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
            delegate: KamaimoBarDelegate(showToggle: true),
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
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final isHotel = _tab == 0;
    final jumlah = isHotel ? _hotels.length : _kuliners.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isHotel) ..._gastronomi(isEn),
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
                    ? (isEn
                        ? 'VERIFIED ACCOMMODATIONS ($jumlah)'
                        : 'AKOMODASI TERVERIFIKASI ($jumlah)')
                    : (isEn
                        ? 'VERIFIED LOCAL CULINARY ($jumlah)'
                        : 'KULINER KHAS TERVERIFIKASI ($jumlah)'),
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine800,
                  letterSpacing: 0.4,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              if (_loading) ...[
                const SizedBox(width: 8),
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.pine700),
                ),
              ],
            ],
          ),
          const SizedBox(height: 3),
          Text(
            isHotel
                ? (isEn ? 'Best Places to Stay' : 'Pilihan Penginapan Terbaik')
                : (isEn ? 'Authentic Stalls & Flavors' : 'Warung & Rasa Otentik'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.pine900,
              letterSpacing: -0.45,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 3),
          Text(
            isHotel
                ? (isEn
                    ? 'Beach resorts, star-rated hotels, and guesthouses near tourist spots'
                    : 'Resor pantai, hotel bintang, hingga guesthouse dekat spot wisata')
                : (isEn
                    ? 'Signature Central Sulawesi flavors crafted with authentic spices and fresh local ingredients'
                    : 'Cita rasa khas Sulawesi Tengah dengan rempah asli dan bahan segar lokal'),
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textBody,
              height: 1.45,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  List<Widget> _gastronomi(bool isEn) {
    return [
      Row(
        children: [
          const Icon(Icons.restaurant_menu_rounded,
              size: 13, color: AppColors.pine500),
          const SizedBox(width: 6),
          Text(
            isEn
                ? 'CENTRAL SULAWESI GASTRONOMY HERITAGE'
                : 'WARISAN GASTRONOMI SULTENG',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.pine500,
              letterSpacing: 0.4,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
      const SizedBox(height: 3),
      Text(
        isEn
            ? 'Authentic Kaili & Coastal Culinary'
            : 'Kuliner Otentik Kaili & Pesisir',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.pine900,
          letterSpacing: -0.45,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      const SizedBox(height: 3),
      Text(
        isEn
            ? 'From fresh Palu Bay sour fish soup and legendary Kaledo to trans-Sulawesi traditional delicacies'
            : 'Dari kuah asam segar Teluk Palu, kaledo legendaris, hingga jajanan pasar trans-Sulawesi',
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: AppColors.textBody,
          height: 1.45,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
      const SizedBox(height: 18),
    ];
  }

  Widget _trust() => const TrustCard();

  Widget _carousel() {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final isHotel = _tab == 0;
    final kosong = isHotel ? _hotels.isEmpty : _kuliners.isEmpty;

    if (kosong) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Text(
            isEn
                ? 'No catalog items found for this search'
                : 'Belum ada katalog untuk pencarian ini',
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

    final cards = <Widget>[];
    if (isHotel) {
      cards.addAll([
        for (final h in _hotels)
          HotelCard(
            item: h,
            onTelepon: _onTeleponHotel,
            onMaps: _onMapsHotel,
            onWebsite: _onWebsiteHotel,
          ),
      ]);
    } else {
      cards.addAll([
        for (final k in _kuliners)
          KulinerCard(
            item: k,
            onTelepon: _onTeleponKuliner,
            onMaps: _onMapsKuliner,
            onWebsite: _onWebsiteKuliner,
          ),
      ]);
    }

    return SizedBox(
      height: 640,
      child: PageView.builder(
        controller: _page,
        padEnds: false,
        itemCount: cards.length,
        itemBuilder: (ctx, i) => Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: i == cards.length - 1 ? 16 : 0,
          ),
          child: cards[i],
        ),
      ),
    );
  }
}
