import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../event_data.dart';

const _assetRoot = 'assets/images/beranda/';

Future<void> showEventShareSheet(
  BuildContext context, {
  required EventItem event,
  String? publicUrl,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    useSafeArea: false,
    barrierColor: Colors.black.withValues(alpha: 0.25),
    backgroundColor: Colors.transparent,
    constraints: const BoxConstraints(maxWidth: 430),
    builder: (context) => _EventShareSheet(event: event, publicUrl: publicUrl),
  );
}

class _EventShareSheet extends StatefulWidget {
  const _EventShareSheet({required this.event, this.publicUrl});

  final EventItem event;
  final String? publicUrl;

  @override
  State<_EventShareSheet> createState() => _EventShareSheetState();
}

class _EventShareSheetState extends State<_EventShareSheet> {
  String? _feedback;

  bool get _isPasarKreatif => widget.event.nama == 'Pasar Kreatif Sulteng';

  String get _title => _isPasarKreatif ? 'Pasar Kreatif' : widget.event.nama;

  String get _location => _isPasarKreatif ? 'Kota Palu' : widget.event.lokasi;

  String? get _shareUrl {
    final value = widget.publicUrl?.trim();
    if (value == null || value.isEmpty) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return null;
    return value;
  }

  String get _shareText => 'Ajak teman menjelajahi $_title di $_location!';

  void _setFeedback(String message) {
    if (mounted) setState(() => _feedback = message);
  }

  Future<void> _copyLink() async {
    final url = _shareUrl;
    if (url == null) {
      _setFeedback('Tautan publik event belum tersedia.');
      return;
    }
    await Clipboard.setData(ClipboardData(text: url));
    _setFeedback('Tautan berhasil disalin.');
  }

  Future<void> _shareTo(String destination) async {
    if (destination == 'Lainnya') {
      try {
        await SharePlus.instance.share(
          ShareParams(
            text: '${_shareText}${_shareUrl == null ? '' : '\n$_shareUrl'}',
          ),
        );
      } catch (_) {
        _setFeedback('Menu berbagi tidak dapat dibuka.');
      }
      return;
    }

    final url = _shareUrl;
    if (url == null) {
      _setFeedback('Tautan publik diperlukan untuk berbagi ke $destination.');
      return;
    }

    final target = switch (destination) {
      'WhatsApp' => Uri.https('wa.me', '/', {'text': '$_shareText\n$url'}),
      'Telegram' => Uri.https('t.me', '/share/url', {
        'url': url,
        'text': _shareText,
      }),
      'Facebook' => Uri.https('www.facebook.com', '/sharer/sharer.php', {
        'u': url,
      }),
      _ => null,
    };
    if (target == null) return;

    try {
      if (await launchUrl(target, mode: LaunchMode.externalApplication)) return;
    } catch (_) {}
    _setFeedback('$destination tidak dapat dibuka.');
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.sizeOf(context).height -
        MediaQuery.paddingOf(context).top -
        8;
    final sheetHeight = math.min(606.0, availableHeight);

    return Container(
      height: sheetHeight,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      decoration: const BoxDecoration(
        color: AppColors.detailBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Color(0x330F2C24),
            blurRadius: 32,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFCCD3C9),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 20),
                  _buildPreview(),
                  const SizedBox(height: 20),
                  _buildShareOptions(),
                  const SizedBox(height: 20),
                  _buildLinkSection(),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Batal',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.pine500,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 134,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.pine900,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Bagikan Event',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.pine900,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              customBorder: const CircleBorder(),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FAF7),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.detailBorder),
                ),
                child: Center(
                  child: Image.asset(
                    '${_assetRoot}pasar_share_close.png',
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _isPasarKreatif
              ? 'Ajak teman menjelajahi Pasar Kreatif.'
              : 'Ajak teman menjelajahi $_title.',
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 13,
            height: 20 / 13,
            color: AppColors.detailBody,
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.detailBorder),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.event.foto,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event ${widget.event.kategori}',
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.pine500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 17,
                    height: 24 / 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.pine900,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Image.asset(
                      '${_assetRoot}pasar_share_pin.png',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        _location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 11,
                          color: AppColors.detailBody,
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

  Widget _buildShareOptions() {
    const options = [
      ('WhatsApp', 'pasar_share_whatsapp.png', 26.0),
      ('Telegram', 'pasar_share_telegram.png', 25.0),
      ('Facebook', 'pasar_share_facebook.png', 25.0),
      ('Lainnya', 'pasar_share_more.png', 25.0),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bagikan melalui',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.pine900,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (final (label, asset, size) in options)
              Expanded(
                child: InkWell(
                  onTap: () => _shareTo(label),
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.mintSoft,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Image.asset(
                            '$_assetRoot$asset',
                            width: size,
                            height: size,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pine900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLinkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tautan event',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.pine900,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.detailBorder),
          ),
          child: Row(
            children: [
              Image.asset(
                '${_assetRoot}pasar_share_link.png',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _shareUrl ??
                      (_isPasarKreatif
                          ? 'kamaimo.id/event/pasar-kreatif'
                          : 'Tautan publik belum tersedia'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                    color: AppColors.detailBody,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_shareUrl == null || _feedback != null) ...[
          const SizedBox(height: 5),
          Text(
            _feedback ?? 'Pratinjau tautan — belum aktif untuk publik.',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 10,
              fontWeight: _feedback == null ? FontWeight.w400 : FontWeight.w700,
              color: _feedback == null
                  ? AppColors.textSecondary
                  : AppColors.earth,
            ),
          ),
        ],
        const SizedBox(height: 10),
        SizedBox(
          height: 52,
          width: double.infinity,
          child: FilledButton(
            onPressed: _copyLink,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.pine800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'SALIN TAUTAN',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
