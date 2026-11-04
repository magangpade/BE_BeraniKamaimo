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
    this.kategori = 'BAHARI',
    this.durasi = '3 Hari 2 Malam',
    this.tipe = 'Tur Wisata',
    this.rating = '4.8',
    this.rating_count = 80,
    this.fasilitas,
  });

  factory TourPackage.fromJson(Map<String, dynamic> json) => TourPackage(
        id: json['id'] as int,
        nama_wisata_id: json['nama_wisata_id'] as String? ?? '',
        nama_wisata_en: json['nama_wisata_en'] as String?,
        harga: (json['harga'] as num?)?.toInt() ?? 0,
        deskripsi_id: json['deskripsi_id'] as String? ?? '',
        deskripsi_en: json['deskripsi_en'] as String?,
        lokasi_id: json['lokasi_id'] as String? ?? '',
        lokasi_en: json['lokasi_en'] as String?,
        kontak: json['kontak'] as String? ?? '',
        media: json['media'] as String?,
        linkVideo: json['link_video'] as String?,
        kategori: json['kategori'] as String? ?? 'BAHARI',
        durasi: json['durasi'] as String? ?? '3 Hari 2 Malam',
        tipe: json['tipe'] as String? ?? 'Tur Wisata',
        rating: json['rating']?.toString() ?? '4.8',
        rating_count: (json['rating_count'] as num?)?.toInt() ?? 80,
        fasilitas: json['fasilitas'] as String?,
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
  final String kategori;
  final String durasi;
  final String tipe;
  final String rating;
  final int rating_count;
  final String? fasilitas;

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
        'kategori': kategori,
        'durasi': durasi,
        'tipe': tipe,
        'rating': rating,
        'rating_count': rating_count,
        'fasilitas': fasilitas,
      };
}
