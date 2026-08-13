import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../core/theme/lumilu_theme.dart';

class CustomWorkoutCard extends StatelessWidget {
  const CustomWorkoutCard({
    required this.onTap,
    required this.isSelected,
    this.name,
    super.key,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final String? name;

  @override
  Widget build(BuildContext context) => AnimatedScale(
    scale: isSelected ? 1.012 : 1,
    duration: const Duration(milliseconds: 420),
    curve: Curves.easeInOutCubic,
    child: Card(
      margin: EdgeInsets.zero,
      elevation: isSelected ? 4 : 0,
      shadowColor: LumiluColors.lilac400.withValues(alpha: 0.3),
      color: isSelected ? LumiluColors.twilight700 : LumiluColors.twilight800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: isSelected
            ? const BorderSide(color: LumiluColors.lilac400, width: 1.5)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: LumiluColors.lilac400,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    isSelected ? Icons.edit_rounded : Icons.add_rounded,
                    size: 28,
                    color: LumiluColors.twilight900,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? context.l10n.customWorkoutTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        context.l10n.customWorkoutDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: LumiluColors.twilight300,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        context.l10n.createWorkoutAction,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: LumiluColors.lilac400,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: isSelected ? 28 : 24,
                  color: isSelected ? LumiluColors.lilac400 : Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
