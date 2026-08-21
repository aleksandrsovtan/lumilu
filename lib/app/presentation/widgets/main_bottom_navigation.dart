import 'package:flutter/material.dart';

import '../../../core/theme/lumilu_theme.dart';
import '../../../l10n/generated/app_localizations.dart';

class MainBottomNavigation extends StatelessWidget {
  const MainBottomNavigation({required this.selectedIndex, required this.onDestinationSelected, super.key});

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).brightness == Brightness.light
              ? LumiluColors.lightText.withValues(alpha: 0.10)
              : Colors.black.withValues(alpha: 0.26),
          blurRadius: 24,
          offset: const Offset(0, -6),
        ),
      ],
    ),
    child: SafeArea(
      top: false,
      minimum: const EdgeInsets.only(top: 4),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: NavigationBar(
          key: const Key('main-bottom-navigation'),
          height: 78,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            NavigationDestination(
              icon: const _NavigationAssetIcon(assetName: 'assets/icons/nav_bar/today.webp'),
              label: AppLocalizations.of(context)!.todayTab,
            ),
            NavigationDestination(
              icon: const _NavigationAssetIcon(assetName: 'assets/icons/nav_bar/move.webp'),
              label: AppLocalizations.of(context)!.moveTab,
            ),
            NavigationDestination(
              icon: const _NavigationAssetIcon(assetName: 'assets/icons/nav_bar/lumi.webp'),
              label: AppLocalizations.of(context)!.rewardsTab,
            ),
          ],
        ),
      ),
    ),
  );
}

class _NavigationAssetIcon extends StatelessWidget {
  const _NavigationAssetIcon({required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) => ImageIcon(AssetImage(assetName), size: 28);
}
