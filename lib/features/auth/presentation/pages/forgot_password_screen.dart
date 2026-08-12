import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';

typedef PasswordResetAction = Future<void> Function(String email);

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    required this.onSendReset,
    required this.onBackToSignIn,
    super.key,
  });

  final PasswordResetAction onSendReset;
  final VoidCallback onBackToSignIn;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
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
      await widget.onSendReset(_emailController.text.trim());
      if (mounted) setState(() => _sent = true);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = switch (error.code) {
          'invalid-email' => l10n.authInvalidEmail,
          'user-not-found' => l10n.passwordResetUserNotFound,
          'network-request-failed' => l10n.authNetworkError,
          'too-many-requests' => l10n.authTooManyRequests,
          _ => l10n.unexpectedFailure,
        };
      });
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [LumiluColors.yellow400, LumiluColors.mint400],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: LumiluColors.yellow500.withValues(alpha: 0.25),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Icon(
                      _sent
                          ? Icons.mark_email_read_rounded
                          : Icons.lock_reset_rounded,
                      size: 43,
                      color: LumiluColors.twilight900,
                    ),
                  ),
                  Text(
                    _sent
                        ? l10n.passwordResetSentTitle
                        : l10n.forgotPasswordTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _sent
                        ? l10n.passwordResetSentDescription(
                            _emailController.text.trim(),
                          )
                        : l10n.forgotPasswordDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!_sent)
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            key: const Key('reset-email'),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.email],
                            onFieldSubmitted: (_) =>
                                _loading ? null : _submit(),
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              return RegExp(
                                    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                                  ).hasMatch(email)
                                  ? null
                                  : l10n.emailValidation;
                            },
                            decoration: InputDecoration(
                              labelText: l10n.emailLabel,
                              prefixIcon: const Icon(
                                Icons.mail_outline_rounded,
                              ),
                              filled: true,
                              fillColor: colors.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: 14),
                            Text(
                              _error!,
                              key: const Key('reset-error'),
                              style: TextStyle(color: colors.error),
                            ),
                          ],
                          const SizedBox(height: 22),
                          LumiluButton(
                            key: const Key('send-reset-email'),
                            label: l10n.sendResetLink,
                            onPressed: _loading ? null : _submit,
                            loading: _loading,
                          ),
                        ],
                      ),
                    ),
                  if (_sent)
                    LumiluButton(
                      key: const Key('back-to-sign-in'),
                      label: l10n.backToSignIn,
                      onPressed: widget.onBackToSignIn,
                    ),
                  if (!_sent) ...[
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: widget.onBackToSignIn,
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: Text(l10n.backToSignIn),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
