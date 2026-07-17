import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/usecases/dispose_squat_workout.dart';
import '../../domain/usecases/observe_pose_frames.dart';
import '../../domain/usecases/pause_squat_workout.dart';
import '../../domain/usecases/process_squat_frame.dart';
import '../../domain/usecases/start_squat_workout.dart';
import '../../domain/usecases/switch_workout_camera.dart';
import 'squat_state.dart';

class SquatCubit extends Cubit<SquatState> {
  SquatCubit({
    required StartSquatWorkout startWorkout,
    required PauseSquatWorkout pauseWorkout,
    required DisposeSquatWorkout disposeWorkout,
    required ProcessSquatFrame processFrame,
    required ObservePoseFrames observeFrames,
    required SwitchWorkoutCamera switchCamera,
  }) : _startWorkout = startWorkout,
       _pauseWorkout = pauseWorkout,
       _disposeWorkout = disposeWorkout,
       _processFrame = processFrame,
       _observeFrames = observeFrames,
       _switchCamera = switchCamera,
       super(const SquatInitial());

  static const targetRepetitions = 5;
  final StartSquatWorkout _startWorkout;
  final PauseSquatWorkout _pauseWorkout;
  final DisposeSquatWorkout _disposeWorkout;
  final ProcessSquatFrame _processFrame;
  final ObservePoseFrames _observeFrames;
  final SwitchWorkoutCamera _switchCamera;
  StreamSubscription<Result<PoseFrameEntity>>? _subscription;
  Future<void>? _pendingOperation;
  bool _initialized = false;
  bool _closing = false;

  Future<void> start() {
    if (_closing || isClosed || _initialized || state is SquatLoading) {
      return Future.value();
    }
    return _track(_start());
  }

  Future<void> _start() async {
    emit(const SquatLoading());
    final result = await _startWorkout(initialize: true);
    if (_cannotEmit) return;
    await result.fold((failure) async => emit(SquatFailed(failure)), (_) async {
      _initialized = true;
      await _subscription?.cancel();
      if (_cannotEmit) return;
      _subscription = _observeFrames().listen(_onFrame);
      emit(SquatActive(session: _processFrame.reset(), isRunning: true));
    });
  }

  Future<void> toggle() {
    if (_cannotOperate) return Future.value();
    final current = state;
    if (current is! SquatActive) return Future.value();
    return _track(_toggle(current));
  }

  Future<void> _toggle(SquatActive current) async {
    final result = current.isRunning
        ? await _pauseWorkout()
        : await _startWorkout(initialize: false);
    if (_cannotEmit) return;
    result.fold(
      (failure) => emit(current.copyWith(transientFailure: failure)),
      (_) => emit(
        current.copyWith(isRunning: !current.isRunning, transientFailure: null),
      ),
    );
  }

  void reset() {
    if (_cannotOperate) return;
    final current = state;
    if (current is SquatActive) {
      emit(
        current.copyWith(
          session: _processFrame.reset(),
          transientFailure: null,
        ),
      );
    }
  }

  Future<void> switchCamera() {
    if (_cannotOperate || state is! SquatActive) return Future.value();
    return _track(_switchCameraSafely(state as SquatActive));
  }

  Future<void> _switchCameraSafely(SquatActive current) async {
    final result = await _switchCamera();
    if (_cannotEmit) return;
    result.fold(
      (failure) => emit(current.copyWith(transientFailure: failure)),
      (_) => emit(current.copyWith(transientFailure: null)),
    );
  }

  Future<void> pause() {
    if (_cannotOperate) return Future.value();
    final current = state;
    if (current is! SquatActive || !current.isRunning) return Future.value();
    return _track(_pause(current));
  }

  Future<void> _pause(SquatActive current) async {
    final result = await _pauseWorkout();
    if (_cannotEmit) return;
    result.fold(
      (failure) => emit(current.copyWith(transientFailure: failure)),
      (_) => emit(current.copyWith(isRunning: false, transientFailure: null)),
    );
  }

  void _onFrame(Result<PoseFrameEntity> result) {
    if (_cannotEmit) return;
    result.fold(
      (failure) {
        if (state case final SquatActive current) {
          emit(current.copyWith(transientFailure: failure));
        }
      },
      (frame) {
        final session = _processFrame(frame);
        if (session.repetitions >= targetRepetitions) {
          emit(SquatCompleted(session: session, frame: frame));
          _track(_pauseWorkout().then((_) {}));
        } else if (state case final SquatActive current) {
          emit(
            current.copyWith(
              session: session,
              frame: frame,
              transientFailure: null,
            ),
          );
        }
      },
    );
  }

  bool get _cannotEmit => _closing || isClosed;
  bool get _cannotOperate => _cannotEmit || _pendingOperation != null;

  Future<void> _track(Future<void> operation) {
    _pendingOperation = operation;
    return operation.whenComplete(() {
      if (identical(_pendingOperation, operation)) _pendingOperation = null;
    });
  }

  @override
  Future<void> close() async {
    _closing = true;
    await _pendingOperation;
    await _subscription?.cancel();
    await _disposeWorkout();
    return super.close();
  }
}
