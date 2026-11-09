import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/token_store.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/jarak_repository.dart';
import '../../../data/repositories/ulasan_repository.dart';
import '../../../models/jarak_desa.dart';
import '../../../models/ulasan.dart';
import 'widgets/destinasi_share_sheet.dart';
import 'widgets/detail_hero.dart';
import 'widgets/fasilitas_section.dart';
import 'widgets/how_to_get_there.dart';
import 'widgets/review_form.dart';
import 'widgets/ulasan_section.dart';

/// Halaman Detail Wisata — sesuai Figma frame 4714:452
/// "Detail Wisata - Luk Panenteng (Modern)".
///
/// Dibuka dari klik kartu destinasi (beranda / destinasi / semua destinasi).
/// Argumen dibawa lewat `Navigator.pushNamed(routeDetailDesa, arguments: {...})`
/// atau langsung `DetailWisataScreen(...)`.
class DetailWisataScreen extends StatefulWidget {
  final int desaId;
  final String namaDesa;
  final String lokasi;
  final String foto;
  final String deskripsi;

  /// Injeksi loader untuk pengujian; default = fetch via repository.
  final Future<List<JarakDesa>> Function()? jarakLoader;
  final Future<List<Ulasan>> Function()? ulasanLoader;

  const DetailWisataScreen({
    super.key,
    required this.desaId,
    required this.namaDesa,
    required this.lokasi,
    required this.foto,
    this.deskripsi = '',
    this.jarakLoader,
    this.ulasanLoader,
  });

  @override
  State<DetailWisataScreen> createState() => _DetailWisataScreenState();
}

class _DetailWisataScreenState extends State<DetailWisataScreen> {
  /// Pill status buka = placeholder statis sesuai Figma
  /// (backend belum punya field jam buka per desa).
  static const String _statusBuka =
      'Buka Hari Ini \u2022 07:00 \u2013 17:30 WITA';

  late final Future<List<JarakDesa>> _jarakFuture;
  late final Future<List<Ulasan>> _ulasanFuture;

  @override
  void initState() {
    super.initState();
    _jarakFuture = (widget.jarakLoader ?? _defaultJarakLoader)();
    _ulasanFuture = (widget.ulasanLoader ?? _defaultUlasanLoader)();
  }

  Future<List<JarakDesa>> _defaultJarakLoader() async {
    final api = ApiClient(tokenStore: InMemoryTokenStore());
    final repo = JarakRepository(api);
    try {
      return await repo.getByDesaId(widget.desaId);
    } catch (_) {
      return [];
    }
  }

  Future<List<Ulasan>> _defaultUlasanLoader() async {
    final api = ApiClient(tokenStore: InMemoryTokenStore());
    final repo = UlasanRepository(api);
    try {
      return await repo.getAll();
    } catch (_) {
      return []; // offline/API error → empty state
    }
  }

  void _share() {
    showDestinasiShareSheet(
      context,
      namaDesa: widget.namaDesa,
      lokasi: widget.lokasi,
      foto: widget.foto,
    );
  }

  void _showReviewForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: ReviewForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final statusText = isEn
        ? 'Open Today \u2022 07:00 \u2013 17:30 WITA'
        : _statusBuka;

    return Scaffold(
      backgroundColor: AppColors.detailBackground,
      body: CustomScrollView(
        slivers: [
          // 1. Hero parallax-styled (frame 4714:452)
          SliverToBoxAdapter(
            child: DetailHero(
              foto: widget.foto,
              statusText: statusText,
              namaDesa: widget.namaDesa,
              lokasi: widget.lokasi,
              onShare: _share,
            ),
          ),

          // 2..5. Konten section (padding 20px horizontal)
          SliverToBoxAdapter(child: _body(isEn)),
        ],
      ),
    );
  }

  Widget _body(bool isEn) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 2. How to Get There (data jarakDesa) — section pertama sesuai Figma
          FutureBuilder<List<JarakDesa>>(
            future: _jarakFuture,
            builder: (context, snap) {
              if (!snap.hasData) return _sectionSkeleton();
              return HowToGetThere(
                namaDesa: widget.namaDesa,
                jarakList: snap.data!,
              );
            },
          ),

          const SizedBox(height: 16),

          // 4. Fasilitas Desa Wisata (placeholder demo)
          const FasilitasSection(),

          const SizedBox(height: 16),

          // 5. Ulasan Pengunjung (data ulasan global)
          FutureBuilder<List<Ulasan>>(
            future: _ulasanFuture,
            builder: (context, snap) {
              if (!snap.hasData) return _sectionSkeleton();
              return UlasanSection(
                ulasanList: snap.data!,
                onTulisUlasan: _showReviewForm,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Skeleton placeholder bar untuk section yang masih loading.
  Widget _sectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 120,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.detailBorder,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.detailBorder,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.detailBorder,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
