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
  static const violet600 = Color(0xFF7447F5);
  static const lightCanvas = Color(0xFFFAF9FC);
  static const lightSurfaceContainer = Color(0xFFFDFCFF);
  static const lightOutline = Color(0xFFDCD9E6);
  static const lightOutlineVariant = Color(0xFFECE9F2);
  static const lightText = Color(0xFF17142F);
  static const lightTextMuted = Color(0xFF66647E);
  static const darkCanvas = Color(0xFF070619);
  static const darkSurface = Color(0xFF11102A);
  static const darkSurfaceContainer = Color(0xFF17152F);
  static const darkOutline = Color(0xFF302C50);
  static const darkOutlineVariant = Color(0xFF24213F);
  static const darkText = Color(0xFFF8F7FC);
  static const darkTextMuted = Color(0xFFA7A2C8);
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
    canvas: LumiluColors.lightCanvas,
    surface: LumiluColors.neutral0,
    surfaceContainer: LumiluColors.lightSurfaceContainer,
    primary: LumiluColors.violet600,
    onPrimary: LumiluColors.neutral0,
    secondary: LumiluColors.mint400,
    onSecondary: LumiluColors.lightText,
    outline: LumiluColors.lightOutline,
    outlineVariant: LumiluColors.lightOutlineVariant,
    onSurface: LumiluColors.lightText,
    onSurfaceVariant: LumiluColors.lightTextMuted,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    canvas: LumiluColors.darkCanvas,
    surface: LumiluColors.darkSurface,
    surfaceContainer: LumiluColors.darkSurfaceContainer,
    primary: LumiluColors.yellow500,
    onPrimary: LumiluColors.darkCanvas,
    secondary: LumiluColors.mint400,
    onSecondary: LumiluColors.darkCanvas,
    outline: LumiluColors.darkOutline,
    outlineVariant: LumiluColors.darkOutlineVariant,
    onSurface: LumiluColors.darkText,
    onSurfaceVariant: LumiluColors.darkTextMuted,
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
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 0,
        indicatorColor: Colors.transparent,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? primary
                : onSurfaceVariant,
            size: 25,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? primary
                : onSurfaceVariant,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
