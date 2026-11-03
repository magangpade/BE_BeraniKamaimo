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
  });

  factory TourPackage.fromJson(Map<String, dynamic> json) => TourPackage(
        id: json['id'] as int,
        nama_wisata_id: json['nama_wisata_id'] as String,
        nama_wisata_en: json['nama_wisata_en'] as String?,
        harga: json['harga'] as int,
        deskripsi_id: json['deskripsi_id'] as String,
        deskripsi_en: json['deskripsi_en'] as String?,
        lokasi_id: json['lokasi_id'] as String,
        lokasi_en: json['lokasi_en'] as String?,
        kontak: json['kontak'] as String,
        media: json['media'] as String?,
        linkVideo: json['link_video'] as String?,
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
