import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';
import '../../../../shared/presentation/widgets/lumilu_placeholder_page.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({required this.onStartWorkout, super.key});

  final VoidCallback onStartWorkout;

  @override
  Widget build(BuildContext context) => LumiluPlaceholderPage(
    key: const PageStorageKey('today-page'),
    title: AppLocalizations.of(context)!.homeHeadline,
    description: AppLocalizations.of(context)!.homeDescription,
    icon: Icons.wb_sunny_rounded,
    accent: LumiluColors.yellow500,
    action: LumiluButton(
      key: const Key('start-squats'),
      onPressed: onStartWorkout,
      label: AppLocalizations.of(context)!.startWorkout,
    ),
  );
}
