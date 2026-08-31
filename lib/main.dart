import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection_container.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/lumilu_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/controllers/auth_session_controller.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  final preferences = await SharedPreferences.getInstance();
  final authSessionController = AuthSessionController(getIt<AuthRepository>());
  runApp(
    LumiluApp(
      themeController: ThemeController(preferences),
      localeController: LocaleController(preferences),
      authSessionController: authSessionController,
    ),
  );
}

class LumiluApp extends StatefulWidget {
  const LumiluApp({
    required this.themeController,
    required this.localeController,
    required this.authSessionController,
    super.key,
  });

  final ThemeController themeController;
  final LocaleController localeController;
  final AuthSessionController authSessionController;

  @override
  State<LumiluApp> createState() => _LumiluAppState();
}

class _LumiluAppState extends State<LumiluApp> {
  late final router = createAppRouter(
    themeController: widget.themeController,
    localeController: widget.localeController,
    authSessionController: widget.authSessionController,
  );

  @override
  void dispose() {
    router.dispose();
    widget.authSessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: Listenable.merge([
      widget.themeController,
      widget.localeController,
      widget.authSessionController,
    ]),
    builder: (context, _) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: LumiluTheme.light,
      darkTheme: LumiluTheme.dark,
      themeMode: widget.themeController.themeMode,
      locale: widget.localeController.locale,
      builder: (context, child) => SplashGate(child: child!),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}
