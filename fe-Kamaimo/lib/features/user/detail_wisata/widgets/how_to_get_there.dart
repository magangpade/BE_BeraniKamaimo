import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../models/jarak_desa.dart';

/// Section "How to Get There" (AKSESIBILITAS & RUTE) sesuai frame 4714:452:
/// pilihan asal dari data `titikKota` + kartu rute Laut/Darat/Udara
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
  String? _selected;

  JarakDesa? get _active {
    final list = widget.jarakList;
    if (list.isEmpty) return null;
    final selected = _selected ?? list.first.titikKota;
    return list.any((j) => j.titikKota == selected)
        ? list.firstWhere((j) => j.titikKota == selected)
        : list.first;
  }

  String _namaTik(String titikKota) => titikKota == 'PALU'
      ? 'Palu'
      : (titikKota == 'LUWUK' ? 'Luwuk' : titikKota);

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
        const SizedBox(height: 16),

        // Asal rute berasal dari data desa, termasuk wilayah baru dari admin.
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.detailBorder,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final origin
                    in widget.jarakList.map((j) => j.titikKota).toSet())
                  _SegmentButton(
                    label: '${isEn ? 'From' : 'Dari'} ${_namaTik(origin)}',
                    selected:
                        (_selected ?? widget.jarakList.first.titikKota) ==
                        origin,
                    onTap: () => setState(() => _selected = origin),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Kartu rute / empty state (gap 14)
        const SizedBox(height: 4),
        if (jarak != null) ...[
          if (jarak.jalur_laut.trim().isNotEmpty) ...[
            _RouteCard(
              jalur: Jalur.laut,
              deskripsi: jarak.jalur_laut,
              info: jarak.laut,
            ),
            const SizedBox(height: 14),
          ],
          if (jarak.jalur_darat.trim().isNotEmpty) ...[
            _RouteCard(
              jalur: Jalur.darat,
              deskripsi: jarak.jalur_darat,
              info: jarak.darat,
            ),
            const SizedBox(height: 14),
          ],
          if (jarak.jalur_udara.trim().isNotEmpty)
            _RouteCard(
              jalur: Jalur.udara,
              deskripsi: jarak.jalur_udara,
              info: jarak.udara,
            ),
        ] else
          Text(
            isEn
                ? 'Routes from ${_namaTik(jarak?.titikKota ?? _selected ?? '')} are not yet available.'
                : 'Rute dari ${_namaTik(jarak?.titikKota ?? _selected ?? '')} belum tersedia.',
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
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
              color: selected ? AppColors.textOnPrimary : AppColors.detailBody,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Kartu rute per jalur ───────────────────────────────────────────────────

enum Jalur { laut, darat, udara }

class _JalurStyle {
  final Color badgeBg;
  final Color accent;
  final IconData icon;
  final String label;

  /// Padding vertikal pill durasi (default 12; jalur udara 4 sesuai Figma).
  final double pillVertical;

  const _JalurStyle({
    required this.badgeBg,
    required this.accent,
    required this.icon,
    required this.label,
    this.pillVertical = 12,
  });
}

const _laut = _JalurStyle(
  badgeBg: AppColors.mintSoft,
  accent: AppColors.pine500,
  icon: Icons.directions_boat_rounded,
  label: 'JALUR LAUT',
);

const _darat = _JalurStyle(
  badgeBg: AppColors.peachSoft,
  accent: AppColors.earth,
  icon: Icons.directions_car_rounded,
  label: 'JALUR DARAT',
);

const _udara = _JalurStyle(
  badgeBg: AppColors.detailBorder,
  accent: AppColors.navySky,
  icon: Icons.flight_rounded,
  label: 'JALUR UDARA',
  pillVertical: 4, // pill kecil 24px sesuai Figma
);

_JalurStyle _styleOf(Jalur jalur) =>
    jalur == Jalur.laut ? _laut : (jalur == Jalur.darat ? _darat : _udara);

/// Kartu rute: badge ikon + label + judul, pill durasi, deskripsi,
/// footer estimasi harga (Jalur.laut) / rental (Jalur.darat).
class _RouteCard extends StatelessWidget {
  final Jalur jalur;
  final String deskripsi;
  final JalurInfo? info;

  const _RouteCard({required this.jalur, required this.deskripsi, this.info});

  @override
  Widget build(BuildContext context) {
    final isEn = context.watch<LanguageProvider>().isEnglish;
    final s = _styleOf(jalur);
    final labelText = !isEn
        ? s.label
        : (jalur == Jalur.laut
              ? 'SEA ROUTE'
              : (jalur == Jalur.darat ? 'LAND ROUTE' : 'AIR ROUTE'));
    final titleText = isEn && (info?.judulEn?.isNotEmpty ?? false)
        ? info!.judulEn!
        : (info?.judul?.isNotEmpty ?? false)
        ? info!.judul!
        : labelText;
    final durasiText = info?.durasi == null || info!.durasi!.isEmpty
        ? null
        : (!isEn
              ? info!.durasi
              : info!.durasi!
                    .replaceAll('jam', 'hrs')
                    .replaceAll('Jam', 'Hrs')
                    .replaceAll('Menit', 'Mins'));
    final footerLabelText = isEn ? 'Estimated cost:' : 'Estimasi biaya:';
    final footerPriceText = info?.biaya;

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
            isEn && (info?.deskripsiEn?.isNotEmpty ?? false)
                ? info!.deskripsiEn!
                : deskripsi,
            style: const TextStyle(
              fontSize: 12,
              height: 19.5 / 12,
              color: AppColors.detailBody,
            ),
          ),

          // Footer harga (laut & darat saja, sesuai Figma)
          if (footerPriceText != null && footerPriceText.isNotEmpty) ...[
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
                    footerPriceText,
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
