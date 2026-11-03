/// Model AdminUser.
class AdminUser {
  const AdminUser({
    required this.id,
    required this.nama_Lengkap,
    required this.username,
    this.password,
    required this.jenis_kelamin,
    required this.role,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) => AdminUser(
        id: json['id'] as int,
        nama_Lengkap: json['nama_Lengkap'] as String,
        username: json['username'] as String,
        password: json['password'] as String?,
        jenis_kelamin: json['jenis_kelamin'] as String,
        role: json['role'] as String, // Admin | superAdmin
      );

  final int id;
  final String nama_Lengkap;
  final String username;
  final String? password;
  final String jenis_kelamin;
  final String role;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_Lengkap': nama_Lengkap,
        'username': username,
        'password': password,
        'jenis_kelamin': jenis_kelamin,
        'role': role,
      };
}
