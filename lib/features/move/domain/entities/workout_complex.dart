enum WorkoutComplexDifficulty { easy, medium, hard }

/// This is the complete exercise payload expected from the backend.
/// Recognition, hints and movement rules are resolved locally by [id].
class WorkoutExercise {
  const WorkoutExercise({
    required this.id,
    required this.name,
    required this.targetRepetitions,
  });

  final String id;
  final String name;
  final int targetRepetitions;
}

class WorkoutComplex {
  const WorkoutComplex({
    required this.difficulty,
    required this.durationMinutes,
    required this.exercises,
  });

  final WorkoutComplexDifficulty difficulty;
  final int durationMinutes;
  final List<WorkoutExercise> exercises;
  int get exerciseCount => exercises.length;
}
