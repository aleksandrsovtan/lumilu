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
      exercises: _exercises,
    ),
    WorkoutComplex(
      difficulty: WorkoutComplexDifficulty.medium,
      durationMinutes: 10,
      exercises: _exercises,
    ),
    WorkoutComplex(
      difficulty: WorkoutComplexDifficulty.hard,
      durationMinutes: 15,
      exercises: _exercises,
    ),
  ];

  static const _exercises = [
    WorkoutExercise(
      id: 'head_nod',
      name: 'Head forward and back',
      targetRepetitions: 5,
    ),
    WorkoutExercise(
      id: 'head_turn',
      name: 'Head right and left',
      targetRepetitions: 5,
    ),
    WorkoutExercise(id: 'squat', name: 'Squats', targetRepetitions: 5),
  ];

  /// Supports both the existing zero-argument callback and a callback that
  /// receives the selected backend-shaped workout.
  final Function onStartWorkout;

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
            onStart: () {
              final complex = _selectedComplex;
              if (complex == null) return;
              final callback = widget.onStartWorkout;
              if (callback is ValueChanged<WorkoutComplex>) {
                callback(complex);
              } else {
                (callback as VoidCallback)();
              }
            },
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
