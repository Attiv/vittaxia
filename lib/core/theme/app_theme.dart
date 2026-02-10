import 'package:flutter/material.dart';

/// 武侠风格主题配色 — 水墨暖灰
class AppColors {
  // 主色调：墨色暖灰
  static const primary = Color(0xFF3A3632);
  static const primaryLight = Color(0xFF5A5550);
  static const primaryDark = Color(0xFF1C1A18);

  // 强调色：金色（江湖气质）
  static const accent = Color(0xFFE8C36A);
  static const accentDark = Color(0xFFBFA04A);

  // 背景
  static const background = Color(0xFF1A1816);
  static const surface = Color(0xFF242220);
  static const surfaceLight = Color(0xFF33302D);

  // 进度条轨道
  static const progressTrack = Color(0xFF3D3A36);

  // 文字
  static const textPrimary = Color(0xFFE8E4DF);
  static const textSecondary = Color(0xFFA8A29E);
  static const textAccent = Color(0xFFE8C36A);

  // 功能色
  static const hp = Color(0xFFE53935);
  static const mp = Color(0xFF42A5F5);
  static const exp = Color(0xFF66BB6A);
  static const danger = Color(0xFFFF5252);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFF9800);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.danger,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.primaryDark,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.accent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
          letterSpacing: 2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.primaryLight, width: 0.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.accent, width: 0.5),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
          letterSpacing: 4,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.accent,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.primaryLight,
        thickness: 0.5,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
