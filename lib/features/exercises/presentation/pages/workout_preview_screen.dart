import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../../move/domain/entities/workout_complex.dart';
import '../../../move/presentation/extensions/workout_complex_presentation.dart';

class WorkoutPreviewScreen extends StatelessWidget {
  const WorkoutPreviewScreen({
    required this.complex,
    required this.onStart,
    super.key,
  });
  final WorkoutComplex complex;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              complex.title(context.l10n),
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              '${complex.durationMinutes} min · ${complex.exerciseCount} exercises',
            ),
            const SizedBox(height: 28),
            for (final exercise in complex.exercises)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  child: Icon(Icons.directions_run_rounded),
                ),
                title: Text(exercise.title(context.l10n)),
                trailing: Text(
                  '× ${exercise.targetRepetitions}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            const Spacer(),
            FilledButton.icon(
              key: const Key('preview-start-workout'),
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(context.l10n.startWorkout),
            ),
          ],
        ),
      ),
    ),
  );
}
