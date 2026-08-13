enum WorkoutComplexDifficulty { easy, medium, hard }

enum WorkoutExerciseType {
  breathing,
  shoulderCircles,
  sideBends,
  easySquats,
  march,
  jumpingJacks,
  squats,
  kneeRaises,
  lunges,
  plank,
  mountainClimbers,
  pushUps,
  jumpSquats,
  burpees,
  highKnees,
  bicycleCrunches,
}

class WorkoutExercise {
  const WorkoutExercise({required this.type, required this.durationSeconds});

  final WorkoutExerciseType type;
  final int durationSeconds;
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
