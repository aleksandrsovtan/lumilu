import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../domain/entities/workout_complex.dart';
import '../widgets/animated_complex_picker.dart';
import '../widgets/custom_workout_sheet.dart';

class MoveScreen extends StatefulWidget {
  const MoveScreen({required this.onStartWorkout, super.key});

  static const _complexes = [
    WorkoutComplex(
      difficulty: WorkoutComplexDifficulty.easy,
      durationMinutes: 5,
      exercises: [
        WorkoutExercise(
          type: WorkoutExerciseType.breathing,
          durationSeconds: 45,
        ),
        WorkoutExercise(
          type: WorkoutExerciseType.shoulderCircles,
          durationSeconds: 60,
        ),
        WorkoutExercise(
          type: WorkoutExerciseType.sideBends,
          durationSeconds: 60,
        ),
        WorkoutExercise(
          type: WorkoutExerciseType.easySquats,
          durationSeconds: 90,
        ),
      ],
    ),
    WorkoutComplex(
      difficulty: WorkoutComplexDifficulty.medium,
      durationMinutes: 10,
      exercises: [
        WorkoutExercise(type: WorkoutExerciseType.march, durationSeconds: 60),
        WorkoutExercise(
          type: WorkoutExerciseType.jumpingJacks,
          durationSeconds: 60,
        ),
        WorkoutExercise(type: WorkoutExerciseType.squats, durationSeconds: 90),
        WorkoutExercise(
          type: WorkoutExerciseType.kneeRaises,
          durationSeconds: 60,
        ),
        WorkoutExercise(type: WorkoutExerciseType.lunges, durationSeconds: 90),
        WorkoutExercise(type: WorkoutExerciseType.plank, durationSeconds: 45),
        WorkoutExercise(
          type: WorkoutExerciseType.mountainClimbers,
          durationSeconds: 60,
        ),
      ],
    ),
    WorkoutComplex(
      difficulty: WorkoutComplexDifficulty.hard,
      durationMinutes: 15,
      exercises: [
        WorkoutExercise(
          type: WorkoutExerciseType.jumpingJacks,
          durationSeconds: 60,
        ),
        WorkoutExercise(type: WorkoutExerciseType.squats, durationSeconds: 90),
        WorkoutExercise(type: WorkoutExerciseType.pushUps, durationSeconds: 60),
        WorkoutExercise(type: WorkoutExerciseType.lunges, durationSeconds: 90),
        WorkoutExercise(
          type: WorkoutExerciseType.mountainClimbers,
          durationSeconds: 60,
        ),
        WorkoutExercise(
          type: WorkoutExerciseType.jumpSquats,
          durationSeconds: 60,
        ),
        WorkoutExercise(type: WorkoutExerciseType.plank, durationSeconds: 60),
        WorkoutExercise(type: WorkoutExerciseType.burpees, durationSeconds: 60),
        WorkoutExercise(
          type: WorkoutExerciseType.highKnees,
          durationSeconds: 60,
        ),
        WorkoutExercise(
          type: WorkoutExerciseType.bicycleCrunches,
          durationSeconds: 60,
        ),
      ],
    ),
  ];

  final VoidCallback onStartWorkout;

  @override
  State<MoveScreen> createState() => _MoveScreenState();
}

class _MoveScreenState extends State<MoveScreen> {
  WorkoutComplex? _selectedComplex;
  WorkoutComplex? _detailsComplex;
  String? _customWorkoutName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey('move-page'),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.moveTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.moveDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedComplexPicker(
            complexes: MoveScreen._complexes,
            selectedComplex: _selectedComplex,
            customWorkoutName: _customWorkoutName,
            detailsComplex: _detailsComplex,
            onSelectComplex: _selectComplex,
            onToggleDetails: _toggleDetails,
            onSelectCustom: _selectCustomWorkout,
            onStart: widget.onStartWorkout,
          ),
        ],
      ),
    );
  }

  void _selectComplex(WorkoutComplex complex) => setState(() {
    _selectedComplex = complex;
    _customWorkoutName = null;
  });

  void _toggleDetails(WorkoutComplex complex) => setState(() {
    _detailsComplex = _detailsComplex == complex ? null : complex;
  });

  Future<void> _selectCustomWorkout() async {
    final name = await showCustomWorkoutSheet(context);
    if (!mounted || name == null || name.isEmpty) return;
    setState(() {
      _customWorkoutName = name;
      _selectedComplex = null;
      _detailsComplex = null;
    });
  }
}
