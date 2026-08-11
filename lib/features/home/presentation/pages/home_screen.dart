import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.onStartSquats,
    required this.onOpenProfile,
    super.key,
  });

  final VoidCallback onStartSquats;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            key: const Key('open-profile-settings'),
            onPressed: onOpenProfile,
            tooltip: l10n.profileSettingsTitle,
            icon: const Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? LumiluColors.twilight700
                        : LumiluColors.mint50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    size: 58,
                    color: LumiluColors.mint400,
                  ),
                ),
              ),
              const SizedBox(height: 34),
              Text(
                l10n.homeHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? LumiluColors.neutral0
                      : LumiluColors.twilight800,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.homeDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? LumiluColors.twilight300
                      : LumiluColors.neutral600,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              LumiluButton(
                key: const Key('start-squats'),
                onPressed: onStartSquats,
                label: l10n.startSquats,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
