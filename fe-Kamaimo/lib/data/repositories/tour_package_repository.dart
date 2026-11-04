import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/tour_package.dart';

class TourPackageRepository {
  final ApiClient _apiClient;

  TourPackageRepository(this._apiClient);

  Future<List<TourPackage>> getAll({String? kategori, String? q}) async {
    String endpoint = ApiConfig.tourPackage;
    final queryParams = <String>[];
    if (kategori != null && kategori.isNotEmpty && kategori != 'Semua') {
      queryParams.add('kategori=${Uri.encodeComponent(kategori)}');
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
        .map((json) => TourPackage.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<TourPackage?> getById(int id) async {
    final raw = await _apiClient.get('${ApiConfig.tourPackage}/$id');
    if (raw == null || (raw is Map && raw.isEmpty)) return null;
    final map = raw is Map && raw['data'] is Map ? raw['data'] as Map : (raw is Map ? raw : {});
    if (map.isEmpty) return null;
    return TourPackage.fromJson(Map<String, dynamic>.from(map));
  }
}
