import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/config/env.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';

class DesaPhoto {
  const DesaPhoto(this.name, this.bytes);

  final String name;
  final Uint8List bytes;
}

/// Form Desa Wisata mengikuti data kartu dan detail yang dilihat pengunjung.
class DesaWisataFormDialog extends StatefulWidget {
  const DesaWisataFormDialog({
    super.key,
    required this.api,
    required this.onSave,
    this.row,
    this.pickPhoto,
  });

  final ApiClient api;
  final Map<String, dynamic>? row;
  final Future<void> Function(Map<String, dynamic>) onSave;
  final Future<DesaPhoto?> Function()? pickPhoto;

  @override
  State<DesaWisataFormDialog> createState() => _DesaWisataFormDialogState();
}

class _DesaWisataFormDialogState extends State<DesaWisataFormDialog> {
  static const _center = LatLng(-1.43, 121.445);
  static const _maxPhotoSize = 5 * 1024 * 1024;
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};
  late String _jenisDesa;
  late String _kategori;
  LatLng? _location;
  Uint8List? _photoBytes;
  String? _photoName;
  bool _saving = false;
  String? _error;

  static const _textFields = <String>[
    'namaDesa_id',
    'namaDesa_en',
    'lokasi_id',
    'lokasi_en',
    'deskripsi_id',
    'deskripsi_en',
    'link_video',
  ];

  @override
  void initState() {
    super.initState();
    for (final key in _textFields) {
      _controllers[key] = TextEditingController(
        text: widget.row?[key]?.toString() ?? '',
      );
    }
    _jenisDesa = widget.row?['jenisDesa']?.toString() ?? 'DESA_WISATA';
    _kategori = widget.row?['kategori']?.toString() ?? 'EKOWISATA';
    final latitude = double.tryParse(widget.row?['latitude']?.toString() ?? '');
    final longitude = double.tryParse(
      widget.row?['longitude']?.toString() ?? '',
    );
    if (latitude != null &&
        longitude != null &&
        latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180) {
      _location = LatLng(latitude, longitude);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _choosePhoto() async {
    try {
      final photo = await (widget.pickPhoto ?? _pickSystemPhoto)();
      if (photo == null) return;
      if (!mounted) return;
      if (photo.bytes.length > _maxPhotoSize) {
        setState(() => _error = 'Ukuran foto maksimal 5 MB.');
        return;
      }
      setState(() {
        _photoBytes = photo.bytes;
        _photoName = photo.name;
        _error = null;
      });
    } catch (error) {
      if (mounted) {
        setState(
          () => _error = error is FormatException
              ? error.message
              : 'Gagal membuka foto. Coba lagi.',
        );
      }
    }
  }

  Future<DesaPhoto?> _pickSystemPhoto() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp'],
    );
    if (file == null) return null;
    final length = file.lengthSync() ?? await file.length();
    if (length != null && length > _maxPhotoSize) {
      throw const FormatException('Ukuran foto maksimal 5 MB.');
    }
    return DesaPhoto(file.name, await file.readAsBytes());
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_location == null) {
      setState(() => _error = 'Pilih titik lokasi pada peta.');
      return;
    }
    final oldPhoto = widget.row?['foto']?.toString().trim() ?? '';
    if (widget.row == null && _photoBytes == null && oldPhoto.isEmpty) {
      setState(() => _error = 'Unggah foto desa wisata.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final body = <String, dynamic>{};
      for (final key in _textFields) {
        final value = _controllers[key]!.text.trim();
        if (widget.row == null ||
            value != (widget.row?[key]?.toString().trim() ?? '')) {
          body[key] = value;
        }
      }
      if (widget.row == null ||
          _jenisDesa != (widget.row?['jenisDesa'] ?? 'DESA_WISATA')) {
        body['jenisDesa'] = _jenisDesa;
      }
      if (widget.row == null ||
          _kategori != (widget.row?['kategori'] ?? 'EKOWISATA')) {
        body['kategori'] = _kategori;
      }
      final oldLatitude = double.tryParse(
        widget.row?['latitude']?.toString() ?? '',
      );
      final oldLongitude = double.tryParse(
        widget.row?['longitude']?.toString() ?? '',
      );
      if (oldLatitude != _location!.latitude ||
          oldLongitude != _location!.longitude) {
        body['latitude'] = _location!.latitude;
        body['longitude'] = _location!.longitude;
      }
      if (_photoBytes != null) {
        body['foto'] = await widget.api.uploadDesaPhoto(
          filename: _photoName!,
          bytes: _photoBytes!,
        );
      }
      if (body.isEmpty) {
        setState(() => _error = 'Belum ada perubahan untuk disimpan.');
        return;
      }
      await widget.onSave(body);
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (mounted) {
        setState(
          () => _error = error is ApiException
              ? error.userMessage
              : 'Gagal menyimpan desa wisata. Coba lagi.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _textField(
    String key,
    String label, {
    bool required = false,
    int lines = 1,
  }) {
    return TextFormField(
      key: Key('admin-field-$key'),
      controller: _controllers[key],
      enabled: !_saving,
      maxLines: lines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => required && (value?.trim().isEmpty ?? true)
          ? '$label wajib diisi'
          : null,
    );
  }

  Widget _section(String title, List<Widget> fields) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 12),
      for (final field in fields) ...[field, const SizedBox(height: 12)],
    ],
  );

  Widget _photoPreview() {
    if (_photoBytes != null) {
      return Image.memory(
        _photoBytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 160,
      );
    }
    final source = widget.row?['foto']?.toString() ?? '';
    if (source.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Icon(Icons.image_outlined, size: 48)),
      );
    }
    if (source.startsWith('assets/')) {
      return Image.asset(
        source,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 160,
        errorBuilder: (_, _, _) => const SizedBox(
          height: 150,
          child: Icon(Icons.broken_image_outlined),
        ),
      );
    }
    final url = source.startsWith('/') ? '${Env.serverBaseUrl}$source' : source;
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 160,
      errorBuilder: (_, _, _) =>
          const SizedBox(height: 150, child: Icon(Icons.broken_image_outlined)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AlertDialog(
      title: Text(
        widget.row == null ? 'Tambah Desa Wisata' : 'Edit Desa Wisata',
      ),
      content: SizedBox(
        width: width < 760 ? width - 80 : 720,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * .72,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _section('Identitas desa', [
                    _textField(
                      'namaDesa_id',
                      'Nama desa (Indonesia)',
                      required: true,
                    ),
                    _textField('namaDesa_en', 'Nama desa (Inggris)'),
                    DropdownButtonFormField<String>(
                      key: const Key('admin-field-jenisDesa'),
                      initialValue: _jenisDesa,
                      decoration: const InputDecoration(
                        labelText: 'Jenis desa',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'DESA_WISATA',
                          child: Text('Desa Wisata'),
                        ),
                        DropdownMenuItem(
                          value: 'DESA_UNGGULAN',
                          child: Text('Desa Unggulan'),
                        ),
                      ],
                      onChanged: _saving
                          ? null
                          : (value) => setState(() => _jenisDesa = value!),
                    ),
                    DropdownButtonFormField<String>(
                      key: const Key('admin-field-kategori'),
                      initialValue: _kategori,
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'EKOWISATA',
                          child: Text('Ekowisata'),
                        ),
                        DropdownMenuItem(
                          value: 'BUDAYA',
                          child: Text('Budaya'),
                        ),
                        DropdownMenuItem(
                          value: 'BAHARI',
                          child: Text('Bahari'),
                        ),
                        DropdownMenuItem(value: 'UMKM', child: Text('UMKM')),
                      ],
                      onChanged: _saving
                          ? null
                          : (value) => setState(() => _kategori = value!),
                    ),
                  ]),
                  _section('Konten halaman pengguna', [
                    _textField(
                      'deskripsi_id',
                      'Deskripsi (Indonesia)',
                      required: true,
                      lines: 4,
                    ),
                    _textField('deskripsi_en', 'Deskripsi (Inggris)', lines: 4),
                    _textField('link_video', 'Tautan video'),
                  ]),
                  _section('Foto utama', [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _photoPreview(),
                    ),
                    OutlinedButton.icon(
                      key: const Key('admin-pick-photo'),
                      onPressed: _saving ? null : _choosePhoto,
                      icon: const Icon(Icons.upload_file),
                      label: Text(
                        _photoName ??
                            'Unggah foto JPG, PNG, atau WebP (maks. 5 MB)',
                      ),
                    ),
                  ]),
                  _section('Lokasi desa', [
                    _textField(
                      'lokasi_id',
                      'Alamat/lokasi (Indonesia)',
                      required: true,
                    ),
                    _textField('lokasi_en', 'Alamat/lokasi (Inggris)'),
                    const Text(
                      'Ketuk peta untuk memilih titik lokasi yang tampil kepada pengunjung.',
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        key: const Key('admin-location-map'),
                        height: 240,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: _location ?? _center,
                            initialZoom: _location == null ? 7 : 12,
                            onTap: (_, point) =>
                                setState(() => _location = point),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.berani.kamaimo',
                            ),
                            if (_location != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _location!,
                                    width: 42,
                                    height: 42,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: AppColors.pine700,
                                      size: 42,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      _location == null
                          ? 'Belum ada titik yang dipilih'
                          : 'Koordinat: ${_location!.latitude.toStringAsFixed(6)}, ${_location!.longitude.toStringAsFixed(6)}',
                    ),
                  ]),
                  if (_error != null)
                    Text(
                      _error!,
                      style: const TextStyle(color: AppColors.error),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          key: const Key('admin-save'),
          onPressed: _saving ? null : _save,
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
