import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/localization/locale_controller.dart';
import 'package:lumilu/core/theme/lumilu_theme.dart';
import 'package:lumilu/core/theme/theme_controller.dart';
import 'package:lumilu/features/profile/presentation/pages/profile_settings_screen.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<(ThemeController, LocaleController)> controllers() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    return (ThemeController(preferences), LocaleController(preferences));
  }

  testWidgets('changes theme and locale and logs out', (tester) async {
    final (themeController, localeController) = await controllers();
    var loggedOut = false;
    await tester.pumpWidget(
      AnimatedBuilder(
        animation: localeController,
        builder: (context, _) => MaterialApp(
          theme: LumiluTheme.light,
          locale: localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ProfileSettingsScreen(
            themeController: themeController,
            localeController: localeController,
            onLogout: () async => loggedOut = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('theme-dark')));
    await tester.pump();
    expect(themeController.themeMode, ThemeMode.dark);

    await tester.ensureVisible(find.byKey(const Key('language-uk')));
    await tester.tap(find.byKey(const Key('language-uk')));
    await tester.pumpAndSettle();
    expect(localeController.locale, const Locale('uk'));
    expect(find.byKey(const Key('language-uk')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('logout-button')));
    await tester.tap(find.byKey(const Key('logout-button')));
    await tester.pumpAndSettle();
    expect(loggedOut, isTrue);
  });
}
