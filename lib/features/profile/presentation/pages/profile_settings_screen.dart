import 'package:flutter/material.dart';

import '../../../../core/theme/theme_controller.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({required this.themeController, super.key});

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileSettingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.appearanceTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Card(
            clipBehavior: Clip.antiAlias,
            child: AnimatedBuilder(
              animation: themeController,
              builder: (context, _) => RadioGroup<ThemeMode>(
                groupValue: themeController.themeMode,
                onChanged: (value) {
                  if (value != null) themeController.setThemeMode(value);
                },
                child: Column(
                  children: [
                    _ThemeOption(
                      value: ThemeMode.system,
                      icon: Icons.brightness_auto_rounded,
                      title: l10n.themeSystem,
                      subtitle: l10n.themeSystemDescription,
                    ),
                    const Divider(height: 1),
                    _ThemeOption(
                      value: ThemeMode.light,
                      icon: Icons.light_mode_rounded,
                      title: l10n.themeLight,
                    ),
                    const Divider(height: 1),
                    _ThemeOption(
                      value: ThemeMode.dark,
                      icon: Icons.dark_mode_rounded,
                      title: l10n.themeDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.value,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final ThemeMode value;
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => RadioListTile<ThemeMode>(
    value: value,
    secondary: Icon(icon),
    title: Text(title),
    subtitle: subtitle == null ? null : Text(subtitle!),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  );
}
