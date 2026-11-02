import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/desa_wisata.dart';

class DesaWisataRepository {
  final ApiClient _apiClient;

  DesaWisataRepository(this._apiClient);

  Future<List<DesaWisata>> getAll() async {
    final raw = await _apiClient.get(ApiConfig.desaWisata);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => DesaWisata.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<DesaWisata?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.desaWisata}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return DesaWisata.fromJson(Map<String, dynamic>.from(map));
  }
}
