import 'package:flutter/material.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/app_colors.dart';
import '../data/admin_form_fields.dart';

class AdminEntityFormDialog extends StatefulWidget {
  const AdminEntityFormDialog({
    super.key,
    required this.title,
    required this.entityType,
    required this.onSave,
    this.row,
  });

  final String title;
  final String entityType;
  final Map<String, dynamic>? row;
  final Future<void> Function(Map<String, dynamic> body) onSave;

  @override
  State<AdminEntityFormDialog> createState() => _AdminEntityFormDialogState();
}

class _AdminEntityFormDialogState extends State<AdminEntityFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};
  late final List<AdminFormField> _fields;
  bool _saving = false;
  String? _error;

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
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
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
    if (widget.entityType == 'atraksi') {
      final start = DateTime.parse(_controllers['startdate']!.text.trim());
      final end = DateTime.parse(_controllers['enddate']!.text.trim());
      if (end.isBefore(start)) {
        setState(() => _error = 'Tanggal selesai harus setelah tanggal mulai.');
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
    if (body.isEmpty) {
      setState(() => _error = 'Belum ada perubahan untuk disimpan.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
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
        hintText: field.date ? 'YYYY-MM-DD' : null,
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.row == null ? 'Tambah' : 'Edit'} ${widget.title}'),
      content: SizedBox(
        width: 480,
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
