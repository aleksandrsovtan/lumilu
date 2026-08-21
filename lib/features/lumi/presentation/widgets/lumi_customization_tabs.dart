import 'package:flutter/material.dart';

import '../models/lumi_customization_tab.dart';

class LumiCustomizationTabs extends StatelessWidget {
  const LumiCustomizationTabs({
    required this.selectedTab,
    required this.onSelected,
    super.key,
  });

  final LumiCustomizationTab selectedTab;
  final ValueChanged<LumiCustomizationTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: LumiCustomizationTab.values
            .map(
              (tab) => Expanded(
                child: _CustomizationTabItem(
                  tab: tab,
                  isSelected: selectedTab == tab,
                  onTap: () => onSelected(tab),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CustomizationTabItem extends StatelessWidget {
  const _CustomizationTabItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final LumiCustomizationTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GestureDetector(
        key: Key('lumi-${tab.name}-tab'),
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(height: 56, child: Center(child: tab.icon)),
        ),
      ),
    );
  }
}

extension on LumiCustomizationTab {
  Widget get icon => switch (this) {
    LumiCustomizationTab.achievements => Image.asset(
      'assets/icons/lumi_tab/cup.webp',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
    LumiCustomizationTab.hats => Image.asset(
      'assets/icons/lumi_tab/hat.webp',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
    LumiCustomizationTab.clothes => Image.asset(
      'assets/icons/lumi_tab/clothes.webp',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
    LumiCustomizationTab.accessories => Image.asset(
      'assets/icons/lumi_tab/glasses.webp',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
    LumiCustomizationTab.lumi => Image.asset(
      'assets/icons/nav_bar/lumi.webp',
      width: 28,
      height: 28,
      fit: BoxFit.contain,
    ),
    LumiCustomizationTab.background => Image.asset(
      'assets/icons/lumi_tab/background.webp',
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    ),
  };
}
