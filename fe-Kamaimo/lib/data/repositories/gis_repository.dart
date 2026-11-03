import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../models/gis_marker.dart';

class GisRepository {
  final ApiClient _apiClient;

  GisRepository(this._apiClient);

  Future<List<GisMarker>> getMarkers({String? jenis}) async {
    final query = jenis != null ? '?jenis=$jenis' : '';
    final raw = await _apiClient.get('${ApiConfig.gisMarkers}$query');
    List<dynamic> markersList = [];
    if (raw is Map && raw['markers'] is List) {
      markersList = raw['markers'] as List;
    } else if (raw is List) {
      markersList = raw;
    }
    return markersList
        .whereType<Map>()
        .map((e) => GisMarker.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
