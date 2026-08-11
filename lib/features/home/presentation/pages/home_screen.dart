import 'package:flutter/material.dart';
import '../../../../l10n/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onStartSquats, required this.onOpenProfile, super.key});

  final VoidCallback onStartSquats;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
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
              Icon(Icons.fitness_center_rounded, size: 72, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 34),
              Text(l10n.homeHeadline, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 14),
              Text(l10n.homeDescription, textAlign: TextAlign.center),
              const Spacer(),
              FilledButton.icon(
                key: const Key('start-squats'),
                onPressed: onStartSquats,
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(l10n.startSquats),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
