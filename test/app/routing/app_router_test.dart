import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:lumilu/router.dart';

void main() {
  testWidgets('completes the Home → Squat → Achievement flow', (tester) async {
    final router = createAppRouter(
      squatBuilder: (context) => Scaffold(
        body: Center(
          child: FilledButton(
            key: const Key('complete-workout'),
            onPressed: () => context.go(AppRoutes.achievement),
            child: const Text('Complete'),
          ),
        ),
      ),
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('uk'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    expect(find.text('Готові стати\nсильнішими?'), findsOneWidget);

    await tester.tap(find.byKey(const Key('start-squats')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('complete-workout')), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.squat);

    await tester.tap(find.byKey(const Key('complete-workout')));
    await tester.pumpAndSettle();
    expect(find.text('Чудова робота!'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.achievement);
  });
}
