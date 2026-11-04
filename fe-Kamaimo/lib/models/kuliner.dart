/// Model Kuliner.
class Kuliner {
  const Kuliner({
    required this.id,
    required this.nama_makanan,
    required this.lokasi,
    required this.deskripsi_id,
    this.deskripsi_en,
    this.wilayah,
    this.warung,
    this.tag,
    this.bahan,
    this.linkGmaps,
    this.foto,
    this.linkVideo,
  });

  factory Kuliner.fromJson(Map<String, dynamic> json) => Kuliner(
        id: json['id'] as int,
        nama_makanan: json['nama_makanan'] as String? ?? '',
        lokasi: json['lokasi'] as String? ?? '',
        deskripsi_id: json['deskripsi_id'] as String? ?? '',
        deskripsi_en: json['deskripsi_en'] as String?,
        wilayah: json['wilayah'] as String?,
        warung: json['warung'] as String?,
        tag: json['tag'] as String?,
        bahan: json['bahan'] as String?,
        linkGmaps: json['link_gmaps'] as String?,
        foto: json['foto'] as String?,
        linkVideo: json['link_video'] as String?,
      );

  final int id;
  final String nama_makanan;
  final String lokasi;
  final String deskripsi_id;
  final String? deskripsi_en;
  final String? wilayah;
  final String? warung;
  final String? tag;
  final String? bahan;
  final String? linkGmaps;
  final String? foto;
  final String? linkVideo;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_makanan': nama_makanan,
        'lokasi': lokasi,
        'deskripsi_id': deskripsi_id,
        'deskripsi_en': deskripsi_en,
        'wilayah': wilayah,
        'warung': warung,
        'tag': tag,
        'bahan': bahan,
        'link_gmaps': linkGmaps,
        'foto': foto,
        'link_video': linkVideo,
      };
}
