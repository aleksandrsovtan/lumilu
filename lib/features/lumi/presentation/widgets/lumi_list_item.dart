import 'package:flutter/material.dart';

class LumiListItem extends StatelessWidget {
  const LumiListItem({
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String? assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.14)
            : Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.48)
              : Theme.of(context).colorScheme.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: assetPath == null
          ? const SizedBox.expand()
          : Image.asset(assetPath!, fit: BoxFit.contain),
    ),
  );
}
