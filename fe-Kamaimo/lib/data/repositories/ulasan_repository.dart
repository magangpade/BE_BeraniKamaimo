import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/ulasan.dart';

class UlasanRepository {
  final ApiClient _apiClient;

  UlasanRepository(this._apiClient);

  Future<List<Ulasan>> getAll({int? desaId}) async {
    final endpoint = desaId != null
        ? '${ApiConfig.ulasan}?desaId=$desaId'
        : ApiConfig.ulasan;
    final raw = await _apiClient.get(endpoint);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => Ulasan.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Ulasan?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.ulasan}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return Ulasan.fromJson(Map<String, dynamic>.from(map));
  }

  /// POST ulasan baru (publik, tanpa login).
  Future<Map<String, dynamic>> insertUlasan({
    required String nama,
    required int rating,
    required String komentar,
    int? desaId,
  }) async {
    return _apiClient.post(
      ApiConfig.insertUlasan,
      body: {
        'nama': nama,
        'rating': rating,
        'komentar': komentar,
        if (desaId != null) 'desaId': desaId,
      },
    );
  }
}
