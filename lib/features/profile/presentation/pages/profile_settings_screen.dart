import 'package:flutter/material.dart';

import '../../../../core/localization/locale_controller.dart';
import '../../../../core/theme/lumilu_theme.dart';
import '../../../../core/theme/theme_controller.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({
    required this.themeController,
    required this.localeController,
    required this.onLogout,
    super.key,
  });

  final ThemeController themeController;
  final LocaleController localeController;
  final Future<void> Function() onLogout;

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    setState(() => _loggingOut = true);
    try {
      await widget.onLogout();
    } finally {
      if (mounted) setState(() => _loggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileSettingsTitle)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            _SettingsHeader(
              icon: Icons.palette_outlined,
              title: l10n.appearanceTitle,
              subtitle: l10n.appearanceDescription,
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: widget.themeController,
              builder: (context, _) => _SettingsCard(
                child: RadioGroup<ThemeMode>(
                  groupValue: widget.themeController.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      widget.themeController.setThemeMode(value);
                    }
                  },
                  child: Column(
                    children: [
                      _SettingOption(
                        key: const Key('theme-system'),
                        value: ThemeMode.system,
                        icon: Icons.brightness_auto_rounded,
                        title: l10n.themeSystem,
                        subtitle: l10n.themeSystemDescription,
                      ),
                      const Divider(height: 1),
                      _SettingOption(
                        key: const Key('theme-light'),
                        value: ThemeMode.light,
                        icon: Icons.light_mode_rounded,
                        title: l10n.themeLight,
                      ),
                      const Divider(height: 1),
                      _SettingOption(
                        key: const Key('theme-dark'),
                        value: ThemeMode.dark,
                        icon: Icons.dark_mode_rounded,
                        title: l10n.themeDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SettingsHeader(
              icon: Icons.language_rounded,
              title: l10n.languageTitle,
              subtitle: l10n.languageDescription,
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: widget.localeController,
              builder: (context, _) => _SettingsCard(
                child: RadioGroup<String>(
                  groupValue:
                      widget.localeController.locale?.languageCode ?? 'system',
                  onChanged: (value) {
                    widget.localeController.setLocale(switch (value) {
                      'uk' => const Locale('uk'),
                      'en' => const Locale('en'),
                      _ => null,
                    });
                  },
                  child: Column(
                    children: [
                      _SettingOption(
                        key: const Key('language-system'),
                        value: 'system',
                        icon: Icons.settings_suggest_outlined,
                        title: l10n.languageSystem,
                        subtitle: l10n.languageSystemDescription,
                      ),
                      const Divider(height: 1),
                      _SettingOption(
                        key: const Key('language-uk'),
                        value: 'uk',
                        icon: Icons.translate_rounded,
                        title: 'Ukrainian',
                      ),
                      const Divider(height: 1),
                      _SettingOption(
                        key: const Key('language-en'),
                        value: 'en',
                        icon: Icons.translate_rounded,
                        title: 'English',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 34),
            OutlinedButton.icon(
              key: const Key('logout-button'),
              onPressed: _loggingOut ? null : _logout,
              icon: _loggingOut
                  ? SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.error,
                      ),
                    )
                  : const Icon(Icons.logout_rounded),
              label: Text(l10n.logoutAction),
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.error,
                minimumSize: const Size.fromHeight(56),
                side: BorderSide(color: colors.error.withValues(alpha: 0.55)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                textStyle: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? LumiluColors.twilight700
              : LumiluColors.lilac50,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: LumiluColors.lilac600),
      ),
      const SizedBox(width: 13),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    color: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
}

class _SettingOption<T> extends StatelessWidget {
  const _SettingOption({
    required this.value,
    required this.icon,
    required this.title,
    this.subtitle,
    super.key,
  });

  final T value;
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => RadioListTile<T>(
    value: value,
    secondary: Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 21),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
    subtitle: subtitle == null ? null : Text(subtitle!),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
  );
}
