import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/repositories/ulasan_repository.dart';

class ReviewForm extends StatefulWidget {
  final int? desaId;
  final VoidCallback? onSubmitted;

  const ReviewForm({
    super.key,
    this.desaId,
    this.onSubmitted,
  });

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 5;
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });

    try {
      final api = context.read<ApiClient>();
      final repo = UlasanRepository(api);
      final nama = _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : 'Wisatawan';

      await repo.insertUlasan(
        nama: nama,
        rating: _rating,
        komentar: _reviewController.text.trim(),
        desaId: widget.desaId,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ulasan Anda berhasil dikirim dan tampil!'),
          backgroundColor: AppColors.pine700,
        ),
      );
      widget.onSubmitted?.call();
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = 'Gagal mengirim ulasan: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Tulis Ulasan & Pengalaman',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'PlusJakartaSans',
                    color: AppColors.pine900,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Beri Penilaian Bintang:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'PlusJakartaSans',
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final isFilled = _rating > index;
                    return IconButton(
                      icon: Icon(
                        isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                        color: isFilled ? const Color(0xFFFFB800) : Colors.grey.shade400,
                        size: 38,
                      ),
                      onPressed: _submitting ? null : () => setState(() => _rating = index + 1),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Anda (opsional)',
                  hintText: 'Contoh: Rian Kusuma',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _reviewController,
                decoration: InputDecoration(
                  labelText: 'Ulasan Anda *',
                  hintText: 'Ceritakan pengalaman liburan atau saran untuk tempat ini...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Komentar wajib diisi' : null,
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: _submitting ? null : _submitReview,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.pine700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _submitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Kirim Ulasan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
