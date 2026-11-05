import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';

class EventRatingSummary {
  final double? rating;
  final int ratingCount;
  final int? myRating;

  const EventRatingSummary({
    required this.rating,
    required this.ratingCount,
    required this.myRating,
  });

  factory EventRatingSummary.fromJson(Map<String, dynamic> json) {
    return EventRatingSummary(
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      myRating: (json['myRating'] as num?)?.toInt(),
    );
  }
}

class EventRatingRepository {
  EventRatingRepository(this._apiClient);

  final ApiClient _apiClient;
  static const _visitorPreference = 'event_rating_visitor_key';

  Future<String> _visitorKey() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_visitorPreference);
    if (existing != null && existing.isNotEmpty) return existing;
    final created = const Uuid().v4();
    await prefs.setString(_visitorPreference, created);
    return created;
  }

  Future<EventRatingSummary> getSummary(String eventKey) async {
    final visitorKey = await _visitorKey();
    final endpoint =
        '${ApiConfig.eventRating}/$eventKey?visitorKey=$visitorKey';
    final data = await _apiClient.get(endpoint);
    return EventRatingSummary.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<EventRatingSummary> submit(String eventKey, int rating) async {
    final visitorKey = await _visitorKey();
    final response = await _apiClient.post(
      '${ApiConfig.eventRating}/$eventKey',
      body: {'visitorKey': visitorKey, 'rating': rating},
    );
    return EventRatingSummary.fromJson(
      Map<String, dynamic>.from(response['data'] as Map),
    );
  }
}
