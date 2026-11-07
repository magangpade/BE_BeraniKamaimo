import 'package:flutter/material.dart';
import '../config/env.dart';

/// Widget cerdas untuk menampilkan gambar:
/// 1. Jika URL penuh (`http://...` atau `https://...`) -> Image.network
/// 2. Jika path asset lokal (`assets/...`) -> Image.asset
/// 3. Jika path upload backend (`/uploads/...` atau `xxx.webp`):
///    - Coba muat langsung dari bundle asset lokal `assets/images/uploads/` (instant, offline & zero delay)
///    - Jika belum ada di bundle lokal -> muat dari server HTTP `${Env.serverBaseUrl}/uploads/...`
/// 4. Fallback jika gagal -> `fallbackAsset` tanpa crash.
class KamaimoImage extends StatelessWidget {
  final String? path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String fallbackAsset;

  const KamaimoImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.fallbackAsset = 'assets/images/destinasi/card_togean.png',
  });

  @override
  Widget build(BuildContext context) {
    final raw = (path ?? '').trim();
    if (raw.isEmpty) {
      return Image.asset(fallbackAsset, fit: fit, width: width, height: height);
    }

    if (raw.startsWith('assets/')) {
      return Image.asset(
        raw,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, _) => Image.asset(
          fallbackAsset,
          fit: fit,
          width: width,
          height: height,
        ),
      );
    }

    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return Image.network(
        raw,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, _) => Image.asset(
          fallbackAsset,
          fit: fit,
          width: width,
          height: height,
        ),
      );
    }

    String cleanFilename = raw;
    if (cleanFilename.startsWith('/uploads/')) {
      cleanFilename = cleanFilename.substring(9);
    } else if (cleanFilename.startsWith('uploads/')) {
      cleanFilename = cleanFilename.substring(8);
    }

    final localAssetPath = 'assets/images/uploads/$cleanFilename';

    return Image.asset(
      localAssetPath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, _) {
        final netUrl = '${Env.serverBaseUrl}/uploads/$cleanFilename';
        return Image.network(
          netUrl,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, _) => Image.asset(
            fallbackAsset,
            fit: fit,
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}
