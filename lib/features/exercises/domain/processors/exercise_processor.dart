import '../entities/pose_frame_entity.dart';

enum ExerciseCue {
  getReady,
  moveForward,
  moveBack,
  moveRight,
  moveLeft,
  squatDown,
  standUp,
}

class ExerciseReading {
  const ExerciseReading({required this.repetitions, required this.cue});
  final int repetitions;
  final ExerciseCue cue;
}

abstract interface class ExerciseProcessor {
  String get exerciseId;
  ExerciseReading get reading;
  ExerciseReading process(PoseFrameEntity frame);
  ExerciseReading reset();
}
