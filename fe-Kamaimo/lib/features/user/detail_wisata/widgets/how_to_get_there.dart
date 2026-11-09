import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../models/jarak_desa.dart';

/// Section "How to Get There" (AKSESIBILITAS & RUTE) sesuai frame 4714:452:
/// segmented pill Luwuk/Palu (data `titikKota`) + kartu rute Laut/Darat/Udara
/// dari field `jalur_laut` / `jalur_darat` / `jalur_udara`.
class HowToGetThere extends StatefulWidget {
  final String namaDesa;
  final List<JarakDesa> jarakList;

  const HowToGetThere({
    super.key,
    required this.namaDesa,
    required this.jarakList,
  });

  @override
  State<HowToGetThere> createState() => _HowToGetThereState();
}

class _HowToGetThereState extends State<HowToGetThere> {
  /// Default tab Luwuk = "Rute Tercepat" sesuai Figma.
  String _selected = 'LUWUK';

  JarakDesa? get _active {
    final list = widget.jarakList;
    if (list.isEmpty) return null;
    return list.any((j) => j.titikKota == _selected)
        ? list.firstWhere((j) => j.titikKota == _selected)
        : null;
  }

  String _namaTik(String titikKota) =>
      titikKota == 'PALU' ? 'Palu' : (titikKota == 'LUWUK' ? 'Luwuk' : titikKota);

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final jarak = _active;

    // Tidak ada data jarak sama sekali → sembunyikan section.
    if (widget.jarakList.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header: eyebrow + judul nama desa
        Text(
          isEn ? 'ACCESSIBILITY & ROUTES' : 'AKSESIBILITAS & RUTE',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            letterSpacing: 0.6, // Figma 0.05em @12px
            color: AppColors.pine500,
          ),
        ),
        const SizedBox(height: 2.5),
        Text(
          widget.namaDesa,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 28 / 20,
            letterSpacing: -0.5,
            color: AppColors.pine900,
          ),
        ),
        const SizedBox(height: 12),

        // Modern Segmented Pill Switcher (selalu 2 tab sesuai Figma;
        // tab tanpa data → empty state)
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.detailBorder,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Row(
            children: [
              _SegmentButton(
                label: isEn
                    ? 'From Luwuk (Fastest Route)'
                    : 'Dari Luwuk (Rute Tercepat)',
                selected: _selected == 'LUWUK',
                onTap: () => setState(() => _selected = 'LUWUK'),
              ),
              _SegmentButton(
                label: isEn
                    ? 'From Palu (Capital City)'
                    : 'Dari Palu (Ibukota)',
                selected: _selected == 'PALU',
                onTap: () => setState(() => _selected = 'PALU'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (jarak != null) ...[
          _RouteCard(jalur: Jalur.laut, deskripsi: jarak.jalur_laut),
          const SizedBox(height: 14),
          _RouteCard(jalur: Jalur.darat, deskripsi: jarak.jalur_darat),
          const SizedBox(height: 14),
          _RouteCard(jalur: Jalur.udara, deskripsi: jarak.jalur_udara),
        ] else
          Text(
            isEn
                ? 'Routes from ${_namaTik(jarak?.titikKota ?? _selected)} are not yet available.'
                : 'Rute dari ${_namaTik(jarak?.titikKota ?? _selected)} belum tersedia.',
            style: const TextStyle(
              fontSize: 12,
              height: 19.5 / 12,
              color: AppColors.detailBody,
            ),
          ),
      ],
    );
  }
}

/// Satu tombol segmented pill.
class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: _rightMargin),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.pine800 : Colors.transparent,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ), // 0px 4px 6px -1px rgba(0,0,0,0.1)
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                color:
                    selected ? AppColors.textOnPrimary : AppColors.detailBody,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _rightMargin => 0;
}

// ─── Kartu rute per jalur ───────────────────────────────────────────────────

enum Jalur { laut, darat, udara }

class _JalurStyle {
  final Color badgeBg;
  final Color accent;
  final IconData icon;
  final String label;
  final String title;
  final String? durasi;
  final String? footerLabel;
  final String? footerPrice;
  /// Padding vertikal pill durasi (default 12; jalur udara 4 sesuai Figma).
  final double pillVertical;

  const _JalurStyle({
    required this.badgeBg,
    required this.accent,
    required this.icon,
    required this.label,
    required this.title,
    this.durasi,
    this.footerLabel,
    this.footerPrice,
    this.pillVertical = 12,
  });
}

/// Judul, durasi, dan footer harga = placeholder demo sesuai Figma.
/// (backend belum punya field terstruktur: durasi & harga per jalur)
const _laut = _JalurStyle(
  badgeBg: AppColors.mintSoft,
  accent: AppColors.pine500,
  icon: Icons.directions_boat_rounded,
  label: 'JALUR LAUT',
  title: 'Kapal Cepat / Feri\nPenyeberangan',
  durasi: '2 jam',
  footerLabel: 'Estimasi Tiket:',
  footerPrice: 'Rp 65K – 120K',
);

const _darat = _JalurStyle(
  badgeBg: AppColors.peachSoft,
  accent: AppColors.earth,
  icon: Icons.directions_car_rounded,
  label: 'JALUR DARAT',
  title: 'Salakan ke Luk Panenteng\nvia Liang',
  durasi: '1.5 Jam',
  footerLabel: 'Rental\nKendaraan:',
  footerPrice: 'Rp 250K– 400K / Hari',
);

const _udara = _JalurStyle(
  badgeBg: AppColors.detailBorder,
  accent: AppColors.navySky,
  icon: Icons.flight_rounded,
  label: 'JALUR UDARA',
  title: 'Bandara Syukuran\nAminuddin Amir (LUW)',
  durasi: '30 Menit',
  pillVertical: 4, // pill kecil 24px sesuai Figma
);

_JalurStyle _styleOf(Jalur jalur) =>
    jalur == Jalur.laut ? _laut : (jalur == Jalur.darat ? _darat : _udara);

/// Kartu rute: badge ikon + label + judul, pill durasi, deskripsi,
/// footer estimasi harga (Jalur.laut) / rental (Jalur.darat).
class _RouteCard extends StatelessWidget {
  final Jalur jalur;
  final String deskripsi;

  const _RouteCard({required this.jalur, required this.deskripsi});

  String _translateDeskripsi(String desc, bool isEn) {
    if (!isEn) return desc;
    if (desc.startsWith('Perjalanan darat aspal pesisir')) {
      return 'Coastal paved road trip along karst hills by rental car or local ojek from Salakan directly to the lake gate.';
    }
    if (desc.startsWith('Berangkat dari Pelabuhan Rakyat Luwuk')) {
      return 'Departs every morning from Luwuk Public Port to Salakan Port (Banggai Kepulauan) at 09:00 WITA.';
    }
    if (desc.startsWith('Penerbangan reguler terjadwal dari Makassar')) {
      return 'Scheduled regular flights from Makassar (UPG) or Manado (MDC) to Luwuk Airport (Wings Air / Batik Air).';
    }
    if (desc.startsWith('Perjalanan darat trans-Sulawesi')) {
      return 'Trans-Sulawesi overland trip from Palu to Luwuk by night bus (±10–12 hours), followed by ferry to Salakan and car to the village.';
    }
    if (desc.startsWith('Ferreguler KM dari Pelabuhan Pantoloan')) {
      return 'Regular ferry from Pantoloan Port (Palu) to Luwuk on a non-daily schedule — check the latest schedule before departure.';
    }
    if (desc.startsWith('Penerbangan dari Palu (PLW)')) {
      return 'Flights from Palu (PLW) generally transit via Makassar (UPG) or Manado (MDC) to Luwuk Airport (Wings Air / Batik Air).';
    }
    return desc;
  }

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final s = _styleOf(jalur);
    final labelText = !isEn
        ? s.label
        : (jalur == Jalur.laut
            ? 'SEA ROUTE'
            : (jalur == Jalur.darat ? 'LAND ROUTE' : 'AIR ROUTE'));
    final titleText = !isEn
        ? s.title
        : (jalur == Jalur.laut
            ? 'Speedboat / Ferry\nCrossing'
            : (jalur == Jalur.darat
                ? 'Salakan to Luk Panenteng\nvia Liang'
                : 'Syukuran Aminuddin\nAmir Airport (LUW)'));
    final durasiText = !isEn || s.durasi == null
        ? s.durasi
        : s.durasi!
            .replaceAll('jam', 'hrs')
            .replaceAll('Jam', 'Hrs')
            .replaceAll('Menit', 'Mins');
    final footerLabelText = !isEn || s.footerLabel == null
        ? s.footerLabel
        : (jalur == Jalur.laut ? 'Estimated Ticket:' : 'Vehicle\nRental:');
    final footerPriceText = !isEn || s.footerPrice == null
        ? s.footerPrice
        : s.footerPrice!.replaceAll('/ Hari', '/ Day');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.detailBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F1D3A30), // 0px 8px 30px -4px rgba(29,58,48,0.06)
            offset: Offset(0, 8),
            blurRadius: 30,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: badge + label/judul ... pill durasi
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: s.badgeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Icon(s.icon, size: 20, color: s.accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labelText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        height: 15 / 10,
                        letterSpacing: 0.5, // Figma 0.05em @10px
                        color: s.accent,
                      ),
                    ),
                    const SizedBox(height: 2.5),
                    Text(
                      titleText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 20 / 14,
                        color: AppColors.pine900,
                      ),
                    ),
                  ],
                ),
              ),
              if (durasiText != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: s.pillVertical,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.detailBackground,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    durasiText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 16 / 12,
                      color: s.accent,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Deskripsi rute (dari backend)
          Text(
            _translateDeskripsi(deskripsi, isEn),
            style: const TextStyle(
              fontSize: 12,
              height: 19.5 / 12,
              color: AppColors.detailBody,
            ),
          ),

          // Footer harga (laut & darat saja, sesuai Figma)
          if (footerLabelText != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              decoration: BoxDecoration(
                color: AppColors.creamCard.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
                border: const Border(
                  top: BorderSide(color: AppColors.detailBorder),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      footerLabelText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        color: AppColors.detailBody,
                      ),
                    ),
                  ),
                  Text(
                    footerPriceText ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 20 / 14,
                      // Harga footer selalu pine800 sesuai Figma (fill_49797c55)
                      color: AppColors.pine800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
