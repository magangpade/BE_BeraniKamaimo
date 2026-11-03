/// Model Weather Info.
class WeatherInfo {
  final String location;
  final int temp;
  final int feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final num windSpeed;

  const WeatherInfo({
    required this.location,
    required this.temp,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['location'] as String? ?? 'Palu',
      temp: (json['temp'] as num?)?.round() ?? 29,
      feelsLike: (json['feels_like'] as num?)?.round() ?? 30,
      description: json['description'] as String? ?? 'Cerah Berawan',
      icon: json['icon'] as String? ?? '02d',
      humidity: (json['humidity'] as num?)?.round() ?? 75,
      windSpeed: json['wind_speed'] as num? ?? 3.5,
    );
  }
}

