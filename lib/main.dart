import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection_container.dart';
import 'core/theme/lumilu_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/splash/presentation/pages/splash_screen.dart';
import 'l10n/generated/app_localizations.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final preferences = await SharedPreferences.getInstance();
  runApp(LumiluApp(themeController: ThemeController(preferences)));
}

class LumiluApp extends StatefulWidget {
  const LumiluApp({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  State<LumiluApp> createState() => _LumiluAppState();
}

class _LumiluAppState extends State<LumiluApp> {
  late final router = createAppRouter(themeController: widget.themeController);

  @override
  void dispose() {
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.themeController,
    builder: (context, _) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: LumiluTheme.light,
      darkTheme: LumiluTheme.dark,
      themeMode: widget.themeController.themeMode,
      builder: (context, child) => SplashGate(child: child!),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}
