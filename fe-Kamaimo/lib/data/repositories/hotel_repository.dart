import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/hotel.dart';

class HotelRepository {
  final ApiClient _apiClient;

  HotelRepository(this._apiClient);

  Future<List<Hotel>> getAll({String? wilayah, String? q}) async {
    String endpoint = ApiConfig.hotel;
    final queryParams = <String>[];
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
        .map((json) => Hotel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<Hotel?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.hotel}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return Hotel.fromJson(Map<String, dynamic>.from(map));
  }
}
