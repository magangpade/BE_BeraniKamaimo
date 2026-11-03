import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../detail_wisata/detail_wisata_screen.dart';

/// Halaman Semua Destinasi (Grid List) — sesuai Figma
class SemuaDestinasiScreen extends StatefulWidget {
  const SemuaDestinasiScreen({super.key});

  @override
  State<SemuaDestinasiScreen> createState() => _SemuaDestinasiScreenState();
}

class _SemuaDestinasiScreenState extends State<SemuaDestinasiScreen> {
  String _selectedFilter = 'Semua';
  final _filters = [
    'Semua',
    'Bahari & Karst',
    'Megalitikum',
    'Budaya & Adat',
    'Kuliner Khas',
  ];

  // Mock data destinasi
  final _destinations = [
    {
      'id': 1,
      'kabupaten': 'BANGGAI KEPULAUAN',
      'nama': 'Kepulauan Sombori',
      'badge': 'THE SECRET PARADISE',
      'rating': '4.95',
      'ulasan': '930 ulasan',
      'harga': 'Rp 350.000',
      'satuan': '/tur',
      'jenis': 'Bahari & Karst',
    },
    {
      'id': 2,
      'kabupaten': 'POSO • TENTENA',
      'nama': 'Danau Poso & Pasir Emas',
      'badge': 'PASIR EMAS TENTENA',
      'rating': '4.88',
      'ulasan': '2.1k ulasan',
      'harga': 'Rp 10.000',
      'satuan': '/orang',
      'jenis': 'Bahari & Karst',
    },
    {
      'id': 3,
      'kabupaten': 'MOROWALI',
      'nama': 'Lembah Bada & Besoa',
      'badge': 'PESONA LEMBAH',
      'rating': '4.92',
      'ulasan': '1.2k ulasan',
      'harga': 'Rp 75.000',
      'satuan': '/paket',
      'jenis': 'Megalitikum',
    },
    {
      'id': 4,
      'kabupaten': 'BANGGAI KEPULAUAN',
      'nama': 'Danau Paisu Pok',
      'badge': 'KOLAM KACA',
      'rating': '4.9',
      'ulasan': '1.4k ulasan',
      'harga': 'Rp 15.000',
      'satuan': '/orang',
      'jenis': 'Bahari & Karst',
    },
    {
      'id': 5,
      'kabupaten': 'POSO',
      'nama': 'Saluopa Waterfall',
      'badge': 'AIR TERJUN 7 LAPISAN',
      'rating': '4.85',
      'ulasan': '890 ulasan',
      'harga': 'Rp 5.000',
      'satuan': '/orang',
      'jenis': 'Bahari & Karst',
    },
    {
      'id': 6,
      'kabupaten': 'TOJO UNA-UNA',
      'nama': 'Togean Islands',
      'badge': 'SURGA SELAM',
      'rating': '4.98',
      'ulasan': '2.3k ulasan',
      'harga': 'Rp 500.000',
      'satuan': '/paket',
      'jenis': 'Bahari & Karst',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDestinations = _selectedFilter == 'Semua'
        ? _destinations
        : _destinations.where((d) => d['jenis'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header Sticky
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(
              selectedFilter: _selectedFilter,
              onFilterChanged: (f) => setState(() => _selectedFilter = f),
              filters: _filters,
            ),
          ),

          // Grid List
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan count
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Text(
                    '${filteredDestinations.length} Destinasi Ditemukan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                // Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                    itemCount: filteredDestinations.length,
                    itemBuilder: (ctx, i) {
                      final item = filteredDestinations[i];
                      return _DestinationGridCard(
                        item: item,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailWisataScreen(
                              desaId: item['id'] as int,
                              namaDesa: item['nama'] as String,
                              lokasi: item['kabupaten'] as String,
                              foto: '',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 100), // padding untuk floating nav
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;
  final List<String> filters;

  _SearchHeaderDelegate({
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.filters,
  });

  @override
  double get minExtent => 140;
  @override
  double get maxExtent => 140;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isBlurred = shrinkOffset > 4;
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: isBlurred ? Colors.white.withValues(alpha: 0.9) : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isBlurred ? Colors.white.withValues(alpha: 0.3) : AppColors.border,
            width: 1.5,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Search Bar
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.pine700.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Cari destinasi...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textTertiary,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: AppColors.pine700,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Filter pills
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final filter = filters[i];
                    final active = filter == selectedFilter;
                    return GestureDetector(
                      onTap: () => onFilterChanged(filter),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: active ? AppColors.pine700 : Colors.white,
                          borderRadius: BorderRadius.circular(9999),
                          border: active
                              ? null
                              : Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: active
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: active ? Colors.white : AppColors.pine900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchHeaderDelegate old) => false;
}

class _DestinationGridCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _DestinationGridCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: const [
            BoxShadow(
              color: Color(0x141D3A30),
              blurRadius: 24,
              offset: Offset(0, 8),
              spreadRadius: -4,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: AppColors.pine500.withValues(alpha: 0.2),
                    child: const Center(
                      child: Icon(
                        Icons.landscape,
                        size: 32,
                        color: AppColors.pine500,
                      ),
                    ),
                  ),
                  // Gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        item['badge'] as String,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pine700,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                  ),
                  // Rating
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 10,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            item['rating'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Bookmark
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kabupaten
                    Text(
                      item['kabupaten'] as String,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pine500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Nama
                    Text(
                      item['nama'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pine900,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          item['rating'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pine900,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '(${item['ulasan']})',
                          style: const TextStyle(
                            fontSize: 8,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Price
                    Row(
                      children: [
                        Text(
                          item['harga'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pine700,
                          ),
                        ),
                        Text(
                          item['satuan'] as String,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.textTertiary,
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
    );
  }
}
