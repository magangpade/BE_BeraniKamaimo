import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../models/admin_user.dart';

class ProfilDialog extends StatefulWidget {
  final AdminUser user;
  final VoidCallback onLogout;
  final ValueChanged<AdminUser>? onUpdated;

  const ProfilDialog({
    super.key,
    required this.user,
    required this.onLogout,
    this.onUpdated,
  });

  @override
  State<ProfilDialog> createState() => _ProfilDialogState();
}

class _ProfilDialogState extends State<ProfilDialog> {
  late TextEditingController _namaCtrl;
  late TextEditingController _userCtrl;
  final _passCtrl = TextEditingController();
  late String _gender;
  bool _obscure = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.user.nama_Lengkap);
    _userCtrl = TextEditingController(text: widget.user.username);
    final rawGender = widget.user.jenis_kelamin.toLowerCase();
    _gender = (rawGender == 'p' || rawGender.contains('perempuan'))
        ? 'Perempuan'
        : 'Laki-laki';
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final changedPassword = _passCtrl.text.trim().isNotEmpty;

    final auth = context.read<AuthRepository>();
    final updated = await auth.updateProfile(
      namaLengkap: _namaCtrl.text.trim().isEmpty
          ? widget.user.nama_Lengkap
          : _namaCtrl.text.trim(),
      jenisKelamin: _gender,
      password: changedPassword ? _passCtrl.text.trim() : null,
    );

    if (!mounted) return;
    widget.onUpdated?.call(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          changedPassword
              ? 'Password diperbarui. Silakan login kembali.'
              : 'Profil berhasil diperbarui.',
        ),
        backgroundColor: AppColors.pine700,
      ),
    );

    Navigator.of(context).pop();

    if (changedPassword) {
      widget.onLogout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: _gender == 'Laki-laki'
                        ? AppColors.pine600
                        : Colors.pink.shade700,
                    child: Text(
                      widget.user.nama_Lengkap.isNotEmpty
                          ? widget.user.nama_Lengkap[0].toUpperCase()
                          : 'A',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profil Pengguna',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'PlusJakartaSans',
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Role: ${widget.user.role}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(height: 28),
              const Text('Nama Lengkap',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans')),
              const SizedBox(height: 6),
              TextField(
                controller: _namaCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 14),
              const Text('Username',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans')),
              const SizedBox(height: 6),
              TextField(
                controller: _userCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  helperText: 'Username tidak dapat diubah.',
                ),
              ),
              const SizedBox(height: 14),
              const Text('Jenis Kelamin',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans')),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                items: const [
                  DropdownMenuItem(
                      value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(
                      value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _gender = val);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 14),
              const Text('Password Baru (Kosongkan jika tidak ganti)',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PlusJakartaSans')),
              const SizedBox(height: 6),
              TextField(
                controller: _passCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.pine700,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Simpan Perubahan',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'PlusJakartaSans')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
