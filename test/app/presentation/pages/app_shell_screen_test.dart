import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:lumilu/router.dart';

void main() {
  testWidgets('router owns three stateful branches and fullscreen workout', (
    tester,
  ) async {
    final router = createAppRouter(
      squatBuilder: (context) =>
          const Scaffold(body: Center(child: Text('Fullscreen workout'))),
    );
    addTearDown(router.dispose);
    router.go(AppRoutes.today);

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    expect(find.byType(NavigationDestination), findsNWidgets(3));
    expect(find.text('Ready to get\nstronger?'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.today);

    await tester.tap(find.text('Move').last);
    await tester.pumpAndSettle();
    expect(find.text('Choose your next move'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.move);

    await tester.tap(find.text('Rewards').last);
    await tester.pumpAndSettle();
    expect(find.text('Your rewards'), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.rewards);

    await tester.tap(find.text('Move').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('move-start-workout')));
    await tester.pumpAndSettle();

    expect(find.text('Fullscreen workout'), findsOneWidget);
    expect(find.byKey(const Key('main-bottom-navigation')), findsNothing);
    expect(find.byKey(const Key('open-profile-settings')), findsNothing);
  });
}
