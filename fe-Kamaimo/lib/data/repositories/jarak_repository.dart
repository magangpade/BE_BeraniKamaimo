import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/jarak_desa.dart';

class JarakRepository {
  final ApiClient _apiClient;

  JarakRepository(this._apiClient);

  Future<List<JarakDesa>> getAll() async {
    final raw = await _apiClient.get(ApiConfig.jarak);
    List<dynamic> jsonList = [];
    if (raw is List) {
      jsonList = raw;
    } else if (raw is Map && raw['data'] is List) {
      jsonList = raw['data'] as List;
    }
    return jsonList
        .whereType<Map>()
        .map((json) => JarakDesa.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<List<JarakDesa>> getByDesaId(int desaId) async {
    final all = await getAll();
    return all.where((j) => j.desaId == desaId).toList();
  }
}
