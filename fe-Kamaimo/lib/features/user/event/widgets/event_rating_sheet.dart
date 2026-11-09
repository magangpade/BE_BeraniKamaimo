import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../event_data.dart';
import '../event_locale.dart';

class EventRatingSheet extends StatefulWidget {
  const EventRatingSheet({
    required this.event,
    required this.onSubmit,
    this.initialRating,
    super.key,
  });

  final EventItem event;
  final int? initialRating;
  final Future<bool> Function(int rating) onSubmit;

  @override
  State<EventRatingSheet> createState() => _EventRatingSheetState();
}

class _EventRatingSheetState extends State<EventRatingSheet> {
  late int _rating = widget.initialRating ?? 0;
  bool _sending = false;
  String? _error;

  static const _labels = [
    '',
    'Sangat buruk',
    'Kurang',
    'Cukup',
    'Bagus',
    'Sangat bagus',
  ];
  static const _englishLabels = [
    '',
    'Very poor',
    'Poor',
    'Fair',
    'Good',
    'Excellent',
  ];

  bool get _isEnglish => context.read<LanguageProvider?>()?.isEnglish ?? false;

  Future<void> _submit() async {
    if (_rating == 0 || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final saved = await widget.onSubmit(_rating);
      if (!mounted) return;
      if (saved) {
        Navigator.of(context).pop();
      } else {
        setState(
          () => _error = _isEnglish
              ? 'Your rating was not saved. Please try again.'
              : 'Rating belum tersimpan. Coba lagi.',
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = _isEnglish
              ? 'Could not submit your rating. Check your connection and try again.'
              : 'Gagal mengirim rating. Periksa koneksi lalu coba lagi.',
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.watch<LanguageProvider?>()?.isEnglish ?? false;
    final isPasar = widget.event.nama == 'Pasar Kreatif Sulteng';
    final title = isEnglish
        ? EventLocale.name(widget.event, true)
        : isPasar
        ? 'Pasar Kreatif Sulawesi Tengah'
        : widget.event.nama;
    final location = isEnglish
        ? EventLocale.location(widget.event, true)
        : isPasar
        ? 'Taman GOR, Kota Palu'
        : widget.event.lokasi;
    final image = isPasar
        ? 'assets/images/beranda/pasar_kreatif_rating_thumb.png'
        : widget.event.foto;

    return Center(
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4DDD5),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            isEnglish ? 'Rate this event' : 'Beri rating',
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.pine900,
                            ),
                          ),
                        ),
                        IconButton(
                          key: const Key('event-rating-close'),
                          onPressed: _sending
                              ? null
                              : () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded, size: 22),
                          color: AppColors.pine900,
                          constraints: const BoxConstraints.tightFor(
                            width: 32,
                            height: 32,
                          ),
                          padding: EdgeInsets.zero,
                          tooltip: isEnglish ? 'Close' : 'Tutup',
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFF7FAF7),
                            side: const BorderSide(color: Color(0xFFE4ECE4)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isEnglish
                          ? 'How was your experience at this event?'
                          : 'Bagaimana pengalamanmu di tempat ini?',
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAF7),
                        border: Border.all(color: const Color(0xFFE4ECE4)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              image,
                              width: 58,
                              height: 58,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const SizedBox(
                                width: 58,
                                height: 58,
                                child: Icon(Icons.event_rounded),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.pine900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.place_outlined,
                                      size: 13,
                                      color: AppColors.pine700,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        location,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 11,
                                          color: AppColors.textSecondary,
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
                    ),
                    const SizedBox(height: 22),
                    Center(
                      child: Text(
                        isEnglish ? 'Your rating' : 'Rating kamu',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final value = index + 1;
                        final selected = _rating == value;
                        return Flexible(
                          child: InkWell(
                            key: Key('event-rating-star-$value'),
                            onTap: _sending
                                ? null
                                : () => setState(() {
                                    _rating = value;
                                    _error = null;
                                  }),
                            borderRadius: BorderRadius.circular(12),
                            child: Semantics(
                              label: isEnglish
                                  ? '$value out of 5 stars'
                                  : '$value dari 5 bintang',
                              selected: selected,
                              button: true,
                              child: Container(
                                width: 56,
                                height: 56,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFFFFF6E8)
                                      : Colors.transparent,
                                  border: selected
                                      ? Border.all(
                                          color: const Color(0xFFFFE6B7),
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  value <= _rating
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  size: 38,
                                  color: value <= _rating
                                      ? const Color(0xFFFF9E00)
                                      : const Color(0xFFC9D5CE),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        _rating == 0
                            ? (isEnglish ? 'Choose a rating' : 'Pilih rating')
                            : isEnglish
                            ? '$_rating out of 5 · ${_englishLabels[_rating]}'
                            : '$_rating dari 5 · ${_labels[_rating]}',
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pine700,
                        ),
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 11,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        key: const Key('event-rating-submit'),
                        onPressed: _rating == 0 || _sending ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF15442D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _sending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isEnglish ? 'SUBMIT' : 'KIRIM',
                                style: const TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        key: const Key('event-rating-cancel'),
                        onPressed: _sending
                            ? null
                            : () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(0, 36),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          isEnglish ? 'Cancel' : 'Batal',
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.pine900,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
