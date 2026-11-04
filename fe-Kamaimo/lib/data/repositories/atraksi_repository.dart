import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/atraksi.dart';

class AtraksiRepository {
  final ApiClient _apiClient;

  AtraksiRepository(this._apiClient);

  Future<List<Atraksi>> getAll({String? kategori, String? wilayah, String? q}) async {
    String endpoint = ApiConfig.atraksi;
    final queryParams = <String>[];
    if (kategori != null && kategori.isNotEmpty && kategori != 'Semua') {
      queryParams.add('kategori=${Uri.encodeComponent(kategori)}');
    }
    if (wilayah != null && wilayah.isNotEmpty && wilayah != 'Semua Wilayah') {
      queryParams.add('wilayah=${Uri.encodeComponent(wilayah)}');
    }
    if (q != null && q.trim().isNotEmpty) {
      queryParams.add('q=${Uri.encodeComponent(q.trim())}');
    }
    if (queryParams.isNotEmpty) {
      endpoint += '?${queryParams.join('&')}';
    }

    final raw = await _apiClient.get(endpoint);
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
