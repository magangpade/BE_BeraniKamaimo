
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../detail_wisata/detail_wisata_screen.dart';
import '../home/user_shell.dart';

// Tab Destinasi — Figma MAGANG-PADE node 4258:1619
class DestinasiScreen extends StatefulWidget {
  const DestinasiScreen({super.key});

  @override
  State<DestinasiScreen> createState() => _DestinasiScreenState();
}

class _DestinasiScreenState extends State<DestinasiScreen> {
  int _filter = 0;
  String _query = '';

  static const _labels = ['Semua', 'Budaya', 'Bahari', 'UMKM', 'EKOWISATA'];

  static const _featured = _Item(
    // ponytail: badge "Pilihan terbaik" ter-bake di foto — ditutupi widget identik
    foto: 'assets/images/destinasi/feat_luk_panenteng.png',
    kabupaten: 'Banggai Kepulauan',
    nama: 'Luk Panenteng & Danau Paisu Pok',
    deskripsi:
        'Air sebening kaca dengan vegetasi hutan yang masih alami—ikon tersembunyi di Kepulauan Banggai.',
    rating: '4.9',
    jarak: '',
  );

  static const _cards = [
    _Item(
      // ponytail: badge kategori ter-bake di foto — ditutupi widget badge identik
      foto: 'assets/images/destinasi/card_togean.png',
      kategori: 'BAHARI',
      kabupaten: 'Tojo Una-Una',
      nama: 'Kepulauan Togean',
      deskripsi: 'Laguna jernih, terumbu karang, dan pulau sunyi dalam satu gugusan.',
      rating: '4.9',
      jarak: '375 km dari Palu',
    ),
    _Item(
      foto: 'assets/images/destinasi/card_tambing.png',
      kategori: 'EKOWISATA',
      kabupaten: 'Poso',
      nama: 'Danau Tambing',
      deskripsi: 'Danau pegunungan sejuk di jantung Taman Nasional Lore Lindu.',
      rating: '4.8',
      jarak: '90 km dari Palu',
    ),
    _Item(
      foto: 'assets/images/destinasi/card_saluopa.png',
      kategori: 'EKOWISATA',
      kabupaten: 'Poso',
      nama: 'Air Terjun Saluopa',
      deskripsi: 'Dua belas tingkat air terjun alami dengan jalur teduh yang mudah dijelajahi.',
      rating: '4.8',
      jarak: '265 km dari Palu',
    ),
    _Item(
      foto: 'assets/images/destinasi/card_bada.png',
      kategori: 'BUDAYA',
      kabupaten: 'Lore Selatan, Poso',
      nama: 'Lembah Bada',
      deskripsi: 'Bentang lembah megah dengan arca batu purba berusia ribuan tahun.',
      rating: '4.7',
      jarak: '177 km dari Palu',
    ),
    _Item(
      foto: 'assets/images/destinasi/card_pulo_dua.png',
      kategori: 'BAHARI',
      kabupaten: 'Banggai',
      nama: 'Pulo Dua Balantak',
      deskripsi: 'Perbukitan karst ikonik bertemu laut biru di ujung timur Sulawesi.',
      rating: '4.9',
      jarak: '610 km dari Palu',
    ),
  ];

  void _openDetail(_Item it) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => DetailWisataScreen(
        desaId: 1,
        namaDesa: it.nama,
        lokasi: it.kabupaten,
        foto: it.foto,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final shown = _cards
        .where((it) =>
            (_filter == 0 || it.kategori == _labels[_filter].toUpperCase()) &&
            (_query.isEmpty ||
                it.nama.toLowerCase().contains(_query) ||
                it.kabupaten.toLowerCase().contains(_query)))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        key: const Key('destinasiScroll'),
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
                  _DiscoveryHeader(
                    onChanged: (v) => setState(() =>
                        _query = v.trim().toLowerCase()),
                  ),
                  const SizedBox(height: 13),
                  _FilterChips(
                    selectedIndex: _filter,
                    onTap: (i) => setState(() => _filter = i),
                  ),
                  const _ResultsHeader(),
                  if (_filter == 0) ...[
                    _FeaturedCard(
                      item: _featured,
                      onTap: () => _openDetail(_featured),
                    ),
                    const SizedBox(height: 14),
                  ],
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
                        'Belum ada destinasi untuk filter ini',
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
                final it = shown[i];
                return _DestinasiCard(item: it, onTap: () => _openDetail(it));
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

// ─── Data seed ────────────────────────────────────────────────────────────────

class _Item {
  final String foto;
  final String kategori;
  final String kabupaten;
  final String nama;
  final String deskripsi;
  final String rating;
  final String jarak;

  const _Item({
    required this.foto,
    this.kategori = '',
    required this.kabupaten,
    required this.nama,
    required this.deskripsi,
    required this.rating,
    required this.jarak,
  });
}

// ─── Panel mint: judul + search ───────────────────────────────────────────────

class _DiscoveryHeader extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _DiscoveryHeader({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFECFDF5),
                Color(0xFFF2F4EE),
                Color(0xFFFFFFFF),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Destinasi Wisata',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine900,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Jelajahi destinasi pilihan dari pesisir, danau, hingga lembah megalitikum.',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBody,
                  height: 1.4,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(height: 13),
              Container(
                height: 46,
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        size: 18, color: AppColors.textTertiary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: onChanged,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: 'Cari destinasi atau kabupaten...',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          right: -12,
          top: -26,
          child: _Glow(),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: const BoxDecoration(
        color: Color(0x40B7E4C7),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _FilterChips({required this.selectedIndex, required this.onTap});

  static const _labels = ['Semua', 'Budaya', 'Bahari', 'UMKM', 'EKOWISATA'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final active = i == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: active ? AppColors.pine700 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: active ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                _labels[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                  color: active ? Colors.white : AppColors.pine900,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Judul section ────────────────────────────────────────────────────────────

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 14, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_rounded,
                  size: 13, color: AppColors.warning),
              SizedBox(width: 6),
              Text(
                'PILIHAN TERBAIK',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine500,
                  letterSpacing: 0.8,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Wisata Unggulan Sulteng',
            style: TextStyle(
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

// ─── Kartu featured ───────────────────────────────────────────────────────────

class _FeaturedCard extends StatelessWidget {
  final _Item item;
  final VoidCallback onTap;

  const _FeaturedCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppColors.shadowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Media 398×218
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: SizedBox(
              height: 218,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.foto, fit: BoxFit.cover),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      height: 23,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.93),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome_rounded,
                              size: 10, color: AppColors.warning),
                          SizedBox(width: 4),
                          Text(
                            'Pilihan terbaik',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Isi
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.place_rounded,
                        size: 11, color: AppColors.pine700),
                    const SizedBox(width: 3),
                    Text(
                      item.kabupaten,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine700,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star_rounded,
                        size: 11, color: AppColors.warning),
                    const SizedBox(width: 2),
                    Text(
                      item.rating,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine900,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                const Text(
                  'Luk Panenteng & Danau Paisu Pok',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Air sebening kaca dengan vegetasi hutan yang masih alami—ikon tersembunyi di Kepulauan Banggai.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                    height: 1.4,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waktu terbaik',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Apr–Okt • 2–3 hari',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.pine900,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 94,
                        height: 29,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.pine700,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        alignment: Alignment.center,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lihat detail',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.arrow_forward_rounded,
                                  size: 9, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Kartu destinasi baris ────────────────────────────────────────────────────

class _DestinasiCard extends StatelessWidget {
  final _Item item;
  final VoidCallback onTap;

  const _DestinasiCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppColors.shadowCard,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail 116×126 + badge kategori
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 116,
                  height: 126,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(item.foto, fit: BoxFit.cover),
                      Positioned(
                        left: 8,
                        top: 8,
                        child: Container(
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            item.kategori,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                              color: AppColors.pine700,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Isi
              Expanded(
                child: SizedBox(
                  height: 126,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.place_rounded,
                              size: 10, color: AppColors.pine700),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              item.kabupaten,
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
                      const SizedBox(height: 4),
                      Text(
                        item.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.deskripsi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBody,
                          height: 1.5,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 9, color: AppColors.warning),
                          const SizedBox(width: 2),
                          Text(
                            item.rating,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.pine900,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item.jarak,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textTertiary,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
