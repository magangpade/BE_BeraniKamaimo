/// Model Hotel.
class Hotel {
  const Hotel({
    required this.id,
    required this.nama_hotel,
    required this.telepon,
    required this.jumlah_kamar,
    required this.jumlah_tempatTidur,
    required this.harga_minimum,
    required this.harga_maximum,
    required this.website,
    required this.linkGmaps,
    required this.lokasi,
    this.wilayah,
    this.tag,
    this.rating = '0',
    this.rating_count = '0',
    this.highlight,
    this.foto,
    this.linkVideo,
  });

  static int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toInt();
    if (v is String) {
      final cleaned = v.replaceAll(RegExp(r'\D'), '');
      return int.tryParse(cleaned) ?? 0;
    }
    return 0;
  }

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json['id'] as int,
    nama_hotel: json['nama_hotel'] as String? ?? '',
    telepon: json['telepon'] as String? ?? '',
    jumlah_kamar: _asInt(json['jumlah_kamar']),
    jumlah_tempatTidur: _asInt(json['jumlah_tempatTidur']),
    harga_minimum: _asInt(json['harga_minimum']),
    harga_maximum: _asInt(json['harga_maximum']),
    website: json['website'] as String? ?? '',
    linkGmaps: json['link_gmaps'] as String? ?? '',
    lokasi: json['lokasi'] as String? ?? '',
    wilayah: json['wilayah'] as String?,
    tag: json['tag'] as String?,
    rating: json['rating']?.toString() ?? '0',
    rating_count: json['rating_count']?.toString() ?? '0',
    highlight: json['highlight'] as String?,
    foto: json['foto'] as String?,
    linkVideo: json['link_video'] as String?,
  );

  final int id;
  final String nama_hotel;
  final String telepon;
  final int jumlah_kamar;
  final int jumlah_tempatTidur;
  final int harga_minimum;
  final int harga_maximum;
  final String website;
  final String linkGmaps;
  final String lokasi;
  final String? wilayah;
  final String? tag;
  final String rating;
  final String rating_count;
  final String? highlight;
  final String? foto;
  final String? linkVideo;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_hotel': nama_hotel,
    'telepon': telepon,
    'jumlah_kamar': jumlah_kamar,
    'jumlah_tempatTidur': jumlah_tempatTidur,
    'harga_minimum': harga_minimum,
    'harga_maximum': harga_maximum,
    'website': website,
    'link_gmaps': linkGmaps,
    'lokasi': lokasi,
    'wilayah': wilayah,
    'tag': tag,
    'rating': rating,
    'rating_count': rating_count,
    'highlight': highlight,
    'foto': foto,
    'link_video': linkVideo,
  };
}
