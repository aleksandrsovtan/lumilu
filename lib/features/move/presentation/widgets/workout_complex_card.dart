import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/workout_complex.dart';
import '../extensions/workout_complex_presentation.dart';

class WorkoutComplexCard extends StatelessWidget {
  const WorkoutComplexCard({
    required this.complex,
    required this.exerciseItemHeight,
    required this.isSelected,
    required this.isCompact,
    required this.onToggleDetails,
    required this.onSelect,
    super.key,
  });

  final WorkoutComplex complex;
  final double exerciseItemHeight;
  final bool isSelected;
  final bool isCompact;
  final VoidCallback onToggleDetails;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) => AnimatedScale(
    scale: isSelected ? 1.012 : 1,
    duration: const Duration(milliseconds: 420),
    curve: Curves.easeInOutCubic,
    child: Card(
      margin: EdgeInsets.zero,
      elevation: isSelected ? 4 : 0,
      shadowColor: complex.accentColor.withValues(alpha: 0.28),
      color: isSelected
          ? Color.alphaBlend(
              complex.accentColor.withValues(alpha: 0.10),
              Theme.of(context).colorScheme.surface,
            )
          : Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: isSelected
            ? BorderSide(color: complex.accentColor, width: 1.5)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: onToggleDetails,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _Summary(
                complex: complex,
                isSelected: isSelected,
                onSelect: onSelect,
              ),
              Expanded(
                child: ClipRect(
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 520),
                        curve: Curves.easeInOutCubicEmphasized,
                        top: isCompact ? -16 : 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 280),
                          opacity: isCompact ? 0 : 1,
                          child: _ExerciseDetails(
                            complex: complex,
                            exerciseItemHeight: exerciseItemHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.complex,
    required this.isSelected,
    required this.onSelect,
  });

  final WorkoutComplex complex;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: complex.accentColor.withValues(alpha: 0.24),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Text(complex.emoji, style: const TextStyle(fontSize: 26)),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              complex.title(context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(
              complex.description(context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              complex.meta(context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      IconButton(
        key: Key('select-${complex.difficulty.name}-workout'),
        tooltip: complex.title(context.l10n),
        onPressed: onSelect,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          child: Icon(
            isSelected
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            key: ValueKey(isSelected),
            size: isSelected ? 28 : 24,
            color: isSelected
                ? complex.accentColor
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    ],
  );
}

class _ExerciseDetails extends StatelessWidget {
  const _ExerciseDetails({
    required this.complex,
    required this.exerciseItemHeight,
  });

  final WorkoutComplex complex;
  final double exerciseItemHeight;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 15),
      Divider(
        height: 1,
        thickness: 1,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      const SizedBox(height: 12),
      for (var index = 0; index < complex.exercises.length; index++)
        _ExerciseRow(
          number: index + 1,
          exercise: complex.exercises[index],
          accent: complex.accentColor,
          height: exerciseItemHeight,
        ),
      const SizedBox(height: 12),
    ],
  );
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.number,
    required this.exercise,
    required this.accent,
    required this.height,
  });

  final int number;
  final WorkoutExercise exercise;
  final Color accent;
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: accent.withValues(alpha: 0.22),
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            child: Text(
              '$number',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        exercise.title(context.l10n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      exercise.duration(context.l10n),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      exercise.description(context.l10n),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
