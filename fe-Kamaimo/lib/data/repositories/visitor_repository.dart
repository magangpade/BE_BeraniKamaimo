import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_config.dart';
import 'package:berani_kamaimo/models/visitor.dart';

class VisitorRepository {
  final ApiClient _apiClient;

  VisitorRepository(this._apiClient);

  /// Register visitor baru.
  Future<Map<String, dynamic>> register(String uid) async {
    return _apiClient.post(
      ApiConfig.visitor,
      body: {'uid': uid},
    );
  }

  /// Catat pageview.
  Future<Map<String, dynamic>> trackPageView({
    required String page,
    required int visitorId,
  }) async {
    return _apiClient.post(
      ApiConfig.pageview,
      body: {'page': page, 'visitorId': visitorId},
    );
  }

  /// Summary (dashboard admin).
  Future<VisitorSummary> getSummary() async {
    final json = await _apiClient.get('${ApiConfig.visitor}/summary');
    return VisitorSummary.fromJson(json);
  }

  /// Chart data (dashboard admin).
  Future<List<ChartPoint>> getChart(String filter) async {
    final jsonList =
        await _apiClient.get('${ApiConfig.pageview}/chart?filter=$filter')
            as List;
    return jsonList.map((json) => ChartPoint.fromJson(json)).toList();
  }
}