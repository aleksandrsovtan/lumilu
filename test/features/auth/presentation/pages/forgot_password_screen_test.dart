import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('validates email and shows success after sending reset link', (
    tester,
  ) async {
    String? submittedEmail;
    var returned = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ForgotPasswordScreen(
          onSendReset: (email) async => submittedEmail = email,
          onBackToSignIn: () => returned = true,
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('send-reset-email')));
    await tester.pump();
    expect(find.text('Enter a valid email address.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('reset-email')),
      '  lumi@example.com ',
    );
    await tester.tap(find.byKey(const Key('send-reset-email')));
    await tester.pumpAndSettle();

    expect(submittedEmail, 'lumi@example.com');
    expect(find.text('Check your inbox'), findsOneWidget);
    expect(find.textContaining('lumi@example.com'), findsOneWidget);

    await tester.tap(find.byKey(const Key('back-to-sign-in')));
    expect(returned, isTrue);
  });
}
