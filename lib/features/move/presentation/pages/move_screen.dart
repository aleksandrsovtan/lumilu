import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';
import '../../../../shared/presentation/widgets/lumilu_placeholder_page.dart';

class MoveScreen extends StatelessWidget {
  const MoveScreen({required this.onStartWorkout, super.key});

  final VoidCallback onStartWorkout;

  @override
  Widget build(BuildContext context) => LumiluPlaceholderPage(
    key: const PageStorageKey('move-page'),
    title: AppLocalizations.of(context)!.movePlaceholderTitle,
    description: AppLocalizations.of(context)!.movePlaceholderDescription,
    icon: Icons.directions_run_rounded,
    accent: LumiluColors.mint400,
    action: LumiluButton(
      key: const Key('move-start-workout'),
      onPressed: onStartWorkout,
      label: AppLocalizations.of(context)!.startWorkout,
    ),
  );
}
