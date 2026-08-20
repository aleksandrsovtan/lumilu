import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functional/either.dart';
import '../../../../core/result/result.dart';
import '../../../move/domain/entities/workout_complex.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/processors/exercise_processor.dart';
import '../../domain/processors/exercise_processor_registry.dart';
import '../../domain/services/motion_detection_service.dart';
import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit({
    required this.exercises,
    required MotionDetectionService motion,
    ExerciseProcessorRegistry registry = const ExerciseProcessorRegistry(),
    this.shutdownGracePeriod = const Duration(milliseconds: 300),
  }) : _motion = motion,
       _registry = registry,
       super(const WorkoutState());

  final List<WorkoutExercise> exercises;
  final MotionDetectionService _motion;
  final ExerciseProcessorRegistry _registry;
  final Duration shutdownGracePeriod;
  ExerciseProcessor? _processor;
  StreamSubscription<Result<PoseFrameEntity>>? _frames;
  Timer? _timer;
  Future<void>? _preparingToClose;
  bool _finishing = false;

  Future<void> startCamera() async {
    if (state.stage != WorkoutStage.initial &&
        state.stage != WorkoutStage.failed) {
      return;
    }
    emit(state.copyWith(stage: WorkoutStage.loading));
    final initialized = await _motion.initialize();
    if (isClosed) return;
    if (initialized case Left(:final value)) {
      emit(state.copyWith(stage: WorkoutStage.failed, failure: value));
      return;
    }
    final started = await _motion.start();
    if (isClosed) return;
    if (started case Left(:final value)) {
      emit(state.copyWith(stage: WorkoutStage.failed, failure: value));
      return;
    }
    _frames = _motion.poseFrames.listen(_onFrame);
    emit(state.copyWith(stage: WorkoutStage.positioning));
  }

  void _onFrame(Result<PoseFrameEntity> result) {
    if (isClosed || _finishing) return;
    result.fold((failure) => emit(state.copyWith(failure: failure)), (frame) {
      if (state.stage == WorkoutStage.positioning) {
        final quality = assessPosition(frame);
        emit(
          state.copyWith(
            frame: frame,
            bodyVisible: quality == PositionQuality.ready,
            positionQuality: quality,
          ),
        );
        if (quality == PositionQuality.ready) _startCountdown();
      } else if (state.stage == WorkoutStage.countdown) {
        final quality = assessPosition(frame);
        if (quality != PositionQuality.ready) {
          _timer?.cancel();
          _timer = null;
          emit(
            state.copyWith(
              stage: WorkoutStage.positioning,
              frame: frame,
              bodyVisible: false,
              positionQuality: quality,
              countdown: 3,
            ),
          );
        } else {
          emit(state.copyWith(frame: frame));
        }
      } else if (state.stage == WorkoutStage.active) {
        final quality = assessPosition(frame);
        if (quality != PositionQuality.ready) {
          emit(
            state.copyWith(
              stage: WorkoutStage.positioning,
              frame: frame,
              bodyVisible: false,
              positionQuality: quality,
              resuming: true,
            ),
          );
          return;
        }
        final reading = _processor!.process(frame);
        final previous = state.repetitions;
        emit(
          state.copyWith(
            frame: frame,
            repetitions: reading.repetitions,
            totalMoves:
                state.totalMoves + (reading.repetitions > previous ? 1 : 0),
            cue: reading.cue,
          ),
        );
        if (reading.repetitions >=
            state.exercise(exercises).targetRepetitions) {
          unawaited(_finishExercise());
        }
      } else {
        emit(state.copyWith(frame: frame));
      }
    });
  }

  static PositionQuality assessPosition(PoseFrameEntity frame) {
    if (frame.landmarks.length != 33) return PositionQuality.notVisible;
    const required = [0, 11, 12, 23, 24, 25, 26, 27, 28, 31, 32];
    bool isDetected(int index) {
      final point = frame.landmarks[index];
      return point.visibility >= .55 &&
          point.presence >= .55 &&
          point.x >= 0 &&
          point.x <= 1 &&
          point.y >= 0 &&
          point.y <= 1;
    }

    final detected = required.where(isDetected).length;
    if (detected != required.length) {
      return detected >= 8
          ? PositionQuality.almostReady
          : PositionQuality.notVisible;
    }

    final points = required.map((index) => frame.landmarks[index]);
    final comfortablyInside = points.every(
      (point) =>
          point.x >= .025 &&
          point.x <= .975 &&
          point.y >= .015 &&
          point.y <= .985,
    );
    return comfortablyInside
        ? PositionQuality.ready
        : PositionQuality.almostReady;
  }

  void _startCountdown() {
    if (_timer != null) return;
    emit(state.copyWith(stage: WorkoutStage.countdown, countdown: 3));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) return timer.cancel();
      if (state.countdown > 1) {
        emit(state.copyWith(countdown: state.countdown - 1));
      } else {
        timer.cancel();
        _timer = null;
        if (state.resuming) {
          emit(
            state.copyWith(
              stage: WorkoutStage.active,
              bodyVisible: true,
              positionQuality: PositionQuality.ready,
              resuming: false,
            ),
          );
        } else {
          _beginExercise(state.exerciseIndex);
        }
      }
    });
  }

  void _beginExercise(int index) {
    _processor = _registry.create(exercises[index].id)..reset();
    emit(
      state.copyWith(
        stage: WorkoutStage.active,
        exerciseIndex: index,
        repetitions: 0,
        cue: ExerciseCue.getReady,
        resuming: false,
      ),
    );
  }

  Future<void> _finishExercise() async {
    if (state.exerciseIndex == exercises.length - 1) {
      if (_finishing) return;
      _finishing = true;
      // Keep the native preview mounted until frame delivery and the capture
      // session have fully stopped. Removing it first races platform-view
      // disposal against the camera queue (and crashes consistently on iOS).
      await prepareToClose();
      if (!isClosed) emit(state.copyWith(stage: WorkoutStage.completed));
      return;
    }
    emit(state.copyWith(stage: WorkoutStage.rest, restSeconds: 5));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) return timer.cancel();
      if (state.restSeconds > 1) {
        emit(state.copyWith(restSeconds: state.restSeconds - 1));
      } else {
        skipRest();
      }
    });
  }

  void skipRest() {
    if (state.stage != WorkoutStage.rest) return;
    _timer?.cancel();
    _timer = null;
    _beginExercise(state.exerciseIndex + 1);
  }

  Future<void> togglePause() async {
    if (state.stage == WorkoutStage.active) {
      await _motion.stop();
      if (!isClosed) emit(state.copyWith(stage: WorkoutStage.paused));
    } else if (state.stage == WorkoutStage.paused) {
      await _motion.start();
      if (!isClosed) emit(state.copyWith(stage: WorkoutStage.active));
    }
  }

  void restartExercise() => _beginExercise(state.exerciseIndex);

  Future<void> switchCamera() async => _motion.switchCamera();

  /// Stops frame delivery before the native camera view is removed from the
  /// widget tree. This avoids racing detector shutdown against platform-view
  /// disposal when leaving the workout route.
  Future<void> prepareToClose() async {
    if (_preparingToClose case final pending?) return pending;
    final pending = _prepareToClose();
    _preparingToClose = pending;
    return pending;
  }

  Future<void> _prepareToClose() async {
    _timer?.cancel();
    _timer = null;
    await _frames?.cancel();
    _frames = null;
    await _motion.stop();
    // On iOS the native stop call schedules AVCaptureSession.stopRunning on
    // its serial queue and returns immediately. Give that queue time to drain
    // before route removal disposes the platform view and pose detector.
    if (shutdownGracePeriod > Duration.zero) {
      await Future<void>.delayed(shutdownGracePeriod);
    }
  }

  @override
  Future<void> close() async {
    await prepareToClose();
    await _motion.dispose();
    return super.close();
  }
}
