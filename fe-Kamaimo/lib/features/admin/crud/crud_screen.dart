import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:berani_kamaimo/core/config/env.dart';
import 'package:berani_kamaimo/core/network/api_client.dart';
import 'package:berani_kamaimo/core/network/api_exception.dart';
import 'package:berani_kamaimo/core/theme/app_colors.dart';

import '../data/admin_content.dart';
import 'admin_entity_form_dialog.dart';
import 'desa_wisata_form_dialog.dart';
import 'jarak_desa_form_dialog.dart';

/// Admin content list backed by be-kamaimo.
class CrudScreen extends StatefulWidget {
  final String title;
  final String entityType;
  final List<Map<String, dynamic>> initialData;

  const CrudScreen({
    super.key,
    required this.title,
    required this.entityType,
    this.initialData = const [],
  });

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  late List<Map<String, dynamic>> _data;
  final _searchCtrl = TextEditingController();
  String _filter = '';
  bool _loading = true;
  String? _loadError;
  int _loadVersion = 0;

  @override
  void initState() {
    super.initState();
    _data = List.from(widget.initialData);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncFromBackend();
    });
  }

  @override
  void didUpdateWidget(covariant CrudScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entityType != widget.entityType) {
      setState(() {
        _filter = '';
        _searchCtrl.clear();
        _data = List.from(widget.initialData);
      });
      _syncFromBackend();
    }
  }

  Future<void> _syncFromBackend() async {
    final version = ++_loadVersion;
    final type = widget.entityType;
    setState(() {
      _loading = true;
      _loadError = null;
      _data = [];
    });
    try {
      final api = context.read<ApiClient>();
      final rows = await AdminContent.load(api, type);
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _data = rows.map((row) => AdminContent.display(type, row)).toList();
        _loading = false;
      });
    } catch (error) {
      if (!mounted || version != _loadVersion) return;
      setState(() {
        _loadError = error is ApiException
            ? error.userMessage
            : 'Gagal memuat data dari backend. Periksa koneksi API.';
        _loading = false;
      });
    }
  }

  List<Map<String, dynamic>> _getFiltered() {
    if (_filter.isEmpty) return _data;
    final q = _filter.toLowerCase();
    return _data.where((e) {
      return e.values.any((v) => v.toString().toLowerCase().contains(q));
    }).toList();
  }

  Widget _contentImage(String source, {required double height}) {
    final image = source.startsWith('http://') || source.startsWith('https://')
        ? Image.network(
            source,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _imageFallback(height),
          )
        : source.startsWith('/')
        ? Image.network(
            '${Env.serverBaseUrl}$source',
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _imageFallback(height),
          )
        : Image.asset(
            source,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _imageFallback(height),
          );
    return image;
  }

  Widget _imageFallback(double height) => Container(
    height: height,
    color: AppColors.surfaceElevated,
    child: const Center(
      child: Icon(Icons.image_outlined, color: AppColors.textTertiary),
    ),
  );

  Future<void> _showForm([Map<String, dynamic>? item]) async {
    final type = widget.entityType;
    final api = context.read<ApiClient>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) {
        Future<void> save(Map<String, dynamic> body) => item == null
            ? AdminContent.create(api, type, body)
            : AdminContent.update(api, type, item['id'], body);
        final row = item?['raw'] as Map<String, dynamic>?;
        return type == 'desaWisata'
            ? DesaWisataFormDialog(api: api, row: row, onSave: save)
            : type == 'jarakDesa'
            ? JarakDesaFormDialog(api: api, row: row, onSave: save)
            : AdminEntityFormDialog(
                title: widget.title,
                entityType: type,
                api: api,
                row: row,
                onSave: save,
              );
      },
    );
    if (saved == true && mounted) {
      await _syncFromBackend();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              item == null
                  ? 'Data berhasil ditambahkan.'
                  : 'Data berhasil diperbarui.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _confirmDelete(Map<String, dynamic> item) async {
    final api = context.read<ApiClient>();
    final type = widget.entityType;
    var saving = false;
    String? error;
    final deleted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Yakin ingin menghapus "${item['name']}"?'),
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(error!, style: const TextStyle(color: AppColors.error)),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: saving ? null : () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: saving
                  ? null
                  : () async {
                      setDialogState(() {
                        saving = true;
                        error = null;
                      });
                      try {
                        await AdminContent.delete(api, type, item['id']);
                        if (dialogContext.mounted) {
                          Navigator.pop(dialogContext, true);
                        }
                      } catch (failure) {
                        if (dialogContext.mounted) {
                          setDialogState(() {
                            error = failure is ApiException
                                ? failure.userMessage
                                : 'Gagal menghapus data.';
                            saving = false;
                          });
                        }
                      }
                    },
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 40),
                backgroundColor: AppColors.error,
              ),
              child: saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Hapus'),
            ),
          ],
        ),
      ),
    );
    if (deleted == true && mounted) {
      await _syncFromBackend();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus.')));
      }
    }
  }

  void _showDetail(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        title: Text(
          item['name'] as String? ?? 'Detail',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item['image'] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: _contentImage(item['image'] as String, height: 180),
                ),
              if (item['image'] != null) const SizedBox(height: 14),
              if (item['badge'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.emerald100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item['badge'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.emerald600,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              if (item['loc'] != null)
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.pine500,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item['loc'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              if (item['price'] != null) ...[
                const SizedBox(height: 6),
                Text(
                  item['price'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine700,
                    fontSize: 14,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Text(
                item['desc'] as String? ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: AppColors.textBody,
                ),
              ),
              if (item['dariPalu'] != null) ...[
                const Divider(height: 20),
                const Text(
                  'Dari Palu:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  item['dariPalu'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Dari Luwuk:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  item['dariLuwuk'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
              if (item['extra'] != null) ...[
                const Divider(height: 20),
                Text(
                  'Fasilitas / Info: ${item['extra']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.pine700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Tutup',
              style: TextStyle(fontFamily: 'PlusJakartaSans'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFiltered();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header title & count
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Text(
                      _loading
                          ? 'Memuat data backend...'
                          : _loadError != null
                          ? 'Data gagal dimuat'
                          : '${filtered.length} Konten Terdaftar',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: widget.entityType == 'adminUser'
                    ? null
                    : () => _showForm(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text(
                  'Tambah Data',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.pine700,
                  minimumSize: const Size(0, 44),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Muat ulang data',
                onPressed: _syncFromBackend,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _filter = v),
              decoration: InputDecoration(
                hintText: 'Cari ${widget.title.toLowerCase()}...',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'PlusJakartaSans',
                  color: AppColors.textTertiary,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // List / Grid kartu
          if (_loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_loadError != null)
            Center(
              child: Column(
                children: [
                  Text(
                    _loadError!,
                    style: const TextStyle(color: AppColors.error),
                  ),
                  TextButton(
                    onPressed: _syncFromBackend,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            )
          else if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 48,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _filter.isEmpty
                          ? 'Belum ada ${widget.title.toLowerCase()} di backend.'
                          : 'Tidak ada ${widget.title.toLowerCase()} yang cocok.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (_, i) => _buildItemCard(filtered[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final hasImage = item['image'] != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.pine900.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: _contentImage(item['image'] as String, height: 140),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (item['badge'] != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.emerald100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['badge'] as String,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: AppColors.emerald600,
                            letterSpacing: 0.3,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (item['tag'] != null)
                      Text(
                        item['tag'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine500,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['name'] as String? ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                if (item['loc'] != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.place_rounded,
                        size: 13,
                        color: AppColors.pine500,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          item['loc'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ),
                      if (item['rating'] != null) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item['rating'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  item['desc'] as String? ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textBody,
                    height: 1.4,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
                if (item['price'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    item['price'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.pine700,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
                const Divider(height: 20),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => _showDetail(item),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      key: Key('admin-edit-${item['id']}'),
                      onPressed: widget.entityType == 'adminUser'
                          ? null
                          : () => _showForm(item),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: widget.entityType == 'adminUser'
                          ? null
                          : () => _confirmDelete(item),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 36),
                        backgroundColor: AppColors.error.withValues(alpha: 0.1),
                        foregroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Hapus',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }
}
