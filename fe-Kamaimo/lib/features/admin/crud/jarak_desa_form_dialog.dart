import 'package:flutter/material.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../data/admin_content.dart';
import '../data/sulteng_regions.dart';

class JarakDesaFormDialog extends StatefulWidget {
  const JarakDesaFormDialog({
    super.key,
    required this.api,
    required this.onSave,
    this.row,
  });

  final ApiClient api;
  final Map<String, dynamic>? row;
  final Future<void> Function(Map<String, dynamic>) onSave;

  @override
  State<JarakDesaFormDialog> createState() => _JarakDesaFormDialogState();
}

class _JarakDesaFormDialogState extends State<JarakDesaFormDialog> {
  final _form = GlobalKey<FormState>();
  final _inputs = <String, TextEditingController>{};
  List<Map<String, dynamic>> _villages = [];
  int? _desaId;
  String? _region;
  bool _customRegion = false;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _desaId = int.tryParse('${widget.row?['desaId'] ?? ''}');
    final originalRegion = '${widget.row?['titikKota'] ?? ''}';
    _region = sultengRegions
        .where((r) => r.toLowerCase() == originalRegion.toLowerCase())
        .firstOrNull;
    _customRegion = originalRegion.isNotEmpty && _region == null;
    _inputs['customRegion'] = TextEditingController(
      text: _customRegion ? originalRegion : '',
    );
    for (final mode in ['laut', 'darat', 'udara']) {
      for (final suffix in [
        '',
        '_en',
        '_judul',
        '_judul_en',
        '_durasi',
        '_biaya',
      ]) {
        final key = 'jalur_$mode$suffix';
        _inputs[key] = TextEditingController(text: '${widget.row?[key] ?? ''}');
      }
    }
    _loadVillages();
  }

  Future<void> _loadVillages() async {
    try {
      final villages = await AdminContent.load(widget.api, 'desaWisata');
      if (mounted) setState(() => _villages = villages);
    } catch (error) {
      if (mounted)
        setState(
          () => _error = error is ApiException
              ? error.userMessage
              : 'Gagal memuat desa wisata.',
        );
    }
  }

  @override
  void dispose() {
    for (final input in _inputs.values) {
      input.dispose();
    }
    super.dispose();
  }

  Widget _text(String key, String label, {int lines = 1}) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: TextFormField(
      key: Key('admin-field-$key'),
      controller: _inputs[key],
      maxLines: lines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    var origin = _customRegion ? _inputs['customRegion']!.text.trim() : _region;
    final original = '${widget.row?['titikKota'] ?? ''}';
    if (origin?.toLowerCase() == original.toLowerCase()) origin = original;
    if (_desaId == null || origin == null || origin.isEmpty) {
      setState(() => _error = 'Pilih desa dan wilayah asal.');
      return;
    }
    if (![
      'laut',
      'darat',
      'udara',
    ].any((mode) => _inputs['jalur_$mode']!.text.trim().isNotEmpty)) {
      setState(() => _error = 'Isi setidaknya satu deskripsi jalur.');
      return;
    }
    final body = <String, dynamic>{'desaId': _desaId, 'titikKota': origin};
    for (final entry in _inputs.entries) {
      if (entry.key == 'customRegion') continue;
      body[entry.key] = entry.value.text.trim();
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.onSave(body);
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (mounted)
        setState(
          () => _error = error is ApiException
              ? error.userMessage
              : 'Gagal menyimpan jalur desa.',
        );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.row == null ? 'Tambah Jalur Desa' : 'Edit Jalur Desa'),
    content: SizedBox(
      width: MediaQuery.sizeOf(context).width < 680 ? double.maxFinite : 600,
      height: MediaQuery.sizeOf(context).height * .7,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<int>(
                key: const Key('admin-field-desaId'),
                initialValue: _desaId,
                decoration: const InputDecoration(
                  labelText: 'Desa wisata',
                  border: OutlineInputBorder(),
                ),
                items: [
                  if (_desaId != null &&
                      !_villages.any((v) => v['id'] == _desaId))
                    DropdownMenuItem<int>(
                      value: _desaId,
                      child: Text('Desa #$_desaId'),
                    ),
                  ..._villages.map(
                    (v) => DropdownMenuItem<int>(
                      value: v['id'] as int,
                      child: Text(
                        '${v['namaDesa_id'] ?? v['id']}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                onChanged: _saving
                    ? null
                    : (value) => setState(() => _desaId = value),
                validator: (value) =>
                    value == null ? 'Pilih desa wisata' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: const Key('admin-field-titikKota'),
                initialValue: _customRegion ? 'Lainnya' : _region,
                decoration: const InputDecoration(
                  labelText: 'Asal wilayah',
                  border: OutlineInputBorder(),
                ),
                items: [...sultengRegions, 'Lainnya']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: _saving
                    ? null
                    : (value) => setState(() {
                        _customRegion = value == 'Lainnya';
                        _region = value;
                      }),
              ),
              if (_customRegion)
                _text('customRegion', 'Nama wilayah asal lainnya'),
              const SizedBox(height: 8),
              const Text(
                'Isi hanya moda yang tersedia. Judul, durasi, dan biaya akan tampil pada kartu rute pengguna.',
              ),
              for (final mode in ['laut', 'darat', 'udara'])
                ExpansionTile(
                  title: Text(
                    'Jalur ${mode[0].toUpperCase()}${mode.substring(1)}',
                  ),
                  initiallyExpanded: mode == 'darat',
                  children: [
                    _text('jalur_$mode', 'Deskripsi (Indonesia)', lines: 3),
                    _text('jalur_${mode}_en', 'Deskripsi (Inggris)', lines: 3),
                    _text('jalur_${mode}_judul', 'Judul jalur'),
                    _text('jalur_${mode}_judul_en', 'Judul jalur (Inggris)'),
                    _text('jalur_${mode}_durasi', 'Estimasi durasi'),
                    _text('jalur_${mode}_biaya', 'Estimasi biaya'),
                  ],
                ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
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
        child: Text(_saving ? 'Menyimpan...' : 'Simpan'),
      ),
    ],
  );
}
