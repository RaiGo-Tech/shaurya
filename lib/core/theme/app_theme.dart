import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(
      bodyColor: dark ? AppColors.darkInk : AppColors.ink,
      displayColor: dark ? AppColors.darkInk : AppColors.ink,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: dark ? AppColors.darkCanvas : AppColors.canvas,
      colorScheme: dark
          ? const ColorScheme.dark(
              primary: AppColors.blue,
              onPrimary: Colors.white,
              secondary: Color(0xFF93C5FD),
              surface: AppColors.darkSurface,
              onSurface: AppColors.darkInk,
              error: Color(0xFFF87171),
            )
          : const ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: Colors.white,
              secondary: AppColors.navy,
              surface: Colors.white,
              onSurface: AppColors.ink,
              error: Color(0xFFD92D20),
            ),
      textTheme: textTheme.copyWith(
        displaySmall: textTheme.displaySmall?.copyWith(
          fontSize: 32,
          height: 1.15,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 26,
          height: 1.2,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.55,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontSize: 21,
          height: 1.3,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.25,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontSize: 18,
          height: 1.35,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          height: 1.5,
          color: dark ? AppColors.darkMuted : AppColors.muted,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: dark ? AppColors.darkSurface : Colors.white,
        foregroundColor: dark ? AppColors.darkInk : AppColors.ink,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: dark ? AppColors.darkCard : Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: dark ? AppColors.darkBorder : AppColors.border.withValues(alpha: .6)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: dark ? AppColors.darkSurface : Colors.white,
        indicatorColor: dark ? const Color(0xFF1E3A5F) : AppColors.sky,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 46),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: dark ? AppColors.darkInk : AppColors.navy,
          minimumSize: const Size(0, 44),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          side: BorderSide(color: dark ? AppColors.darkBorder : const Color(0xFFB9C9E3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? AppColors.darkCard : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        hintStyle: TextStyle(color: dark ? AppColors.darkMuted : const Color(0xFF98A2B3)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: dark ? AppColors.darkBorder : AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: dark ? AppColors.darkBorder : AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: dark ? AppColors.darkBorder : AppColors.border,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
