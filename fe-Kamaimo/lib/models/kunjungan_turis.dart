/// Model KunjunganTuris (ranking asal turis).
class KunjunganTuris {
  const KunjunganTuris({
    required this.id,
    required this.negara,
    required this.jumlah,
    required this.createdAt,
  });

  factory KunjunganTuris.fromJson(Map<String, dynamic> json) =>
      KunjunganTuris(
        id: json['id'] as int,
        negara: json['negara'] as String,
        jumlah: json['jumlah'] as int,
        createdAt: json['createdAt'] as String,
      );

  final int id;
  final String negara;
  final int jumlah;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'negara': negara,
        'jumlah': jumlah,
        'createdAt': createdAt,
      };
}
