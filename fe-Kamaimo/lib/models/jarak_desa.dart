/// Model JarakDesa (cara akses ke desa wisata).
class JarakDesa {
  const JarakDesa({
    required this.id,
    required this.desaId,
    required this.titikKota,
    required this.jalur_darat,
    required this.jalur_laut,
    required this.jalur_udara,
    this.laut = const JalurInfo(),
    this.darat = const JalurInfo(),
    this.udara = const JalurInfo(),
  });

  factory JarakDesa.fromJson(Map<String, dynamic> json) => JarakDesa(
    id: json['id'] as int,
    desaId: json['desaId'] as int,
    titikKota: json['titikKota'] as String, // PALU | LUWUK
    jalur_darat: json['jalur_darat'] as String,
    jalur_laut: json['jalur_laut'] as String,
    jalur_udara: json['jalur_udara'] as String,
    laut: JalurInfo.fromJson(json, 'jalur_laut'),
    darat: JalurInfo.fromJson(json, 'jalur_darat'),
    udara: JalurInfo.fromJson(json, 'jalur_udara'),
  );

  final int id;
  final int desaId;
  final String titikKota;
  final String jalur_darat;
  final String jalur_laut;
  final String jalur_udara;
  final JalurInfo laut;
  final JalurInfo darat;
  final JalurInfo udara;

  Map<String, dynamic> toJson() => {
    'id': id,
    'desaId': desaId,
    'titikKota': titikKota,
    'jalur_darat': jalur_darat,
    'jalur_laut': jalur_laut,
    'jalur_udara': jalur_udara,
    ...laut.toJson('jalur_laut'),
    ...darat.toJson('jalur_darat'),
    ...udara.toJson('jalur_udara'),
  };
}

/// Informasi tambahan pada masing-masing kartu rute halaman pengguna.
class JalurInfo {
  const JalurInfo({
    this.deskripsiEn,
    this.judul,
    this.judulEn,
    this.durasi,
    this.biaya,
  });

  factory JalurInfo.fromJson(Map<String, dynamic> json, String prefix) =>
      JalurInfo(
        deskripsiEn: json['${prefix}_en'] as String?,
        judul: json['${prefix}_judul'] as String?,
        judulEn: json['${prefix}_judul_en'] as String?,
        durasi: json['${prefix}_durasi'] as String?,
        biaya: json['${prefix}_biaya'] as String?,
      );

  final String? deskripsiEn;
  final String? judul;
  final String? judulEn;
  final String? durasi;
  final String? biaya;

  Map<String, dynamic> toJson(String prefix) => {
    '${prefix}_en': deskripsiEn,
    '${prefix}_judul': judul,
    '${prefix}_judul_en': judulEn,
    '${prefix}_durasi': durasi,
    '${prefix}_biaya': biaya,
  };
}
