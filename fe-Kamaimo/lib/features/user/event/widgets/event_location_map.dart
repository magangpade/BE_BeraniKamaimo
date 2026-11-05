import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  @override
  Widget build(BuildContext context) {
    final latitude = detail.mapLatitude;
    final longitude = detail.mapLongitude;
    final hasCoordinates = latitude != null && longitude != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (detail.mapAsset != null)
              Image.asset(detail.mapAsset!, fit: BoxFit.cover)
            else if (hasCoordinates)
              AbsorbPointer(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
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
                          point: LatLng(latitude, longitude),
                          width: 34,
                          height: 34,
                          child: const Icon(
                            Icons.location_on_rounded,
                            size: 32,
                            color: Color(0xFFD83E34),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              const ColoredBox(color: Color(0xFFE9F0EA)),
            if (hasCoordinates || detail.mapAsset != null)
              Positioned(
                top: 0,
                bottom: 50,
                left: 12,
                right: 12,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pine900,
                        borderRadius: BorderRadius.circular(99),
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
                          const SizedBox(width: 5),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              detail.mapLabel,
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
              bottom: 8,
              left: 24,
              right: 24,
              child: FilledButton(
                onPressed: onOpenMaps,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFECF4EE),
                  foregroundColor: AppColors.pine700,
                  minimumSize: const Size(0, 42),
                  textStyle: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.near_me_rounded, size: 16),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Buka Petunjuk di Google Maps',
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
