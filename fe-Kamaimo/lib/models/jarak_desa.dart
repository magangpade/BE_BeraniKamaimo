/// Model JarakDesa (cara akses ke desa wisata).
class JarakDesa {
  const JarakDesa({
    required this.id,
    required this.desaId,
    required this.titikKota,
    required this.jalur_darat,
    required this.jalur_laut,
    required this.jalur_udara,
  });

  factory JarakDesa.fromJson(Map<String, dynamic> json) => JarakDesa(
        id: json['id'] as int,
        desaId: json['desaId'] as int,
        titikKota: json['titikKota'] as String, // PALU | LUWUK
        jalur_darat: json['jalur_darat'] as String,
        jalur_laut: json['jalur_laut'] as String,
        jalur_udara: json['jalur_udara'] as String,
      );

  final int id;
  final int desaId;
  final String titikKota;
  final String jalur_darat;
  final String jalur_laut;
  final String jalur_udara;

  Map<String, dynamic> toJson() => {
        'id': id,
        'desaId': desaId,
        'titikKota': titikKota,
        'jalur_darat': jalur_darat,
        'jalur_laut': jalur_laut,
        'jalur_udara': jalur_udara,
      };
}
