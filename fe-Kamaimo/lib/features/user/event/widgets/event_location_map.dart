import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../event_detail_data.dart';

/// Pratinjau lokasi dalam kartu detail. Tombol membuka petunjuk sesungguhnya.
class EventLocationMap extends StatelessWidget {
  const EventLocationMap({
    required this.detail,
    required this.onOpenMaps,
    super.key,
  });

  final EventDetail detail;
  final VoidCallback onOpenMaps;

  LatLng _resolveCoordinates() {
    if (detail.mapLatitude != null && detail.mapLongitude != null) {
      return LatLng(detail.mapLatitude!, detail.mapLongitude!);
    }
    final text = '${detail.region} ${detail.mapLabel} ${detail.lokasi}'.toLowerCase();
    if (text.contains('poso') || text.contains('tentena')) {
      return const LatLng(-1.7600, 120.6500);
    }
    if (text.contains('lalong') || text.contains('luwuk') || text.contains('banggai')) {
      return const LatLng(-0.9516, 122.7875);
    }
    if (text.contains('togean') || text.contains('ampana') || text.contains('una-una')) {
      return const LatLng(-0.8711, 121.5833);
    }
    if (text.contains('palu') || text.contains('aljufri') || text.contains('raudhah')) {
      return const LatLng(-0.8917, 119.8707);
    }
    if (text.contains('tomini') || text.contains('parigi')) {
      return const LatLng(-0.8222, 120.1917);
    }
    if (text.contains('donggala')) {
      return const LatLng(-0.6766, 119.7460);
    }
    return const LatLng(-1.4300, 121.4450); // Pusat Sulawesi Tengah
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final center = _resolveCoordinates();
    final labelText = detail.mapLabel.trim().isNotEmpty
        ? detail.mapLabel
        : (detail.lokasi.trim().isNotEmpty ? detail.lokasi : 'Sulawesi Tengah');

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 190,
        width: double.infinity,
        color: const Color(0xFFE5EFE8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (detail.mapAsset != null)
              Image.asset(detail.mapAsset!, fit: BoxFit.cover)
            else
              GestureDetector(
                onTap: onOpenMaps,
                child: AbsorbPointer(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: center,
                      initialZoom: 12,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.berani.kamaimo',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: center,
                            width: 36,
                            height: 36,
                            child: const Icon(
                              Icons.location_on_rounded,
                              size: 36,
                              color: Color(0xFFD83E34),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 14,
              left: 12,
              right: 12,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pine900,
                      borderRadius: BorderRadius.circular(99),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Color(0xFFFFC83D),
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            labelText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: FilledButton(
                onPressed: onOpenMaps,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFECF4EE),
                  foregroundColor: AppColors.pine700,
                  elevation: 2,
                  minimumSize: const Size(0, 42),
                  textStyle: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.near_me_rounded, size: 16),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        isEnglish
                            ? 'Open Directions in Google Maps'
                            : 'Buka Petunjuk di Google Maps',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
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
