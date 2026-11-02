/// Model Kuliner.
class Kuliner {
  const Kuliner({
    required this.id,
    required this.nama_makanan,
    required this.lokasi,
    required this.deskripsi_id,
    this.deskripsi_en,
    this.foto,
    this.linkVideo,
  });

  factory Kuliner.fromJson(Map<String, dynamic> json) => Kuliner(
        id: json['id'] as int,
        nama_makanan: json['nama_makanan'] as String,
        lokasi: json['lokasi'] as String,
        deskripsi_id: json['deskripsi_id'] as String,
        deskripsi_en: json['deskripsi_en'] as String?,
        foto: json['foto'] as String?,
        linkVideo: json['link_video'] as String?,
      );

  final int id;
  final String nama_makanan;
  final String lokasi;
  final String deskripsi_id;
  final String? deskripsi_en;
  final String? foto;
  final String? linkVideo;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_makanan': nama_makanan,
        'lokasi': lokasi,
        'deskripsi_id': deskripsi_id,
        'deskripsi_en': deskripsi_en,
        'foto': foto,
        'link_video': linkVideo,
      };
}
