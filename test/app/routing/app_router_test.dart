import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:lumilu/router.dart';

void main() {
  testWidgets('opens onboarding routes and completes the workout flow', (
    tester,
  ) async {
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
    expect(find.byKey(const Key('welcome-headline')), findsOneWidget);
    expect(find.text('Почнімо рухатись'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.welcome);

    await tester.tap(find.byKey(const Key('welcome-sign-in')));
    await tester.pumpAndSettle();
    expect(find.text('Вхід'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.signIn);

    router.go(AppRoutes.welcome);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('welcome-get-started')));
    await tester.tap(find.byKey(const Key('welcome-get-started')));
    await tester.pumpAndSettle();
    expect(find.text('Створіть акаунт'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.quickRegistration);

    router.go(AppRoutes.createProfile);
    await tester.pumpAndSettle();
    expect(find.text('Створення профілю'), findsOneWidget);

    router.go(AppRoutes.firstWorkout);
    await tester.pumpAndSettle();
    expect(find.text('Перша зарядка'), findsOneWidget);

    router.go(AppRoutes.home);
    await tester.pumpAndSettle();
    expect(find.text('Готові стати\nсильнішими?'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.home);

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
