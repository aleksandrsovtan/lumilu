import 'package:flutter/material.dart';

abstract final class LumiluColors {
  static const twilight900 = Color(0xFF121027);
  static const twilight800 = Color(0xFF1E1B3D);
  static const twilight700 = Color(0xFF332D54);
  static const twilight600 = Color(0xFF49416F);
  static const twilight400 = Color(0xFF857CB3);
  static const twilight300 = Color(0xFFAEA7D1);
  static const yellow600 = Color(0xFFFFD166);
  static const yellow500 = Color(0xFFFFD452);
  static const yellow400 = Color(0xFFFFE47A);
  static const mint50 = Color(0xFFF0FCFA);
  static const mint400 = Color(0xFF7DE0D1);
  static const green500 = Color(0xFF70E000);
  static const lilac50 = Color(0xFFF3F1F8);
  static const lilac400 = Color(0xFFB7B2FF);
  static const lilac500 = Color(0xFF958DEC);
  static const lilac600 = Color(0xFF756ACF);
  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral50 = Color(0xFFFBFAF8);
  static const neutral100 = Color(0xFFF7F6F2);
  static const neutral200 = Color(0xFFECEAE4);
  static const neutral300 = Color(0xFFD8D5CC);
  static const neutral500 = Color(0xFF747068);
  static const neutral600 = Color(0xFF5F5B55);
  static const error = Color(0xFFB72F47);
}

abstract final class LumiluTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    canvas: LumiluColors.neutral300,
    surface: LumiluColors.neutral0,
    surfaceContainer: LumiluColors.neutral50,
    primary: LumiluColors.twilight800,
    onPrimary: LumiluColors.neutral0,
    secondary: LumiluColors.mint400,
    onSecondary: LumiluColors.twilight800,
    outline: LumiluColors.neutral300,
    outlineVariant: LumiluColors.neutral200,
    onSurface: LumiluColors.twilight800,
    onSurfaceVariant: LumiluColors.neutral600,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    canvas: LumiluColors.twilight900,
    surface: LumiluColors.twilight800,
    surfaceContainer: LumiluColors.twilight700,
    primary: LumiluColors.yellow500,
    onPrimary: LumiluColors.twilight900,
    secondary: LumiluColors.mint400,
    onSecondary: LumiluColors.twilight900,
    outline: LumiluColors.twilight600,
    outlineVariant: LumiluColors.twilight700,
    onSurface: LumiluColors.neutral0,
    onSurfaceVariant: LumiluColors.twilight300,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color canvas,
    required Color surface,
    required Color surfaceContainer,
    required Color primary,
    required Color onPrimary,
    required Color secondary,
    required Color onSecondary,
    required Color outline,
    required Color outlineVariant,
    required Color onSurface,
    required Color onSurfaceVariant,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: brightness == Brightness.light
          ? LumiluColors.twilight700
          : LumiluColors.yellow400,
      onPrimaryContainer: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: brightness == Brightness.light
          ? LumiluColors.mint50
          : LumiluColors.twilight700,
      onSecondaryContainer: onSurface,
      tertiary: LumiluColors.lilac400,
      onTertiary: LumiluColors.twilight900,
      error: LumiluColors.error,
      onError: LumiluColors.neutral0,
      surface: surface,
      onSurface: onSurface,
      surfaceContainer: surfaceContainer,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: onSurface,
      onInverseSurface: surface,
      inversePrimary: brightness == Brightness.light
          ? LumiluColors.yellow500
          : LumiluColors.twilight800,
    );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);
    final textTheme = base.textTheme.apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );
    return base.copyWith(
      scaffoldBackgroundColor: canvas,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: onSurface,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
