/// Model Ulasan.
class Ulasan {
  const Ulasan({
    required this.id,
    required this.nama,
    required this.rating,
    required this.komentar,
    required this.createdAt,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
        id: json['id'] as int,
        nama: json['nama'] as String,
        rating: json['rating'] as int,
        komentar: json['komentar'] as String,
        createdAt: json['createdAt'] as String,
      );

  final int id;
  final String nama;
  final int rating; // 1-5
  final String komentar;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'rating': rating,
        'komentar': komentar,
        'createdAt': createdAt,
      };
}
