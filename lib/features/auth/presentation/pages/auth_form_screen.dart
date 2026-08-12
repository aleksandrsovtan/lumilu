import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_up_user.dart';

enum AuthFormMode { signIn, signUp }

typedef SignInAction = Future<void> Function(String email, String password);
typedef SignUpAction =
    Future<void> Function(String name, String email, String password);

class AuthFormScreen extends StatefulWidget {
  const AuthFormScreen({
    required this.mode,
    required this.onSuccess,
    required this.onSwitchMode,
    this.onForgotPassword,
    this.signInAction,
    this.signUpAction,
    super.key,
  });

  final AuthFormMode mode;
  final VoidCallback onSuccess;
  final VoidCallback onSwitchMode;
  final VoidCallback? onForgotPassword;
  final SignInAction? signInAction;
  final SignUpAction? signUpAction;

  @override
  State<AuthFormScreen> createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;
  String? _error;

  bool get _isSignUp => widget.mode == AuthFormMode.signUp;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      if (_isSignUp) {
        final action = widget.signUpAction ?? _defaultSignUp;
        await action(_nameController.text.trim(), email, password);
      } else {
        final action = widget.signInAction ?? _defaultSignIn;
        await action(email, password);
      }
      if (mounted) widget.onSuccess();
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        setState(() => _error = _authError(error.code));
      }
    } on FirebaseException {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context)!.authDatabaseError,
        );
      }
    } on TimeoutException {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context)!.authDatabaseError,
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context)!.unexpectedFailure,
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _defaultSignIn(String email, String password) async {
    await getIt<AuthRepository>().signIn(email: email, password: password);
  }

  Future<void> _defaultSignUp(
    String name,
    String email,
    String password,
  ) async {
    await getIt<SignUpUser>()(name: name, email: email, password: password);
  }

  String _authError(String code) {
    final l10n = AppLocalizations.of(context)!;
    return switch (code) {
      'invalid-email' => l10n.authInvalidEmail,
      'user-disabled' => l10n.authUserDisabled,
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => l10n.authInvalidCredentials,
      'email-already-in-use' => l10n.authEmailInUse,
      'weak-password' => l10n.authWeakPassword,
      'network-request-failed' => l10n.authNetworkError,
      'too-many-requests' => l10n.authTooManyRequests,
      _ => l10n.unexpectedFailure,
    };
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';
    final l10n = AppLocalizations.of(context)!;
    if (!_isSignUp) {
      return password.isEmpty ? l10n.passwordRequired : null;
    }
    final isValid =
        password.length >= 8 &&
        RegExp('[A-Z]').hasMatch(password) &&
        RegExp('[0-9]').hasMatch(password) &&
        RegExp(r'^[\x21-\x7E]+$').hasMatch(password);
    return isValid ? null : l10n.passwordValidation;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/icons/lumilu.webp', height: 68),
                    const SizedBox(height: 18),
                    Text(
                      _isSignUp ? l10n.signUpTitle : l10n.signInTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSignUp
                          ? l10n.signUpDescription
                          : l10n.signInDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: colors.outlineVariant),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.07),
                            blurRadius: 28,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [
                            if (_isSignUp) ...[
                              _AuthField(
                                key: const Key('auth-name'),
                                controller: _nameController,
                                label: l10n.nameLabel,
                                icon: Icons.person_outline_rounded,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    value == null || value.trim().length < 2
                                    ? l10n.nameValidation
                                    : null,
                              ),
                              const SizedBox(height: 16),
                            ],
                            _AuthField(
                              key: const Key('auth-email'),
                              controller: _emailController,
                              label: l10n.emailLabel,
                              icon: Icons.mail_outline_rounded,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                              validator: (value) {
                                final email = value?.trim() ?? '';
                                return RegExp(
                                      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                                    ).hasMatch(email)
                                    ? null
                                    : l10n.emailValidation;
                              },
                            ),
                            const SizedBox(height: 16),
                            _AuthField(
                              key: const Key('auth-password'),
                              controller: _passwordController,
                              label: l10n.passwordLabel,
                              icon: Icons.lock_outline_rounded,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
                              autofillHints: [
                                _isSignUp
                                    ? AutofillHints.newPassword
                                    : AutofillHints.password,
                              ],
                              suffixIcon: IconButton(
                                tooltip: _obscurePassword
                                    ? l10n.showPassword
                                    : l10n.hidePassword,
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              onSubmitted: (_) => _loading ? null : _submit(),
                              validator: _validatePassword,
                            ),
                            if (!_isSignUp && widget.onForgotPassword != null)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  key: const Key('forgot-password'),
                                  onPressed: _loading
                                      ? null
                                      : widget.onForgotPassword,
                                  child: Text(
                                    l10n.forgotPasswordAction,
                                    style: const TextStyle(
                                      color: LumiluColors.lilac600,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            if (_error != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                key: const Key('auth-error'),
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: colors.error.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  _error!,
                                  style: TextStyle(color: colors.error),
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            LumiluButton(
                              key: const Key('auth-submit'),
                              label: _isSignUp
                                  ? l10n.createAccount
                                  : l10n.signInAction,
                              onPressed: _loading ? null : _submit,
                              loading: _loading,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextButton(
                      key: const Key('auth-switch-mode'),
                      onPressed: _loading ? null : widget.onSwitchMode,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${_isSignUp ? l10n.haveAccountPrompt : l10n.noAccountPrompt} ',
                              style: TextStyle(color: colors.onSurfaceVariant),
                            ),
                            TextSpan(
                              text: _isSignUp
                                  ? l10n.signInAction
                                  : l10n.createAccount,
                              style: TextStyle(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? LumiluColors.yellow500
                                    : LumiluColors.lilac600,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.suffixIcon,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    autofillHints: autofillHints,
    obscureText: obscureText,
    validator: validator,
    onFieldSubmitted: onSubmitted,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainer,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: LumiluColors.lilac500, width: 2),
      ),
    ),
  );
}
