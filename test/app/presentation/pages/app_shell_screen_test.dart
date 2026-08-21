import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';
import 'package:lumilu/router.dart';

void main() {
  testWidgets('router owns three stateful branches and fullscreen workout', (tester) async {
    final router = createAppRouter(
      squatBuilder: (context) => const Scaffold(body: Center(child: Text('Fullscreen workout'))),
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
    expect(find.byKey(const Key('open-profile-settings')), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.today);

    await tester.tap(find.text('Move').last);
    await tester.pumpAndSettle();
    expect(find.text('Choose your pace'), findsOneWidget);
    expect(find.byKey(const Key('open-profile-settings')), findsNothing);
    expect(router.state.uri.path, AppRoutes.move);

    await tester.tap(find.text('Lumi').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('base-lumi-image')), findsOneWidget);
    expect(find.byKey(const Key('lumilu-header-logo')), findsNothing);
    expect(find.byKey(const Key('open-profile-settings')), findsNothing);
    expect(find.byKey(const Key('lumi-coming-soon')), findsOneWidget);
    await tester.tap(find.byKey(const Key('lumi-hats-tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lumi-hat-grid')), findsOneWidget);
    await tester.tap(find.byKey(const Key('lumi-lumi-tab')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lumi-body-grid')), findsOneWidget);
    await tester.tap(find.byKey(const Key('lumi-placeholder-body-option')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('placeholder-lumi-image')), findsOneWidget);
    expect(router.state.uri.path, AppRoutes.lumi);

    await tester.tap(find.text('Move').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('select-easy-workout')));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    final startButton = find.byKey(const Key('move-start-selected-workout'));
    await tester.ensureVisible(startButton);
    await tester.pumpAndSettle();
    await tester.tap(startButton);
    await tester.pumpAndSettle();

    expect(find.text('Fullscreen workout'), findsOneWidget);
    expect(find.byKey(const Key('main-bottom-navigation')), findsNothing);
    expect(find.byKey(const Key('open-profile-settings')), findsNothing);
  });
}
