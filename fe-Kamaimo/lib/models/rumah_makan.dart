/// Model RumahMakan.
class RumahMakan {
  const RumahMakan({
    required this.id,
    required this.resto,
    required this.kulinerId,
    required this.linkGmaps,
    this.linkVideo,
  });

  factory RumahMakan.fromJson(Map<String, dynamic> json) => RumahMakan(
        id: json['id'] as int,
        resto: json['resto'] as String,
        kulinerId: json['kulinerId'] as int,
        linkGmaps: json['link_gmaps'] as String,
        linkVideo: json['link_video'] as String?,
      );

  final int id;
  final String resto;
  final int kulinerId;
  final String linkGmaps;
  final String? linkVideo;

  Map<String, dynamic> toJson() => {
        'id': id,
        'resto': resto,
        'kulinerId': kulinerId,
        'link_gmaps': linkGmaps,
        'link_video': linkVideo,
      };
}
