class GisMarker {
  final String id;
  final int refId;
  final String type;
  final String kategori;
  final String nama;
  final String lokasi;
  final double lat;
  final double lng;
  final double rating;
  final int totalUlasan;
  final String? foto;

  const GisMarker({
    required this.id,
    required this.refId,
    required this.type,
    required this.kategori,
    required this.nama,
    required this.lokasi,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.totalUlasan,
    this.foto,
  });

  factory GisMarker.fromJson(Map<String, dynamic> json) {
    return GisMarker(
      id: json['id'] as String? ?? '',
      refId: json['refId'] as int? ?? 0,
      type: json['type'] as String? ?? 'desa_wisata',
      kategori: json['kategori'] as String? ?? '',
      nama: json['nama'] as String? ?? '',
      lokasi: json['lokasi'] as String? ?? '',
      lat: (json['lat'] is num)
          ? (json['lat'] as num).toDouble()
          : (double.tryParse(json['lat']?.toString() ?? '') ?? -1.43),
      lng: (json['lng'] is num)
          ? (json['lng'] as num).toDouble()
          : (double.tryParse(json['lng']?.toString() ?? '') ?? 121.445),
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : (double.tryParse(json['rating']?.toString() ?? '') ?? 4.5),
      totalUlasan: (json['total_ulasan'] is num)
          ? (json['total_ulasan'] as num).toInt()
          : (int.tryParse(json['total_ulasan']?.toString() ?? '') ?? 0),
      foto: json['foto'] as String?,
    );
  }
}

