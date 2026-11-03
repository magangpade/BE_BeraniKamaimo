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
    this.foto,
    this.linkVideo,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json['id'] as int,
        nama_hotel: json['nama_hotel'] as String,
        telepon: json['telepon'] as String,
        jumlah_kamar: json['jumlah_kamar'] as int,
        jumlah_tempatTidur: json['jumlah_tempatTidur'] as int,
        harga_minimum: json['harga_minimum'] as int,
        harga_maximum: json['harga_maximum'] as int,
        website: json['website'] as String,
        linkGmaps: json['link_gmaps'] as String,
        lokasi: json['lokasi'] as String,
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
        'foto': foto,
        'link_video': linkVideo,
      };
}
