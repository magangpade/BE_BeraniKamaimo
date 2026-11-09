/// Model TourPackage (Paket Wisata).
class TourPackage {
  const TourPackage({
    required this.id,
    required this.nama_wisata_id,
    this.nama_wisata_en,
    required this.harga,
    required this.deskripsi_id,
    this.deskripsi_en,
    required this.lokasi_id,
    this.lokasi_en,
    required this.kontak,
    this.media,
    this.linkVideo,
    this.kategori,
    this.wilayah,
    this.durasi,
    this.tipe,
    this.tag,
    this.satuan,
    this.fasilitas,
    this.linkGmaps,
    this.rating = 0,
    this.ratingCount = 0,
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

  factory TourPackage.fromJson(Map<String, dynamic> json) => TourPackage(
    id: json['id'] as int,
    nama_wisata_id: json['nama_wisata_id'] as String? ?? '',
    nama_wisata_en: json['nama_wisata_en'] as String?,
    harga: _asInt(json['harga']),
    deskripsi_id: json['deskripsi_id'] as String? ?? '',
    deskripsi_en: json['deskripsi_en'] as String?,
    lokasi_id: json['lokasi_id'] as String? ?? '',
    lokasi_en: json['lokasi_en'] as String?,
    kontak: json['kontak'] as String? ?? '',
    media: json['media'] as String?,
    linkVideo: json['link_video'] as String?,
    kategori: json['kategori'] as String?,
    wilayah: json['wilayah'] as String?,
    durasi: json['durasi'] as String?,
    tipe: json['tipe'] as String?,
    tag: json['tag'] as String?,
    satuan: json['satuan'] as String?,
    fasilitas: json['fasilitas'] as String?,
    linkGmaps: json['link_gmaps'] as String?,
    rating: double.tryParse('${json['rating'] ?? 0}') ?? 0,
    ratingCount: int.tryParse('${json['rating_count'] ?? 0}') ?? 0,
  );

  final int id;
  final String nama_wisata_id;
  final String? nama_wisata_en;
  final int harga;
  final String deskripsi_id;
  final String? deskripsi_en;
  final String lokasi_id;
  final String? lokasi_en;
  final String kontak;
  final String? media;
  final String? linkVideo;
  final String? kategori;
  final String? wilayah;
  final String? durasi;
  final String? tipe;
  final String? tag;
  final String? satuan;
  final String? fasilitas;
  final String? linkGmaps;
  final double rating;
  final int ratingCount;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_wisata_id': nama_wisata_id,
    'nama_wisata_en': nama_wisata_en,
    'harga': harga,
    'deskripsi_id': deskripsi_id,
    'deskripsi_en': deskripsi_en,
    'lokasi_id': lokasi_id,
    'lokasi_en': lokasi_en,
    'kontak': kontak,
    'media': media,
    'link_video': linkVideo,
  };
}
