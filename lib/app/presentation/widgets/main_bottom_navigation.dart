import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: NavigationBar(
          key: const Key('main-bottom-navigation'),
          height: 74,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.wb_sunny_outlined),
              selectedIcon: const Icon(Icons.wb_sunny_rounded),
              label: AppLocalizations.of(context)!.todayTab,
            ),
            NavigationDestination(
              icon: const Icon(Icons.directions_run_outlined),
              selectedIcon: const Icon(Icons.directions_run_rounded),
              label: AppLocalizations.of(context)!.moveTab,
            ),
            NavigationDestination(
              icon: const Icon(Icons.auto_awesome_outlined),
              selectedIcon: const Icon(Icons.auto_awesome_rounded),
              label: AppLocalizations.of(context)!.rewardsTab,
            ),
          ],
        ),
      ),
    ),
  );
}
