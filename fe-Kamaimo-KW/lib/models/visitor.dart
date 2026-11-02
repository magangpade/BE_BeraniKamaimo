/// Model Visitor (tracking pengunjung).
class Visitor {
  const Visitor({
    required this.id,
    required this.uid,
    required this.createdAt,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
        id: json['id'] as int,
        uid: json['uid'] as String,
        createdAt: json['createdAt'] as String,
      );

  final int id;
  final String uid;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'createdAt': createdAt,
      };
}

/// Model PageView (tracking halaman).
class PageView {
  const PageView({
    required this.id,
    required this.page,
    required this.visitorId,
    required this.createdAt,
  });

  factory PageView.fromJson(Map<String, dynamic> json) => PageView(
        id: json['id'] as int,
        page: json['page'] as String,
        visitorId: json['visitorId'] as int,
        createdAt: json['createdAt'] as String,
      );

  final int id;
  final String page;
  final int visitorId;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'page': page,
        'visitorId': visitorId,
        'createdAt': createdAt,
      };
}

/// Model VisitorSummary (dashboard grafik).
class VisitorSummary {
  const VisitorSummary({
    required this.visits,
    required this.visitors,
  });

  factory VisitorSummary.fromJson(Map<String, dynamic> json) =>
      VisitorSummary(
        visits: json['visits'] as int,
        visitors: json['visitors'] as int,
      );

  final int visits;
  final int visitors;

  Map<String, dynamic> toJson() => {
        'visits': visits,
        'visitors': visitors,
      };
}

/// Model ChartPoint (data chart grafik).
class ChartPoint {
  const ChartPoint({
    required this.label,
    required this.value,
  });

  factory ChartPoint.fromJson(Map<String, dynamic> json) => ChartPoint(
        label: json['label'] as String,
        value: json['value'] as int,
      );

  final String label;
  final int value;

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
      };
}
