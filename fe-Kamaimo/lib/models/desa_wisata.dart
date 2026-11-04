/// Model DesaWisata.
class DesaWisata {
  const DesaWisata({
    required this.id,
    required this.namaDesa_id,
    this.namaDesa_en,
    required this.lokasi_id,
    this.lokasi_en,
    required this.deskripsi_id,
    this.deskripsi_en,
    required this.latitude,
    required this.longitude,
    required this.jenisDesa,
    this.kategori = 'EKOWISATA',
    this.foto,
    this.linkVideo,
    this.rating = '4.5',
    this.total_ulasan = 0,
  });

  factory DesaWisata.fromJson(Map<String, dynamic> json) => DesaWisata(
        id: json['id'] as int,
        namaDesa_id: json['namaDesa_id'] as String? ?? '',
        namaDesa_en: json['namaDesa_en'] as String?,
        lokasi_id: json['lokasi_id'] as String? ?? '',
        lokasi_en: json['lokasi_en'] as String?,
        deskripsi_id: json['deskripsi_id'] as String? ?? '',
        deskripsi_en: json['deskripsi_en'] as String?,
        latitude: json['latitude']?.toString() ?? '-1.43',
        longitude: json['longitude']?.toString() ?? '121.44',
        jenisDesa: json['jenisDesa'] as String? ?? 'DESA_WISATA',
        kategori: json['kategori'] as String? ?? 'EKOWISATA',
        foto: json['foto'] as String?,
        linkVideo: json['link_video'] as String?,
        rating: json['rating']?.toString() ?? '4.5',
        total_ulasan: (json['total_ulasan'] as num?)?.toInt() ?? 0,
      );

  final int id;
  final String namaDesa_id;
  final String? namaDesa_en;
  final String lokasi_id;
  final String? lokasi_en;
  final String deskripsi_id;
  final String? deskripsi_en;
  final String latitude;
  final String longitude;
  final String jenisDesa; // DESA_WISATA | DESA_UNGGULAN
  final String kategori; // BUDAYA | BAHARI | UMKM | EKOWISATA
  final String? foto;
  final String? linkVideo;
  final String rating;
  final int total_ulasan;

  Map<String, dynamic> toJson() => {
        'id': id,
        'namaDesa_id': namaDesa_id,
        'namaDesa_en': namaDesa_en,
        'lokasi_id': lokasi_id,
        'lokasi_en': lokasi_en,
        'deskripsi_id': deskripsi_id,
        'deskripsi_en': deskripsi_en,
        'latitude': latitude,
        'longitude': longitude,
        'jenisDesa': jenisDesa,
        'kategori': kategori,
        'foto': foto,
        'link_video': linkVideo,
        'rating': rating,
        'total_ulasan': total_ulasan,
      };
}
