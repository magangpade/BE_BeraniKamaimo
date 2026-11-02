import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Skala tipografi Berani Kamaimo.
class AppTypography {
  AppTypography._();

  static TextTheme get textTheme => const TextTheme(
        // Hero title (Sulawesi Tengah)
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: AppColors.textOnPrimary,
          height: 1.2,
          letterSpacing: -0.5,
          fontFamily: 'PlusJakartaSans',
        ),

        // Section title (Wisata Unggulan, Desa Wisata, dll)
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          height: 1.3,
          fontFamily: 'PlusJakartaSans',
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.4,
          fontFamily: 'PlusJakartaSans',
        ),

        // Card title
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          height: 1.4,
          fontFamily: 'PlusJakartaSans',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.5,
          fontFamily: 'PlusJakartaSans',
        ),

        // Body text (deskripsi)
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textPrimary,
          height: 1.6,
          fontFamily: 'PlusJakartaSans',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.5,
          fontFamily: 'PlusJakartaSans',
        ),

        // Caption (lokasi, tanggal)
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
          height: 1.4,
          fontFamily: 'PlusJakartaSans',
        ),

        // Label (button, chip)
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textOnPrimary,
          letterSpacing: 0.5,
          fontFamily: 'PlusJakartaSans',
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          fontFamily: 'PlusJakartaSans',
        ),
      );
}
