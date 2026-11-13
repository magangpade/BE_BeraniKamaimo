import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../data/admin_form_fields.dart';
import '../data/admin_content.dart';
import '../data/sulteng_regions.dart';

class AdminEntityFormDialog extends StatefulWidget {
  const AdminEntityFormDialog({
    super.key,
    required this.title,
    required this.entityType,
    required this.onSave,
    required this.api,
    this.row,
  });

  final String title;
  final String entityType;
  final Map<String, dynamic>? row;
  final Future<void> Function(Map<String, dynamic> body) onSave;
  final ApiClient api;

  @override
  State<AdminEntityFormDialog> createState() => _AdminEntityFormDialogState();
}

class _AdminEntityFormDialogState extends State<AdminEntityFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};
  late final List<AdminFormField> _fields;
  bool _saving = false;
  String? _error;
  Uint8List? _photoBytes;
  String? _photoName;
  LatLng? _mapPoint;
  List<Map<String, dynamic>> _kuliners = [];
  final _programs = <Map<String, dynamic>>[];
  final _days = <Map<String, dynamic>>[];
  final _organizer = TextEditingController();
  final _access = TextEditingController();

  List<dynamic> _readList(String key) {
    try {
      final value = jsonDecode('${widget.row?[key] ?? '[]'}');
      return value is List ? value : [];
    } catch (_) {
      return [];
    }
  }

  String? get _imageKey => widget.entityType == 'tourPackage'
      ? 'media'
      : [
          'atraksi',
          'kuliner',
          'hotel',
          'rumahMakan',
        ].contains(widget.entityType)
      ? 'foto'
      : null;
  String? get _mapKey => widget.entityType == 'atraksi'
      ? 'maps_url'
      : [
          'tourPackage',
          'kuliner',
          'hotel',
          'rumahMakan',
        ].contains(widget.entityType)
      ? 'link_gmaps'
      : null;

  String _initial(AdminFormField field) {
    final value = widget.row?[field.key];
    if (value == null) return '';
    final text = value.toString();
    return field.date && text.length >= 10 ? text.substring(0, 10) : text;
  }

  @override
  void initState() {
    super.initState();
    _fields = AdminFormFields.forEntity(widget.entityType, widget.row);
    for (final field in _fields) {
      _controllers[field.key] = TextEditingController(text: _initial(field));
    }
    if (widget.entityType == 'rumahMakan') _loadKuliners();
    if (widget.entityType == 'atraksi') {
      _programs.addAll(
        _readList('program_json')
            .whereType<Map>()
            .map((value) => Map<String, dynamic>.from(value)),
      );
      _days.addAll(
        _readList('rundown_json')
            .whereType<Map>()
            .map((value) => Map<String, dynamic>.from(value)),
      );
      _organizer.text = _readList('organizer_json').join('\n');
      _access.text = _readList('akses_json')
          .whereType<Map>()
          .map((item) => '${item['title'] ?? ''}|${item['detail'] ?? ''}')
          .join('\n');
    }
    final latitude = double.tryParse('${widget.row?['latitude'] ?? ''}');
    final longitude = double.tryParse('${widget.row?['longitude'] ?? ''}');
    if (latitude != null && longitude != null)
      _mapPoint = LatLng(latitude, longitude);
  }

  Future<void> _loadKuliners() async {
    try {
      final rows = await AdminContent.load(widget.api, 'kuliner');
      if (mounted) setState(() => _kuliners = rows);
    } catch (_) {
      if (mounted) setState(() => _error = 'Daftar kuliner gagal dimuat.');
    }
  }

  Future<void> _pickPhoto() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp'],
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.length > 5 * 1024 * 1024)
        throw const FormatException('Gambar maksimal 5 MB.');
      if (mounted)
        setState(() {
          _photoName = file.name;
          _photoBytes = bytes;
          _error = null;
        });
    } catch (error) {
      if (mounted)
        setState(
          () => _error = error is FormatException
              ? error.message
              : 'Gagal memilih gambar.',
        );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _organizer.dispose();
    _access.dispose();
    super.dispose();
  }

  String? _validate(AdminFormField field, String? value) {
    final text = value?.trim() ?? '';
    if (field.required && text.isEmpty) return '${field.label} wajib diisi';
    if (text.isEmpty) return null;
    if (field.number && int.tryParse(text) == null) return 'Isi angka bulat';
    if (field.decimal && double.tryParse(text) == null) {
      return 'Isi angka yang valid';
    }
    if (field.date &&
        (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(text) ||
            DateTime.tryParse(text) == null)) {
      return 'Gunakan format YYYY-MM-DD';
    }
    if (field.key == 'rating' && (int.parse(text) < 1 || int.parse(text) > 5)) {
      return 'Rating harus 1 sampai 5';
    }
    if ((field.key == 'desaId' || field.key == 'kulinerId') &&
        int.parse(text) <= 0) {
      return 'ID harus lebih dari 0';
    }
    return null;
  }

  Future<void> _pickDate(AdminFormField field) async {
    final current = DateTime.tryParse(_controllers[field.key]!.text);
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );
    if (selected != null) {
      _controllers[field.key]!.text =
          '${selected.year.toString().padLeft(4, '0')}-'
          '${selected.month.toString().padLeft(2, '0')}-'
          '${selected.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.row == null &&
        _controllers.containsKey('wilayah') &&
        _controllers['wilayah']!.text.trim().isEmpty) {
      setState(() => _error = 'Pilih atau isi wilayah Sulawesi Tengah.');
      return;
    }
    if (widget.row == null &&
        [
          'atraksi',
          'kuliner',
          'hotel',
          'tourPackage',
        ].contains(widget.entityType) &&
        _photoBytes == null &&
        (_imageKey == null || _controllers[_imageKey!]!.text.trim().isEmpty)) {
      setState(() => _error = 'Unggah gambar utama atau isi URL gambar.');
      return;
    }
    if (widget.row == null &&
        widget.entityType == 'hotel' &&
        [
          'lokasi',
          'telepon',
          'jumlah_kamar',
          'jumlah_tempatTidur',
          'harga_minimum',
          'link_gmaps',
        ].any((key) => _controllers[key]!.text.trim().isEmpty)) {
      setState(
        () => _error = 'Isi alamat, kontak, jumlah kamar/tempat tidur, harga, dan titik peta hotel.',
      );
      return;
    }
    if (widget.entityType == 'tourPackage' &&
        _controllers['fasilitas']!.text
                .split(',')
                .where((value) => value.trim().isNotEmpty)
                .length >
            4) {
      setState(
        () => _error = 'Kartu paket menampilkan maksimal empat fasilitas.',
      );
      return;
    }
    if (widget.entityType == 'atraksi') {
      final start = DateTime.parse(_controllers['startdate']!.text.trim());
      final end = DateTime.parse(_controllers['enddate']!.text.trim());
      if (end.isBefore(start)) {
        setState(() => _error = 'Tanggal selesai harus setelah tanggal mulai.');
        return;
      }
      if (widget.row == null &&
          (_programs.isEmpty ||
              _days.isEmpty ||
              _days.any((day) => (day['items'] as List).isEmpty))) {
        setState(
          () =>
              _error = 'Isi minimal satu program dan rundown pada setiap hari.',
        );
        return;
      }
    }
    final body = <String, dynamic>{};
    for (final field in _fields) {
      final text = _controllers[field.key]!.text.trim();
      if (widget.row == null && text.isEmpty) continue;
      if (widget.row != null && text == _initial(field)) continue;
      body[field.key] = field.number
          ? (text.isEmpty ? null : int.parse(text))
          : field.decimal
          ? (text.isEmpty ? null : double.parse(text))
          : text;
    }
    if (_mapPoint != null && widget.entityType == 'atraksi') {
      body['latitude'] = _mapPoint!.latitude;
      body['longitude'] = _mapPoint!.longitude;
    }
    if (body.isEmpty && _photoBytes == null && widget.entityType != 'atraksi') {
      setState(() => _error = 'Belum ada perubahan untuk disimpan.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      if (_photoBytes != null && _imageKey != null) {
        body[_imageKey!] = await widget.api.uploadImage(
          filename: _photoName!,
          bytes: _photoBytes!,
        );
      }
      if (widget.entityType == 'atraksi') {
        final programs = <Map<String, String>>[];
        for (final program in _programs) {
          var image = '${program['image'] ?? ''}';
          if (program['bytes'] is Uint8List) {
            image = await widget.api.uploadImage(
              filename: '${program['filename']}',
              bytes: program['bytes'] as Uint8List,
            );
          }
          programs.add({
            'title': '${program['title'] ?? ''}'.trim(),
            'title_en': '${program['title_en'] ?? ''}'.trim(),
            'description': '${program['description'] ?? ''}'.trim(),
            'description_en': '${program['description_en'] ?? ''}'.trim(),
            'image': image,
          });
        }
        body['program_json'] = jsonEncode(programs);
        body['rundown_json'] = jsonEncode(
          _days
              .map(
                (day) => {
                  'hari': day['hari'],
                  'items': (day['items'] as List)
                      .map((item) => Map<String, dynamic>.from(item as Map))
                      .toList(),
                },
              )
              .toList(),
        );
        body['organizer_json'] = jsonEncode(
          _organizer.text
              .split('\n')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList(),
        );
        body['akses_json'] = jsonEncode(
          _access.text.split('\n').where((s) => s.trim().isNotEmpty).map((s) {
            final parts = s.split('|');
            return {
              'title': parts.first.trim(),
              'detail': parts.skip(1).join('|').trim(),
            };
          }).toList(),
        );
      }
      await widget.onSave(body);
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error is ApiException
            ? error.userMessage
            : 'Gagal menyimpan data. Coba lagi.';
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _field(AdminFormField field) {
    final controller = _controllers[field.key]!;
    if (field.key == 'kulinerId' && _kuliners.isNotEmpty) {
      final selected = int.tryParse(controller.text);
      return DropdownButtonFormField<int>(
        key: const Key('admin-field-kulinerId'),
        initialValue: _kuliners.any((k) => k['id'] == selected)
            ? selected
            : null,
        decoration: const InputDecoration(
          labelText: 'Kuliner terkait',
          border: OutlineInputBorder(),
        ),
        items: _kuliners
            .map(
              (k) => DropdownMenuItem<int>(
                value: k['id'] as int,
                child: Text(
                  '${k['nama_makanan']}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: _saving
            ? null
            : (value) => controller.text = '${value ?? ''}',
        validator: (value) => value == null ? 'Pilih kuliner terkait' : null,
      );
    }
    if (field.options.isNotEmpty) {
      final options = [...field.options];
      if (controller.text.isNotEmpty && !options.contains(controller.text)) {
        options.add(controller.text);
      }
      return DropdownButtonFormField<String>(
        key: Key('admin-field-${field.key}'),
        initialValue: controller.text.isEmpty ? null : controller.text,
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
        onChanged: _saving ? null : (value) => controller.text = value ?? '',
        validator: (value) => _validate(field, value),
      );
    }
    return TextFormField(
      key: Key('admin-field-${field.key}'),
      controller: controller,
      enabled: !_saving,
      maxLines: field.lines,
      keyboardType: field.number || field.decimal
          ? const TextInputType.numberWithOptions(decimal: true, signed: true)
          : field.lines > 1
          ? TextInputType.multiline
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: field.label,
        hintText: field.date
            ? 'YYYY-MM-DD'
            : field.key == 'wilayah'
            ? 'Contoh: Poso, Sigi, Banggai'
            : null,
        border: const OutlineInputBorder(),
        suffixIcon: field.date
            ? IconButton(
                onPressed: () => _pickDate(field),
                icon: const Icon(Icons.date_range),
              )
            : null,
      ),
      validator: (value) => _validate(field, value),
    );
  }

  Future<void> _pickProgramImage(int index) async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp'],
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.length > 5 * 1024 * 1024)
        throw const FormatException('Gambar maksimal 5 MB.');
      if (mounted)
        setState(() {
          _programs[index]['bytes'] = bytes;
          _programs[index]['filename'] = file.name;
        });
    } catch (error) {
      if (mounted)
        setState(
          () => _error = error is FormatException
              ? error.message
              : 'Gagal memilih gambar program.',
        );
    }
  }

  Widget _eventDetailsEditor() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: 14),
      const Text(
        'Rangkaian Program Utama',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      for (var i = 0; i < _programs.length; i++)
        Card(
          key: ValueKey('program-$i'),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  key: Key('admin-program-$i-title'),
                  initialValue: '${_programs[i]['title'] ?? ''}',
                  decoration: InputDecoration(labelText: 'Program ${i + 1}'),
                  onChanged: (value) => _programs[i]['title'] = value,
                  validator: (value) =>
                      value?.trim().isEmpty == true ? 'Isi nama program' : null,
                ),
                TextFormField(
                  key: Key('admin-program-$i-description'),
                  initialValue: '${_programs[i]['description'] ?? ''}',
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi program',
                  ),
                  onChanged: (value) => _programs[i]['description'] = value,
                ),
                TextFormField(
                  key: Key('admin-program-$i-title-en'),
                  initialValue: '${_programs[i]['title_en'] ?? ''}',
                  decoration: const InputDecoration(
                    labelText: 'Nama program (Inggris)',
                  ),
                  onChanged: (value) => _programs[i]['title_en'] = value,
                ),
                TextFormField(
                  key: Key('admin-program-$i-description-en'),
                  initialValue: '${_programs[i]['description_en'] ?? ''}',
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi program (Inggris)',
                  ),
                  onChanged: (value) => _programs[i]['description_en'] = value,
                ),
                OutlinedButton.icon(
                  onPressed: () => _pickProgramImage(i),
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    '${_programs[i]['filename'] ?? _programs[i]['image'] ?? 'Unggah foto program'}',
                  ),
                ),
                TextButton.icon(
                  onPressed: () => setState(() => _programs.removeAt(i)),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Hapus program'),
                ),
              ],
            ),
          ),
        ),
      OutlinedButton.icon(
        onPressed: () => setState(
          () => _programs.add({'title': '', 'description': '', 'image': ''}),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Tambah program'),
      ),
      const SizedBox(height: 16),
      const Text(
        'Jadwal & Rundown',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      const Text(
        'Buat hari sesuai rentang tanggal event. Countdown mengikuti tanggal mulai.',
      ),
      for (var dayIndex = 0; dayIndex < _days.length; dayIndex++)
        Card(
          key: ValueKey('day-$dayIndex'),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  key: Key('admin-day-$dayIndex'),
                  initialValue: '${_days[dayIndex]['hari'] ?? ''}',
                  decoration: InputDecoration(
                    labelText: 'Hari ${dayIndex + 1} (contoh: Hari 1 (20 Okt))',
                  ),
                  onChanged: (value) => _days[dayIndex]['hari'] = value,
                  validator: (value) =>
                      value?.trim().isEmpty == true ? 'Isi label hari' : null,
                ),
                for (
                  var slotIndex = 0;
                  slotIndex < (_days[dayIndex]['items'] as List).length;
                  slotIndex++
                )
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          'Agenda ${slotIndex + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        for (final entry in const [
                          ('jam', 'Jam (contoh: 08.30 – 11.30 WITA)'),
                          ('chip', 'Area/panggung'),
                          ('judul', 'Nama kegiatan'),
                          ('deskripsi', 'Deskripsi kegiatan'),
                          ('judul_en', 'Nama kegiatan (Inggris)'),
                          ('deskripsi_en', 'Deskripsi kegiatan (Inggris)'),
                        ])
                          TextFormField(
                            key: ValueKey(
                              'day-$dayIndex-slot-$slotIndex-${entry.$1}',
                            ),
                            initialValue:
                                '${(_days[dayIndex]['items'] as List)[slotIndex][entry.$1] ?? ''}',
                            maxLines: entry.$1 == 'deskripsi' ? 2 : 1,
                            decoration: InputDecoration(labelText: entry.$2),
                            onChanged: (value) =>
                                (_days[dayIndex]['items']
                                        as List)[slotIndex][entry.$1] =
                                    value,
                            validator: (value) =>
                                !entry.$1.endsWith('_en') &&
                                    value?.trim().isEmpty == true
                                ? '${entry.$2} wajib diisi'
                                : null,
                          ),
                        TextButton(
                          onPressed: () => setState(
                            () => (_days[dayIndex]['items'] as List).removeAt(
                              slotIndex,
                            ),
                          ),
                          child: const Text('Hapus agenda'),
                        ),
                      ],
                    ),
                  ),
                OutlinedButton.icon(
                  onPressed: () => setState(() {
                    final slots = _days[dayIndex]['items'] as List;
                    final color = ['mint', 'slate', 'earth'][slots.length % 3];
                    slots.add({
                      'jam': '',
                      'chip': '',
                      'judul': '',
                      'deskripsi': '',
                      'chipColor': color,
                      'dotColor': color == 'earth' ? 'earth' : 'mint',
                    });
                  }),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah agenda'),
                ),
                TextButton(
                  onPressed: () => setState(() => _days.removeAt(dayIndex)),
                  child: const Text('Hapus hari'),
                ),
              ],
            ),
          ),
        ),
      OutlinedButton.icon(
        onPressed: () => setState(
          () => _days.add({
            'hari': 'Hari ${_days.length + 1}',
            'items': <Map<String, dynamic>>[],
          }),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Tambah hari'),
      ),
      const SizedBox(height: 14),
      TextFormField(
        controller: _access,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Akses perjalanan (satu per baris: Asal|Keterangan)',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _organizer,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Penyelenggara (satu per baris)',
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );

  Widget _mediaAndMap() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (_imageKey != null) ...[
        const Text(
          'Gambar utama',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        if (_photoBytes != null)
          Image.memory(_photoBytes!, height: 150, fit: BoxFit.cover),
        OutlinedButton.icon(
          key: const Key('admin-pick-photo'),
          onPressed: _saving ? null : _pickPhoto,
          icon: const Icon(Icons.upload_file),
          label: Text(_photoName ?? 'Unggah JPG, PNG, atau WebP (maks. 5 MB)'),
        ),
      ],
      if (_mapKey != null) ...[
        const SizedBox(height: 16),
        const Text(
          'Titik lokasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text(
          'Ketuk peta untuk mengisi tautan Google Maps. Nama alamat tetap diisi pada kolom lokasi.',
        ),
        SizedBox(
          key: const Key('admin-location-map'),
          height: 220,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: _mapPoint ?? const LatLng(-1.43, 121.445),
              initialZoom: _mapPoint == null ? 7 : 12,
              onTap: (_, point) => setState(() {
                _mapPoint = point;
                _controllers[_mapKey!]!.text =
                    'https://www.google.com/maps/search/?api=1&query=${point.latitude},${point.longitude}';
              }),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.berani.kamaimo',
              ),
              if (_mapPoint != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _mapPoint!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Color(0xFF2E5C43),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (_mapPoint != null)
          Text(
            'Koordinat: ${_mapPoint!.latitude.toStringAsFixed(6)}, ${_mapPoint!.longitude.toStringAsFixed(6)}',
          ),
      ],
      if (_fields.any((f) => f.key == 'wilayah')) ...[
        const SizedBox(height: 12),
        const Text('Pilihan wilayah Sulawesi Tengah:'),
        Wrap(
          spacing: 6,
          children: [
            for (final region in sultengRegions)
              ActionChip(
                label: Text(region),
                onPressed: () =>
                    setState(() => _controllers['wilayah']!.text = region),
              ),
          ],
        ),
      ],
    ],
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.row == null ? 'Tambah' : 'Edit'} ${widget.title}'),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width < 560
            ? double.maxFinite
            : 480,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.65,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final field in _fields) ...[
                    _field(field),
                    const SizedBox(height: 12),
                  ],
                  _mediaAndMap(),
                  if (widget.entityType == 'atraksi') _eventDetailsEditor(),
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
