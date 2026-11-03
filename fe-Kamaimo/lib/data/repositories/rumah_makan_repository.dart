import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/rumah_makan.dart';

class RumahMakanRepository {
  final ApiClient _apiClient;

  RumahMakanRepository(this._apiClient);

  Future<List<RumahMakan>> getAll() async {
    final raw = await _apiClient.get(ApiConfig.rumahMakan);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => RumahMakan.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<List<RumahMakan>> getByKulinerId(int kulinerId) async {
    final all = await getAll();
    return all.where((r) => r.kulinerId == kulinerId).toList();
  }
}
