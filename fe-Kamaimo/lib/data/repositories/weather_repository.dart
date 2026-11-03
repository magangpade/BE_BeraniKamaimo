import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../models/weather.dart';

class WeatherRepository {
  final ApiClient _apiClient;

  WeatherRepository(this._apiClient);

  Future<WeatherInfo> getCurrentWeather({String city = 'Palu'}) async {
    final raw = await _apiClient.get('${ApiConfig.weather}?city=$city');
    final map = raw is Map ? (raw['data'] is Map ? raw['data'] as Map : raw) : {};
    return WeatherInfo.fromJson(Map<String, dynamic>.from(map));
  }
}
