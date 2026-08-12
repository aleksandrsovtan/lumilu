import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_placeholder_page.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) => LumiluPlaceholderPage(
    key: const PageStorageKey('rewards-page'),
    title: AppLocalizations.of(context)!.rewardsPlaceholderTitle,
    description: AppLocalizations.of(context)!.rewardsPlaceholderDescription,
    icon: Icons.auto_awesome_rounded,
    accent: LumiluColors.lilac400,
  );
}
