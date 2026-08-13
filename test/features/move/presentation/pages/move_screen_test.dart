import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/move/presentation/pages/move_screen.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';

void main() {
  for (final scenario in [
    (size: const Size(320, 568), textScale: 1.0),
    (size: const Size(360, 640), textScale: 1.5),
    (size: const Size(430, 932), textScale: 2.0),
  ]) {
    testWidgets(
      'selection animation fits ${scenario.size.width}px at ${scenario.textScale}x text',
      (tester) async {
        tester.view.physicalSize = scenario.size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(scenario.textScale)),
              child: child!,
            ),
            home: Scaffold(
              body: SafeArea(child: MoveScreen(onStartWorkout: () {})),
            ),
          ),
        );

        final selector = find.byKey(const Key('select-medium-workout'));
        await tester.ensureVisible(selector);
        await tester.pumpAndSettle();
        await tester.tap(selector);

        for (var frame = 0; frame < 8; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
          expect(tester.takeException(), isNull);
        }
      },
    );
  }

  testWidgets('custom workout sheet owns controller through dismissal', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SafeArea(child: MoveScreen(onStartWorkout: () {})),
        ),
      ),
    );

    await tester.ensureVisible(find.byKey(const Key('move-custom-workout')));
    await tester.tap(
      find.descendant(
        of: find.byKey(const Key('move-custom-workout')),
        matching: find.byType(InkWell),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('custom-workout-name')),
      'My workout',
    );
    await tester.tap(find.byKey(const Key('create-custom-workout')));

    for (var frame = 0; frame < 5; frame++) {
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    }
    await tester.pumpAndSettle();
    expect(find.text('My workout'), findsOneWidget);
  });

  testWidgets('selection and details are independent interactions', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SafeArea(child: MoveScreen(onStartWorkout: () {})),
        ),
      ),
    );

    final card = find.byKey(const Key('move-easy-workout'));
    final collapsedHeight = tester.getSize(card).height;
    await tester.tap(find.byKey(const Key('select-easy-workout')));
    await tester.pumpAndSettle();
    final selectedHeight = tester.getSize(card).height;
    expect(selectedHeight, greaterThan(collapsedHeight));
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);

    await tester.tap(
      find.descendant(of: card, matching: find.byType(InkWell)).first,
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(card).height, greaterThan(selectedHeight));

    await tester.tap(
      find.descendant(of: card, matching: find.byType(InkWell)).first,
    );
    await tester.pumpAndSettle();
    expect(tester.getSize(card).height, selectedHeight);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });
}
