import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/desa_wisata_repository.dart';
import '../detail_wisata/detail_wisata_screen.dart';

/// Halaman Semua Destinasi (Grid List) — sesuai Figma
class SemuaDestinasiScreen extends StatefulWidget {
  final String? initialQuery;
  final String? initialFilter;

  const SemuaDestinasiScreen({
    super.key,
    this.initialQuery,
    this.initialFilter,
  });

  @override
  State<SemuaDestinasiScreen> createState() => _SemuaDestinasiScreenState();
}

class _SemuaDestinasiScreenState extends State<SemuaDestinasiScreen> {
  late String _selectedFilter;
  late String _query;
  late TextEditingController _searchCtrl;

  final _filters = [
    'Semua',
    'Bahari & Karst',
    'Megalitikum',
    'Budaya & Adat',
    'Danau & Alam',
  ];

  static const _defaultDestinations = [
    {
      'id': 1,
      'kabupaten': 'BANGGAI KEPULAUAN',
      'nama': 'Luk Panenteng & Danau Paisu Pok',
      'badge': 'UNGGULAN SULTENG',
      'rating': '4.95',
      'ulasan': '1.4k ulasan',
      'harga': 'Rp 15.000',
      'satuan': '/orang',
      'jenis': 'Danau & Alam',
      'foto': 'assets/images/destinasi/feat_luk_panenteng.png',
    },
    {
      'id': 2,
      'kabupaten': 'TOJO UNA-UNA',
      'nama': 'Kepulauan Togean',
      'badge': 'BAHARI',
      'rating': '4.90',
      'ulasan': '2.3k ulasan',
      'harga': 'Rp 350.000',
      'satuan': '/tur',
      'jenis': 'Bahari & Karst',
      'foto': 'assets/images/destinasi/card_togean.png',
    },
    {
      'id': 3,
      'kabupaten': 'POSO',
      'nama': 'Danau Tambing',
      'badge': 'EKOWISATA',
      'rating': '4.80',
      'ulasan': '890 ulasan',
      'harga': 'Rp 10.000',
      'satuan': '/orang',
      'jenis': 'Danau & Alam',
      'foto': 'assets/images/destinasi/card_tambing.png',
    },
    {
      'id': 4,
      'kabupaten': 'POSO',
      'nama': 'Air Terjun Saluopa',
      'badge': 'EKOWISATA',
      'rating': '4.80',
      'ulasan': '870 ulasan',
      'harga': 'Rp 15.000',
      'satuan': '/orang',
      'jenis': 'Danau & Alam',
      'foto': 'assets/images/destinasi/card_saluopa.png',
    },
    {
      'id': 5,
      'kabupaten': 'LORE SELATAN, POSO',
      'nama': 'Lembah Bada',
      'badge': 'BUDAYA',
      'rating': '4.70',
      'ulasan': '1.2k ulasan',
      'harga': 'Rp 25.000',
      'satuan': '/orang',
      'jenis': 'Megalitikum',
      'foto': 'assets/images/destinasi/card_bada.png',
    },
    {
      'id': 6,
      'kabupaten': 'BANGGAI',
      'nama': 'Pulo Dua Balantak',
      'badge': 'BAHARI',
      'rating': '4.90',
      'ulasan': '950 ulasan',
      'harga': 'Rp 20.000',
      'satuan': '/orang',
      'jenis': 'Bahari & Karst',
      'foto': 'assets/images/destinasi/card_pulo_dua.png',
    },
  ];

  List<Map<String, dynamic>> _destinations = _defaultDestinations;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter ?? 'Semua';
    _query = widget.initialQuery ?? '';
    _searchCtrl = TextEditingController(text: _query);
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchDestinasi());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _fetchDestinasi() async {
    try {
      final repo = context.read<DesaWisataRepository>();
      final list = await repo.getAll();
      if (list.isNotEmpty && mounted) {
        setState(() {
          _destinations = list.map((d) {
            String jenis = 'Bahari & Karst';
            if (d.kategori == 'BUDAYA') jenis = 'Budaya & Adat';
            if (d.kategori == 'MEGALITIKUM') jenis = 'Megalitikum';
            if (d.kategori == 'EKOWISATA') jenis = 'Danau & Alam';

            return {
              'id': d.id,
              'kabupaten': d.lokasi_id.toUpperCase(),
              'nama': d.namaDesa_id,
              'badge': d.jenisDesa == 'DESA_UNGGULAN' ? 'UNGGULAN SULTENG' : d.kategori,
              'rating': d.rating,
              'ulasan': '${d.total_ulasan} ulasan',
              'harga': 'Rp 15.000',
              'satuan': '/orang',
              'jenis': jenis,
              'foto': d.foto ?? 'assets/images/destinasi/card_togean.png',
            };
          }).toList();
        });
      }
    } catch (_) {}
  }

  List<Map<String, dynamic>> get filteredDestinations {
    final q = _query.trim().toLowerCase();
    return _destinations.where((d) {
      final matchesFilter = _selectedFilter == 'Semua' ||
          (d['jenis'] as String).toLowerCase() == _selectedFilter.toLowerCase();
      final matchesSearch = q.isEmpty ||
          (d['nama'] as String).toLowerCase().contains(q) ||
          (d['kabupaten'] as String).toLowerCase().contains(q);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredDestinations;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            backgroundColor: AppColors.surface,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.pine900,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Semua Destinasi',
              style: TextStyle(
                color: AppColors.pine900,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            centerTitle: true,
          ),

          // Search & Filter Header (Sticky)
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(
              selectedFilter: _selectedFilter,
              onFilterChanged: (filter) {
                setState(() => _selectedFilter = filter);
              },
              filters: _filters,
              searchController: _searchCtrl,
              onSearchChanged: (v) {
                setState(() => _query = v);
              },
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Count
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Text(
                    '${items.length} Destinasi Ditemukan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),

                // Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: items.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'Tidak ada destinasi yang cocok',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: items.length,
                          itemBuilder: (ctx, i) {
                            final item = items[i];
                            return _DestinationGridCard(
                              item: item,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailWisataScreen(
                                    desaId: item['id'] as int,
                                    namaDesa: item['nama'] as String,
                                    lokasi: item['kabupaten'] as String,
                                    foto: (item['foto'] as String?) ?? '',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 100),
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
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  _SearchHeaderDelegate({
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.filters,
    required this.searchController,
    required this.onSearchChanged,
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
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: onSearchChanged,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontFamily: 'PlusJakartaSans',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          filled: false,
                          fillColor: Colors.transparent,
                          hintText: 'Cari destinasi...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.textTertiary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Filter Pills
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (ctx, i) {
                    final filter = filters[i];
                    final isSelected = filter == selectedFilter;

                    return GestureDetector(
                      onTap: () => onFilterChanged(filter),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.pine700
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.pine700
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontFamily: 'PlusJakartaSans',
                            ),
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
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) {
    return oldDelegate.selectedFilter != selectedFilter ||
        oldDelegate.filters != filters ||
        oldDelegate.searchController != searchController;
  }
}

class _DestinationGridCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _DestinationGridCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foto = item['foto'] as String?;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.pine700.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badge
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    color: AppColors.surfaceVariant,
                    child: (foto != null && foto.isNotEmpty)
                        ? Image.asset(
                            foto,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.landscape_rounded,
                              size: 40,
                              color: AppColors.pine500,
                            ),
                          )
                        : const Icon(
                            Icons.landscape_rounded,
                            size: 40,
                            color: AppColors.pine500,
                          ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item['badge'] as String,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine700,
                          letterSpacing: 0.5,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['kabupaten'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.emerald600,
                            letterSpacing: 0.5,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['nama'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.pine900,
                            height: 1.2,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'MULAI DARI',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textTertiary,
                                letterSpacing: 0.5,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  item['harga'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.pine700,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                                Text(
                                  item['satuan'] as String,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: AppColors.textTertiary,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.pine700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: Colors.white,
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
