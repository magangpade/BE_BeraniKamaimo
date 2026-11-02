import 'dart:ui';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants.dart';
import '../../../data/repositories/desa_wisata_repository.dart';
import '../../../data/repositories/gis_repository.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../../models/gis_marker.dart';
import '../../../models/weather.dart';
import '../event/detail_event_screen.dart';
import '../event/event_data.dart';

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../destinasi/destinasi_screen.dart';
import '../eksplor/eksplor_screen.dart';
import '../event/event_screen.dart';
import '../paket/paket_screen.dart';
import 'semua_destinasi_screen.dart';

/// Shell user: nav floating 5 tab + beranda, mengikuti Figma node 4273:55.
class UserShell extends StatefulWidget {
  static void switchTab(BuildContext context, int tabIndex) {
    final state = context.findAncestorStateOfType<_UserShellState>();
    state?.setTab(tabIndex);
  }
  const UserShell({super.key});

  @override
  State<UserShell> createState() => _UserShellState();
}

class _UserShellState extends State<UserShell> {
  int _currentIndex = 0;

  void setTab(int i) {
    if (mounted) setState(() => _currentIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          DestinasiScreen(),
          EventScreen(),
          PaketScreen(),
          EksplorScreen(),
        ],
      ),
      bottomNavigationBar: _FloatingBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

// ─── Floating Bottom Nav ──────────────────────────────────────────────────────

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingBottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    (icon: Icons.home_rounded, label: 'Beranda'),
    (icon: Icons.map_rounded, label: 'Destinasi'),
    (icon: Icons.event, label: 'Event'),
    (icon: Icons.receipt_long, label: 'Paket'),
    (icon: Icons.explore, label: 'Eksplor'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 70,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: AppColors.shadowFloating,
              ),
              child: Row(
                children: List.generate(_items.length, (i) {
                  final item = _items[i];
                  final active = i == currentIndex;
                  final color = active ? AppColors.pine800 : AppColors.textMuted;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(i),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: 19, color: color),
                          const SizedBox(height: 3),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                              color: color,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                          const SizedBox(height: 2),
                          if (active)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.pine800,
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Beranda ──────────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scroll,
        slivers: const [
          SliverPersistentHeader(
            pinned: true,
            delegate: KamaimoBarDelegate(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                _HeroSection(),
                SizedBox(height: 16),
                _QuickPills(),
                SizedBox(height: 24),
                _PetaSection(),
                SizedBox(height: 24),
                _UnggulanSection(),
                SizedBox(height: 28),
                _EventSection(),
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

// ─── Navbar (sticky, gaya kaca — dipakai beranda & destinasi) ─────────────────

class KamaimoBarDelegate extends SliverPersistentHeaderDelegate {
  final bool showToggle;

  const KamaimoBarDelegate({this.showToggle = true});

  @override
  double get minExtent => 76;
  @override
  double get maxExtent => 76;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 76,
          decoration: const BoxDecoration(
            color: Color(0x33F6F8F5),
            border: Border(bottom: BorderSide(color: Color(0xFFE7ECE6))),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _KamaimoLogoWidget(),
                  if (showToggle) const _LanguageToggle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(KamaimoBarDelegate old) => false;
}

class _KamaimoLogoWidget extends StatelessWidget {
  const _KamaimoLogoWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.pine600,
            borderRadius: BorderRadius.circular(8.4),
          ),
          child: const Icon(
            Icons.landscape_rounded,
            color: Colors.white,
            size: 23,
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BERANI',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.pine900,
                letterSpacing: 1.1,
                height: 1.2,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            Text(
              'KAMAIMO',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: AppColors.pine500,
                letterSpacing: 1.1,
                height: 1.2,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LanguageToggle extends StatefulWidget {
  const _LanguageToggle();

  @override
  State<_LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<_LanguageToggle> {
  String _lang = 'ID';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tab('ID'),
          const SizedBox(width: 3),
          _tab('EN'),
        ],
      ),
    );
  }

  Widget _tab(String label) {
    final active = _lang == label;
    return GestureDetector(
      onTap: () => setState(() => _lang = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: active ? AppColors.pine800 : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        alignment: Alignment.center,
        height: 36,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: active ? FontWeight.w700 : FontWeight.w600,
            color: active ? Colors.white : AppColors.textMuted,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Jelajahi Surga\nTersembunyi di\nJantung Sulawesi',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    height: 1.25,
                    letterSpacing: -0.65,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const _WeatherWidget(),
            ],
          ),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Temukan pesona bahari kristal, labirin karst megah,\ndan keagungan peradaban megalitikum tertua di\nNusantara.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textBody,
                height: 21.13 / 13,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _SearchBar(),
        ],
      ),
    );
  }
}

class _WeatherWidget extends StatefulWidget {
  const _WeatherWidget();

  @override
  State<_WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<_WeatherWidget> {
  WeatherInfo? _weather;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchWeather());
  }

  Future<void> _fetchWeather() async {
    try {
      final repo = context.read<WeatherRepository>();
      final data = await repo.getCurrentWeather(city: 'Palu');
      if (mounted) {
        setState(() {
          _weather = data;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tempStr = _weather != null ? '${_weather!.temp}°C' : '29°C';
    final descStr = _weather?.description ?? 'Cerah Berawan';
    final locationStr = _weather?.location ?? 'Palu';

    return Container(
      width: 96,
      constraints: const BoxConstraints(minHeight: 88),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _loading
                ? const Center(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(strokeWidth: 1.5),
                    ),
                  )
                : const Icon(
                    Icons.wb_sunny_rounded,
                    color: AppColors.warning,
                    size: 14,
                  ),
          ),
          const SizedBox(height: 4),
          Text(
            tempStr,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.pine900,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          Row(
            children: [
              const Icon(Icons.place_rounded, color: AppColors.pine500, size: 8),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  locationStr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ],
          ),
          Text(
            descStr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _ctrl = TextEditingController();

  // Kandidat A pintu admin: ketik kode rahasia di pencarian (PRD PRD §6.3)
  static const String _secretCode = 'adminBK2025'; // ponytail: pindah ke config saat M3

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onSubmit(String value) {
    if (value.trim() == _secretCode) {
      _ctrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mode admin: akan aktif di M3')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: AppColors.shadowCard,
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.textTertiary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _ctrl,
              onSubmitted: _onSubmit,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                fontFamily: 'PlusJakartaSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari destinasi atau kabupaten...',
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
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
    );
  }
}

// ─── Quick Pills ──────────────────────────────────────────────────────────────

class _QuickPills extends StatefulWidget {
  const _QuickPills();

  @override
  State<_QuickPills> createState() => _QuickPillsState();
}

class _QuickPillsState extends State<_QuickPills> {
  int _selected = 0;

  static const _pills = [
    (icon: Icons.grid_view_rounded, label: 'Semua'),
    (icon: Icons.phishing, label: 'Bahari & Karst'),
    (icon: Icons.account_balance_rounded, label: 'Megalitikum'),
    (icon: Icons.water_drop_rounded, label: 'Danau & Air Terjun'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _pills.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final active = i == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Container(
              height: 33,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: active ? AppColors.pine700 : Colors.white,
                borderRadius: BorderRadius.circular(9999),
                border: active ? null : Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _pills[i].icon,
                    size: 14,
                    color: active ? Colors.white : AppColors.pine500,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    _pills[i].label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                      color: active ? Colors.white : AppColors.pine900,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Peta Interaktif ──────────────────────────────────────────────────────────

class _PetaSection extends StatefulWidget {
  const _PetaSection();

  @override
  State<_PetaSection> createState() => _PetaSectionState();
}

class _PetaSectionState extends State<_PetaSection> {
  final MapController _mapController = MapController();
  int _selectedChip = 0;
  List<GisMarker> _markers = [];
  GisMarker? _selectedMarker;
  bool _loading = true;

  static const LatLng _sultengCenter = LatLng(-1.15, 121.45);
  static const double _defaultZoom = 6.5;

  static const _chipLabels = [
    'Semua',
    'Banggai',
    'Poso',
    'Togean / Tojo',
    'Palu & Sigi',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchMarkers());
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _fetchMarkers() async {
    try {
      final repo = context.read<GisRepository>();
      final list = await repo.getMarkers();
      if (mounted) {
        setState(() {
          _markers = list;
          _selectedMarker = list.isNotEmpty ? list.first : null;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<GisMarker> get _filteredMarkers {
    if (_selectedChip == 0) return _markers;
    final label = _chipLabels[_selectedChip].toLowerCase();
    return _markers.where((m) {
      final text = '${m.lokasi} ${m.nama}'.toLowerCase();
      if (label.contains('togean')) {
        return text.contains('togean') || text.contains('tojo') || text.contains('ampana');
      }
      if (label.contains('palu')) {
        return text.contains('palu') || text.contains('sigi') || text.contains('moutong') || text.contains('parigi');
      }
      return text.contains(label);
    }).toList();
  }

  void _onSelectChip(int i) {
    setState(() {
      _selectedChip = i;
      final filtered = _filteredMarkers;
      _selectedMarker = filtered.isNotEmpty
          ? filtered.first
          : (_markers.isNotEmpty ? _markers.first : null);
    });
    final filtered = _filteredMarkers;
    if (i == 0) {
      _mapController.move(_sultengCenter, _defaultZoom);
    } else if (filtered.isNotEmpty) {
      final first = filtered.first;
      _mapController.move(LatLng(first.lat, first.lng), 8.8);
    }
  }

  void _onSelectMarker(GisMarker m) {
    setState(() => _selectedMarker = m);
    _mapController.move(LatLng(m.lat, m.lng), 9.5);
  }

  Color _markerColor(GisMarker m) {
    if (m.type == 'atraksi' || m.kategori == 'EVENT') {
      return const Color(0xFFF59E0B);
    }
    if (m.kategori == 'DESA_UNGGULAN') {
      return const Color(0xFF10B981);
    }
    return const Color(0xFF3B82F6);
  }

  @override
  Widget build(BuildContext context) {
    final activeMarker = _selectedMarker;
    final filtered = _filteredMarkers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Peta Interaktif Wisata',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.pine900,
              letterSpacing: -0.45,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 27,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _chipLabels.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final active = i == _selectedChip;
              return GestureDetector(
                onTap: () => _onSelectChip(i),
                child: Container(
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: active ? AppColors.pine700 : Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    border: active ? null : Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _chipLabels[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : AppColors.pine900,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 340,
          decoration: BoxDecoration(
            color: AppColors.mapBackground,
            borderRadius: BorderRadius.circular(26),
            boxShadow: AppColors.shadowCard,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                // Peta Leaflet / OpenStreetMap asli berbasis koordinat GPS
                Positioned.fill(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: const MapOptions(
                      initialCenter: _sultengCenter,
                      initialZoom: _defaultZoom,
                      minZoom: 5.0,
                      maxZoom: 18.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.berani.kamaimo',
                      ),
                      if (!_loading)
                        MarkerLayer(
                          markers: filtered.map((m) {
                            final isSelected = m.id == activeMarker?.id;
                            final pinColor = _markerColor(m);
                            return Marker(
                              point: LatLng(m.lat, m.lng),
                              width: isSelected ? 44 : 34,
                              height: isSelected ? 44 : 34,
                              child: GestureDetector(
                                onTap: () => _onSelectMarker(m),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.pine700 : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? Colors.white : pinColor,
                                      width: isSelected ? 2.5 : 2.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.28),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    m.type == 'atraksi'
                                        ? Icons.event_rounded
                                        : Icons.location_on_rounded,
                                    size: isSelected ? 22 : 17,
                                    color: isSelected ? Colors.white : pinColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                // Pill Legenda Kategori di Kiri Atas
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _LegendDot(color: Color(0xFF10B981), label: 'Unggulan'),
                        SizedBox(width: 8),
                        _LegendDot(color: Color(0xFF3B82F6), label: 'Wisata Alam'),
                        SizedBox(width: 8),
                        _LegendDot(color: Color(0xFFF59E0B), label: 'Event / Budaya'),
                      ],
                    ),
                  ),
                ),
                // Tombol Kontrol Zoom (+ / - / Reset Tengah) di Kanan Atas
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    children: [
                      _MapControlButton(
                        icon: Icons.add_rounded,
                        onTap: () {
                          final cam = _mapController.camera;
                          _mapController.move(cam.center, (cam.zoom + 1).clamp(5.0, 18.0));
                        },
                      ),
                      const SizedBox(height: 6),
                      _MapControlButton(
                        icon: Icons.remove_rounded,
                        onTap: () {
                          final cam = _mapController.camera;
                          _mapController.move(cam.center, (cam.zoom - 1).clamp(5.0, 18.0));
                        },
                      ),
                      const SizedBox(height: 6),
                      _MapControlButton(
                        icon: Icons.my_location_rounded,
                        onTap: () {
                          _mapController.move(_sultengCenter, _defaultZoom);
                        },
                      ),
                    ],
                  ),
                ),
                // Kartu Info Lokasi Terpilih di Bawah Peta
                Positioned(
                  left: 11,
                  right: 11,
                  bottom: 10,
                  child: activeMarker != null
                      ? _DesaCard(marker: activeMarker)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            color: AppColors.pine900,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
      ],
    );
  }
}

class _MapControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 17, color: AppColors.pine900),
      ),
    );
  }
}

class _DesaCard extends StatelessWidget {
  final GisMarker marker;

  const _DesaCard({required this.marker});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.fromLTRB(12, 11, 11, 11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 56,
              height: 56,
              child: marker.foto != null && marker.foto!.isNotEmpty
                  ? (marker.foto!.startsWith('http')
                      ? Image.network(
                          marker.foto!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _placeholderThumb(),
                        )
                      : Image.asset(
                          marker.foto!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            'assets/images/beranda/thumb_luk_panenteng.png',
                            fit: BoxFit.cover,
                          ),
                        ))
                  : _placeholderThumb(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.emerald100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        marker.kategori.replaceAll('_', ' '),
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: AppColors.emerald600,
                          letterSpacing: 0.2,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.star_rounded, color: AppColors.warning, size: 11),
                    const SizedBox(width: 2),
                    Text(
                      marker.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  marker.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                Text(
                  '${marker.lokasi} (${marker.lat.toStringAsFixed(2)}, ${marker.lng.toStringAsFixed(2)})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (marker.type == 'atraksi') {
                final allSeed = [EventSeed.featured, ...EventSeed.agenda];
                final matches = allSeed.where((s) =>
                    s.nama.toLowerCase().contains(marker.nama.toLowerCase()) ||
                    marker.nama.toLowerCase().contains(s.nama.toLowerCase()));
                final targetEvent = matches.isNotEmpty
                    ? matches.first
                    : EventItem(
                        foto: marker.foto ?? 'assets/images/beranda/event_danau_poso.png',
                        kategori: 'BUDAYA',
                        lokasi: marker.lokasi,
                        wilayah: marker.lokasi,
                        nama: marker.nama,
                        deskripsi: 'Event budaya & pariwisata unggulan di ${marker.lokasi}.',
                        rentangTanggal: 'Segera Hadir',
                        start: DateTime.now().add(const Duration(days: 30)),
                      );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailEventScreen(event: targetEvent),
                  ),
                );
              } else {
                Navigator.pushNamed(
                  context,
                  AppConstants.routeDetailDesa,
                  arguments: {
                    'desaId': marker.refId,
                    'namaDesa': marker.nama,
                    'lokasi': marker.lokasi,
                    'foto': marker.foto ?? '',
                  },
                );
              }
            },
            child: Container(
              width: 62,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.pine700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Buka',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded, size: 9, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderThumb() {
    return Container(
      color: AppColors.emerald100,
      child: const Icon(Icons.terrain, color: AppColors.emerald600, size: 24),
    );
  }
}

// ─── Wisata Unggulan (cover-flow carousel) ────────────────────────────────────

class _WisataData {
  final int? id;
  final String? foto;
  final String badge;
  final Color? badgeColor;
  final String kabupaten;
  final String nama;
  final String deskripsi;
  final String labelHarga;
  final String harga;
  final String satuan;
  final String rating;
  final String ulasan;

  const _WisataData({
    this.id,
    this.foto,
    required this.badge,
    this.badgeColor,
    required this.kabupaten,
    required this.nama,
    required this.deskripsi,
    required this.labelHarga,
    required this.harga,
    required this.satuan,
    required this.rating,
    required this.ulasan,
  });
}

class _UnggulanSection extends StatefulWidget {
  const _UnggulanSection();

  @override
  State<_UnggulanSection> createState() => _UnggulanState();
}

class _UnggulanState extends State<_UnggulanSection> {
  final PageController _page = PageController(viewportFraction: 0.75);
  int _index = 0;
  List<_WisataData> _items = _defaultItems;

  static const _defaultItems = [
    _WisataData(
      id: 1,
      foto: 'assets/images/beranda/kartu_kolam_kaca.png',
      badge: 'KOLAM KACA',
      kabupaten: 'BANGGAI KEPULAUAN',
      nama: 'Luk Panenteng & Danau Paisu Pok',
      deskripsi: 'Air danau sejernih kaca dengan vegetasi hutan…',
      labelHarga: 'MULAI DARI',
      harga: 'Rp 15.000',
      satuan: '/orang',
      rating: '4.9',
      ulasan: '(1.4k ulasan)',
    ),
    _WisataData(
      id: 2,
      foto: 'assets/images/beranda/kartu_sombori.png',
      badge: 'THE SECRET PARADISE',
      badgeColor: AppColors.orangeBadge,
      kabupaten: 'MOROWALI',
      nama: 'Kepulauan Sombori',
      deskripsi: 'Karst megah, tebing cadas, & laguna toska.',
      labelHarga: 'PAKET TUR',
      harga: 'Rp 350.000',
      satuan: '/tur',
      rating: '4.95',
      ulasan: '',
    ),
    _WisataData(
      id: 3,
      badge: 'PASIR EMAS TENTENA',
      kabupaten: 'POSO • TENTENA',
      nama: 'Danau Poso & Pasir Emas',
      deskripsi: 'Danau purba ketiga terbesar dengan pasir…',
      labelHarga: 'MULAI DARI',
      harga: 'Rp 10.000',
      satuan: '/orang',
      rating: '4.88',
      ulasan: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchDesa());
  }

  Future<void> _fetchDesa() async {
    try {
      final repo = context.read<DesaWisataRepository>();
      final list = await repo.getAll();
      if (list.isNotEmpty && mounted) {
        setState(() {
          _items = list.map((d) => _WisataData(
            id: d.id,
            foto: d.foto,
            badge: d.jenisDesa == 'DESA_UNGGULAN' ? 'UNGGULAN' : 'WISATA',
            kabupaten: d.lokasi_id.toUpperCase(),
            nama: d.namaDesa_id,
            deskripsi: d.deskripsi_id,
            labelHarga: 'MULAI DARI',
            harga: 'Rp 15.000',
            satuan: '/orang',
            rating: d.rating,
            ulasan: '(${d.total_ulasan} ulasan)',
          )).toList();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
              SizedBox(width: 6),
              Text(
                'PILIHAN TERBAIK',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine500,
                  letterSpacing: 0.4,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Wisata Unggulan Sulteng',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine900,
                  letterSpacing: -0.45,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SemuaDestinasiScreen()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Semua',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine700,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, size: 13, color: AppColors.pine700),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 448,
          child: PageView.builder(
            controller: _page,
            itemCount: _items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _CarouselCard(item: _items[i], active: i == _index),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_items.length, (i) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: i == _index ? AppColors.pine700 : AppColors.border,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final _WisataData item;
  final bool active;

  const _CarouselCard({required this.item, required this.active});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppConstants.routeDetailDesa,
          arguments: {
            'desaId': item.id ?? 1,
            'namaDesa': item.nama,
            'lokasi': item.kabupaten,
            'foto': item.foto ?? '',
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: AppColors.shadowCard,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              // Foto area 144dp
              SizedBox(
                height: 144,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: item.foto != null
                          ? Image.asset(item.foto!, fit: BoxFit.cover)
                          : const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF9ECAA3), Color(0xFF35644A)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                    ),
                    // Badge (menutup badge yang ter-bake di foto kartu pertama)
                    Positioned(
                      left: 14,
                      top: 14,
                      child: Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: item.badgeColor != null
                              ? item.badgeColor!.withValues(alpha: 0.9)
                              : Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          item.badge,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: item.badgeColor != null ? Colors.white : AppColors.pine700,
                            letterSpacing: 0.2,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                    ),
                    // Rating chip menutup chip ter-bake
                    Positioned(
                      left: 14,
                      bottom: 14,
                      child: Container(
                        height: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.warning, size: 12),
                            const SizedBox(width: 3),
                            Text(
                              item.rating,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            if (item.ulasan.isNotEmpty) ...[
                              const SizedBox(width: 4),
                              Text(
                                item.ulasan,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontFamily: 'PlusJakartaSans',
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Info area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.kabupaten,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine500,
                          letterSpacing: 0.3,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine900,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.deskripsi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBody,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 1,
                        color: AppColors.divider,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.labelHarga,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textTertiary,
                                    letterSpacing: 0.4,
                                    fontFamily: 'PlusJakartaSans',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      item.harga,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.pine700,
                                        fontFamily: 'PlusJakartaSans',
                                      ),
                                    ),
                                    Text(
                                      item.satuan,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textTertiary,
                                        fontFamily: 'PlusJakartaSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          _cardButton(context),
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

  Widget _cardButton(BuildContext context) {
    if (active) {
      // Tombol kartu aktif: pill gelap "Detail →" (87×28)
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppConstants.routeDetailDesa,
            arguments: {
              'desaId': item.id ?? 1,
              'namaDesa': item.nama,
              'lokasi': item.kabupaten,
              'foto': item.foto ?? '',
            },
          );
        },
        child: Container(
          width: 87,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.pine700,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Detail',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              Icon(Icons.arrow_forward_rounded, size: 9, color: Colors.white),
            ],
          ),
        ),
      );
    }
    // Kartu tidak aktif: pill abu "Info Detail"
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppConstants.routeDetailDesa,
          arguments: {
            'desaId': item.id ?? 1,
            'namaDesa': item.nama,
            'lokasi': item.kabupaten,
            'foto': item.foto ?? '',
          },
        );
      },
      child: Container(
        width: 82,
        height: 29,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariantSoft,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: const Center(
          child: Text(
            'Info Detail',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.pine900,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Atraksi & Event ─────────────────────────────────────────────────────────

class _EventData {
  final String foto;
  final String tanggal;
  final String countdown;
  final String lokasi;
  final String nama;
  final String deskripsi;

  const _EventData({
    required this.foto,
    required this.tanggal,
    required this.countdown,
    required this.lokasi,
    required this.nama,
    required this.deskripsi,
  });
}

class _EventSection extends StatelessWidget {
  const _EventSection();

  static const _events = [
    _EventData(
      foto: 'assets/images/beranda/thumb_event1.png',
      tanggal: '24 OKT',
      countdown: 'H-45 Hari',
      lokasi: 'Tentena, Poso',
      nama: 'Festival Danau Poso ke-24',
      deskripsi: 'Parade budaya, tari mogele, & lomba perahu naga.',
    ),
    _EventData(
      foto: 'assets/images/beranda/thumb_event2.png',
      tanggal: '18 NOV',
      countdown: 'H-45 Hari',
      lokasi: 'Parigi Moutong',
      nama: 'Festival Teluk Tomini (FTT)',
      deskripsi: 'Eksplorasi bawah laut, karnaval kostum bahari & expo UMKM.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.event_available_rounded, color: AppColors.pine500, size: 14),
              SizedBox(width: 6),
              Text(
                'KARISMA EVENT NUSANTARA 2025',
                style: TextStyle(
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
          Row(
            children: [
              const Text(
                'Atraksi & Event Budaya',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine900,
                  letterSpacing: -0.45,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  UserShell.switchTab(context, 2);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Semua',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine700,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Icon(Icons.arrow_forward_rounded, size: 13, color: AppColors.pine700),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._events.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _EventCard(event: e),
              )),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final _EventData event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 101,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: AppColors.shadowCard,
      ),
      padding: const EdgeInsets.all(11),
      child: Row(
        children: [
          // Thumbnail + tanggal (56×64)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 56,
              height: 64,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(event.foto, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      color: AppColors.pine700,
                      alignment: Alignment.center,
                      child: Text(
                        event.tanggal,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.3,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.goldChipBg,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.goldChipBorder),
                      ),
                      child: Text(
                        event.countdown,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: AppColors.goldChipText,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event.lokasi,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.pine500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  event.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.deskripsi,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                    height: 1.4,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              final allSeed = [EventSeed.featured, ...EventSeed.agenda];
              final matches = allSeed.where((s) =>
                s.nama.toLowerCase().contains(event.nama.toLowerCase()) ||
                event.nama.toLowerCase().contains(s.nama.toLowerCase()));
              final targetEvent = matches.isNotEmpty
                  ? matches.first
                  : EventItem(
                      foto: event.foto,
                      kategori: 'BUDAYA',
                      lokasi: event.lokasi,
                      wilayah: event.lokasi,
                      nama: event.nama,
                      deskripsi: event.deskripsi,
                      rentangTanggal: event.tanggal,
                      start: DateTime.now().add(const Duration(days: 45)),
                    );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailEventScreen(event: targetEvent),
                ),
              );
            },
            child: Container(
              width: 66,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Detail',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────────

/// Ketinggian yang pas supaya footer tidak tertutup nav floating, dan sisa
/// bawah halaman kosong agar nav pill berdiri sendiri.
class KamaimoNavClearance extends StatelessWidget {
  const KamaimoNavClearance({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.paddingOf(context).bottom;
    return SizedBox(height: inset + 92);
  }
}

class KamaimoFooter extends StatelessWidget {
  const KamaimoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const links = ['Hotel & Penginapan', 'Kuliner Khas', 'Paket Wisata', 'Hubungi Kami'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.eco_rounded, color: AppColors.pine700, size: 16),
                SizedBox(width: 6),
                Text(
                  'Dinas Pariwisata Provinsi Sulawesi Tengah',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine700,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Berani Kamaimo • Gerakan Wisata Berkelanjutan & Ekraf Sulteng',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textBody,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 6,
            children: [
              for (var i = 0; i < links.length; i++) ...[
                if (i > 0)
                  const Text(
                    '•',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.pine500,
                    ),
                  ),
                Text(
                  links[i],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine500,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialCircle(icon: Icons.camera_alt_rounded),
              SizedBox(width: 12),
              _SocialCircle(icon: Icons.play_circle_rounded),
              SizedBox(width: 12),
              _SocialCircle(icon: Icons.public_rounded),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '© 2026 Dinas Pariwisata Sulawesi Tengah. Hak Cipta Dilindungi.',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  final IconData icon;
  const _SocialCircle({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, color: AppColors.pine500, size: 15),
    );
  }
}
