/// Model Ulasan.
class Ulasan {
  const Ulasan({
    required this.id,
    required this.nama,
    required this.rating,
    required this.komentar,
    required this.createdAt,
    this.desaId,
    this.balasanAdmin,
    this.balasanAt,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
        id: json['id'] as int? ?? 0,
        nama: json['nama'] as String? ?? 'Wisatawan',
        rating: (json['rating'] as num?)?.toInt() ?? 5,
        komentar: json['komentar'] as String? ?? '',
        createdAt: json['createdAt']?.toString() ?? '',
        desaId: json['desaId'] as int?,
        balasanAdmin: (json['balasan_admin'] ?? json['balasanAdmin']) as String?,
        balasanAt: (json['balasan_at'] ?? json['balasanAt'])?.toString(),
      );

  final int id;
  final String nama;
  final int rating; // 1-5
  final String komentar;
  final String createdAt;
  final int? desaId;
  final String? balasanAdmin;
  final String? balasanAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'rating': rating,
        'komentar': komentar,
        'createdAt': createdAt,
        if (desaId != null) 'desaId': desaId,
        if (balasanAdmin != null) 'balasan_admin': balasanAdmin,
        if (balasanAt != null) 'balasan_at': balasanAt,
      };
}
