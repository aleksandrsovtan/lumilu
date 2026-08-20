import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../move/domain/entities/workout_complex.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/processors/exercise_processor.dart';

enum WorkoutStage {
  initial,
  loading,
  positioning,
  countdown,
  active,
  paused,
  rest,
  completed,
  failed,
}

enum PositionQuality { notVisible, almostReady, ready }

class WorkoutState extends Equatable {
  const WorkoutState({
    this.stage = WorkoutStage.initial,
    this.exerciseIndex = 0,
    this.repetitions = 0,
    this.totalMoves = 0,
    this.countdown = 3,
    this.restSeconds = 5,
    this.bodyVisible = false,
    this.positionQuality = PositionQuality.notVisible,
    this.resuming = false,
    this.cue = ExerciseCue.getReady,
    this.frame,
    this.failure,
  });

  final WorkoutStage stage;
  final int exerciseIndex;
  final int repetitions;
  final int totalMoves;
  final int countdown;
  final int restSeconds;
  final bool bodyVisible;
  final PositionQuality positionQuality;
  final bool resuming;
  final ExerciseCue cue;
  final PoseFrameEntity? frame;
  final AppFailure? failure;

  WorkoutExercise exercise(List<WorkoutExercise> exercises) =>
      exercises[exerciseIndex.clamp(0, exercises.length - 1)];

  WorkoutState copyWith({
    WorkoutStage? stage,
    int? exerciseIndex,
    int? repetitions,
    int? totalMoves,
    int? countdown,
    int? restSeconds,
    bool? bodyVisible,
    PositionQuality? positionQuality,
    bool? resuming,
    ExerciseCue? cue,
    PoseFrameEntity? frame,
    AppFailure? failure,
  }) => WorkoutState(
    stage: stage ?? this.stage,
    exerciseIndex: exerciseIndex ?? this.exerciseIndex,
    repetitions: repetitions ?? this.repetitions,
    totalMoves: totalMoves ?? this.totalMoves,
    countdown: countdown ?? this.countdown,
    restSeconds: restSeconds ?? this.restSeconds,
    bodyVisible: bodyVisible ?? this.bodyVisible,
    positionQuality: positionQuality ?? this.positionQuality,
    resuming: resuming ?? this.resuming,
    cue: cue ?? this.cue,
    frame: frame ?? this.frame,
    failure: failure ?? this.failure,
  );

  @override
  List<Object?> get props => [
    stage,
    exerciseIndex,
    repetitions,
    totalMoves,
    countdown,
    restSeconds,
    bodyVisible,
    positionQuality,
    resuming,
    cue,
    frame,
    failure,
  ];
}
