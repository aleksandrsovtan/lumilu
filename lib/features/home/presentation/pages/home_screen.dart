import 'package:flutter/material.dart';
import '../../../../l10n/generated/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onStartSquats, super.key});

  final VoidCallback onStartSquats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.fitness_center_rounded,
                size: 72,
                color: Color(0xff70e000),
              ),
              const SizedBox(height: 34),
              Text(
                l10n.homeHeadline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
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
