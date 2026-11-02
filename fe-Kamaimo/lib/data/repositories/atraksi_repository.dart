import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/atraksi.dart';

class AtraksiRepository {
  final ApiClient _apiClient;

  AtraksiRepository(this._apiClient);

  Future<List<Atraksi>> getAll() async {
    final raw = await _apiClient.get(ApiConfig.atraksi);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => Atraksi.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Atraksi?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.atraksi}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return Atraksi.fromJson(Map<String, dynamic>.from(map));
  }
}
