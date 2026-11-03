/// Model Atraksi (Event).
class Atraksi {
  const Atraksi({
    required this.id,
    required this.nameEvent,
    required this.lokasi_id,
    this.lokasi_en,
    required this.deskripsi_id,
    this.deskripsi_en,
    required this.startdate,
    required this.enddate,
    this.foto,
    this.linkVideo,
  });

  factory Atraksi.fromJson(Map<String, dynamic> json) => Atraksi(
        id: json['id'] as int,
        nameEvent: json['nameEvent'] as String,
        lokasi_id: json['location_id'] as String,
        lokasi_en: json['location_en'] as String?,
        deskripsi_id: json['description_id'] as String,
        deskripsi_en: json['description_en'] as String?,
        startdate: json['startdate'] as String,
        enddate: json['enddate'] as String,
        foto: json['foto'] as String?,
        linkVideo: json['link_video'] as String?,
      );

  final int id;
  final String nameEvent;
  final String lokasi_id;
  final String? lokasi_en;
  final String deskripsi_id;
  final String? deskripsi_en;
  final String startdate;
  final String enddate;
  final String? foto;
  final String? linkVideo;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameEvent': nameEvent,
        'location_id': lokasi_id,
        'location_en': lokasi_en,
        'description_id': deskripsi_id,
        'description_en': deskripsi_en,
        'startdate': startdate,
        'enddate': enddate,
        'foto': foto,
        'link_video': linkVideo,
      };
}
