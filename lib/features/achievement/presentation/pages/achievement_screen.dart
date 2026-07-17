import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events_rounded,
              size: 96,
              color: Color(0xffffd166),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.achievementTitle,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
            ),
            Text(l10n.achievementDescription),
          ],
        ),
      ),
    );
  }
}
