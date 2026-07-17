import 'package:flutter/material.dart';

import 'core/di/injection_container.dart';
import 'l10n/generated/app_localizations.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const LumiluApp());
}

class LumiluApp extends StatelessWidget {
  const LumiluApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff70e000),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
    routerConfig: appRouter,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
