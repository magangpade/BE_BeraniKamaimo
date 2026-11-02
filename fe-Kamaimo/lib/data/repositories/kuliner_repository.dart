import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/kuliner.dart';

class KulinerRepository {
  final ApiClient _apiClient;

  KulinerRepository(this._apiClient);

  Future<List<Kuliner>> getAll() async {
    final raw = await _apiClient.get(ApiConfig.kuliner);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => Kuliner.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Kuliner?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.kuliner}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return Kuliner.fromJson(Map<String, dynamic>.from(map));
  }
}
