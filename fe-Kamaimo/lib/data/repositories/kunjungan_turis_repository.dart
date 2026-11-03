import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/kunjungan_turis.dart';

class KunjunganTurisRepository {
  final ApiClient _apiClient;

  KunjunganTurisRepository(this._apiClient);

  Future<List<KunjunganTuris>> getAll() async {
    final jsonList = await _apiClient.get(ApiConfig.kunjunganTuris) as List;
    return jsonList.map((json) => KunjunganTuris.fromJson(json)).toList();
  }
}