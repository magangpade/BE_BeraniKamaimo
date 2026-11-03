import 'package:flutter/material.dart';

/// Token spacing & radius Berani Kamaimo.
class AppSpacing {
  AppSpacing._();

  // Spacing scale (4px base)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // Border radius
  static const double radius4 = 4.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius24 = 24.0;
  static const double radiusFull = 9999.0;

  // Common inset
  static const EdgeInsets insetAll8 = EdgeInsets.all(spacing8);
  static const EdgeInsets insetAll12 = EdgeInsets.all(spacing12);
  static const EdgeInsets insetAll16 = EdgeInsets.all(spacing16);
  static const EdgeInsets insetAll24 = EdgeInsets.all(spacing24);
  static const EdgeInsets insetAll32 = EdgeInsets.all(spacing32);

  static const EdgeInsets insetHorizontal16 = EdgeInsets.symmetric(horizontal: spacing16);
  static const EdgeInsets insetHorizontal24 = EdgeInsets.symmetric(horizontal: spacing24);
  static const EdgeInsets insetVertical12 = EdgeInsets.symmetric(vertical: spacing12);
  static const EdgeInsets insetVertical16 = EdgeInsets.symmetric(vertical: spacing16);

  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(spacing16);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(spacing12);
}