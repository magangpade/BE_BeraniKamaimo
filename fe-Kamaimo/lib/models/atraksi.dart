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
    this.kategori = 'BUDAYA',
    this.wilayah,
    this.harga,
    this.rating = 0,
    this.ratingCount = 0,
    this.badge,
    this.programJson,
    this.rundownJson,
    this.aksesJson,
    this.organizerJson,
    this.mapsUrl,
    this.mapLabel,
    this.latitude,
    this.longitude,
  });

  factory Atraksi.fromJson(Map<String, dynamic> json) => Atraksi(
    id: (json['id'] is num)
        ? (json['id'] as num).toInt()
        : (int.tryParse(json['id']?.toString() ?? '') ?? 0),
    nameEvent: json['nameEvent'] as String? ?? '',
    lokasi_id: json['location_id'] as String? ?? '',
    lokasi_en: json['location_en'] as String?,
    deskripsi_id: json['description_id'] as String? ?? '',
    deskripsi_en: json['description_en'] as String?,
    startdate: json['startdate']?.toString() ?? '',
    enddate: json['enddate']?.toString() ?? '',
    foto: json['foto'] as String?,
    linkVideo: json['link_video'] as String?,
    kategori: json['kategori'] as String? ?? 'BUDAYA',
    wilayah: json['wilayah'] as String?,
    harga: (json['harga'] as num?)?.toInt(),
    rating: double.tryParse('${json['rating'] ?? 0}') ?? 0,
    ratingCount: int.tryParse('${json['rating_count'] ?? 0}') ?? 0,
    badge: json['badge'] as String?,
    programJson: json['program_json']?.toString(),
    rundownJson: json['rundown_json']?.toString(),
    aksesJson: json['akses_json']?.toString(),
    organizerJson: json['organizer_json']?.toString(),
    mapsUrl: json['maps_url'] as String?,
    mapLabel: json['map_label'] as String?,
    latitude: double.tryParse('${json['latitude'] ?? ''}'),
    longitude: double.tryParse('${json['longitude'] ?? ''}'),
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
  final String kategori;
  final String? wilayah;
  final int? harga;
  final double rating;
  final int ratingCount;
  final String? badge;
  final String? programJson;
  final String? rundownJson;
  final String? aksesJson;
  final String? organizerJson;
  final String? mapsUrl;
  final String? mapLabel;
  final double? latitude;
  final double? longitude;

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
