import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/theme/lumilu_theme.dart';
import 'package:lumilu/features/auth/presentation/pages/auth_form_screen.dart';
import 'package:lumilu/l10n/generated/app_localizations.dart';

void main() {
  Widget buildSubject({
    required AuthFormMode mode,
    SignInAction? signInAction,
    SignUpAction? signUpAction,
    VoidCallback? onSuccess,
    VoidCallback? onSwitchMode,
    ThemeData? theme,
  }) => MaterialApp(
    theme: theme ?? LumiluTheme.light,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: AuthFormScreen(
      mode: mode,
      signInAction: signInAction,
      signUpAction: signUpAction,
      onSuccess: onSuccess ?? () {},
      onSwitchMode: onSwitchMode ?? () {},
    ),
  );

  testWidgets('sign in validates fields and submits normalized email', (
    tester,
  ) async {
    String? submittedEmail;
    String? submittedPassword;
    var succeeded = false;
    await tester.pumpWidget(
      buildSubject(
        mode: AuthFormMode.signIn,
        signInAction: (email, password) async {
          submittedEmail = email;
          submittedPassword = password;
        },
        onSuccess: () => succeeded = true,
      ),
    );

    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pump();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('Enter your password.'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('auth-email')),
      '  lumi@example.com  ',
    );
    await tester.enterText(find.byKey(const Key('auth-password')), 'Secret12');
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(submittedEmail, 'lumi@example.com');
    expect(submittedPassword, 'Secret12');
    expect(succeeded, isTrue);
  });

  testWidgets('sign up collects name, email and password', (tester) async {
    List<String>? submitted;
    await tester.pumpWidget(
      buildSubject(
        mode: AuthFormMode.signUp,
        signUpAction: (name, email, password) async {
          submitted = [name, email, password];
        },
      ),
    );

    await tester.enterText(find.byKey(const Key('auth-name')), ' Lumi ');
    await tester.enterText(
      find.byKey(const Key('auth-email')),
      'lumi@example.com',
    );
    await tester.enterText(find.byKey(const Key('auth-password')), 'Secret12');
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();

    expect(submitted, ['Lumi', 'lumi@example.com', 'Secret12']);
  });

  testWidgets('sign up enforces the password policy', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        mode: AuthFormMode.signUp,
        signUpAction: (name, email, password) async {},
      ),
    );
    await tester.enterText(find.byKey(const Key('auth-name')), 'Lumi');
    await tester.enterText(
      find.byKey(const Key('auth-email')),
      'lumi@example.com',
    );

    for (final password in [
      'short1A',
      'lowercase1',
      'NoNumber',
      'Has Space12',
    ]) {
      await tester.enterText(find.byKey(const Key('auth-password')), password);
      await tester.ensureVisible(find.byKey(const Key('auth-submit')));
      await tester.tap(find.byKey(const Key('auth-submit')));
      await tester.pump();
      expect(find.textContaining('Use at least 8 characters'), findsOneWidget);
    }

    await tester.enterText(find.byKey(const Key('auth-password')), 'Valid123');
    await tester.ensureVisible(find.byKey(const Key('auth-submit')));
    await tester.tap(find.byKey(const Key('auth-submit')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Use at least 8 characters'), findsNothing);
  });

  testWidgets('both auth modes render in the dark theme', (tester) async {
    await tester.pumpWidget(
      buildSubject(mode: AuthFormMode.signIn, theme: LumiluTheme.dark),
    );
    expect(find.byType(AuthFormScreen), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
  });
}
