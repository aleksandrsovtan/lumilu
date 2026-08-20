import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/errors/app_failure.dart';
import 'package:lumilu/core/functional/either.dart';
import 'package:lumilu/core/functional/unit.dart';
import 'package:lumilu/core/result/result.dart';
import 'package:lumilu/features/exercises/domain/entities/pose_frame_entity.dart';
import 'package:lumilu/features/exercises/domain/entities/squat_session.dart';
import 'package:lumilu/features/exercises/domain/services/motion_detection_service.dart';
import 'package:lumilu/features/exercises/domain/services/squat_counter.dart';
import 'package:lumilu/features/exercises/domain/usecases/observe_pose_frames.dart';
import 'package:lumilu/features/exercises/domain/usecases/dispose_squat_workout.dart';
import 'package:lumilu/features/exercises/domain/usecases/pause_squat_workout.dart';
import 'package:lumilu/features/exercises/domain/usecases/process_squat_frame.dart';
import 'package:lumilu/features/exercises/domain/usecases/start_squat_workout.dart';
import 'package:lumilu/features/exercises/domain/usecases/switch_workout_camera.dart';
import 'package:lumilu/features/exercises/presentation/cubit/squat_cubit.dart';
import 'package:lumilu/features/exercises/presentation/cubit/squat_state.dart';

void main() {
  blocTest<SquatCubit, SquatState>(
    'emits loading then active when workout starts successfully',
    build: () => _buildCubit(_FakeMotionDetectionService()),
    act: (cubit) => cubit.start(),
    expect: () => const [
      SquatLoading(),
      SquatActive(session: SquatSession(), isRunning: true),
    ],
  );

  const failure = CameraPermissionFailure();
  blocTest<SquatCubit, SquatState>(
    'emits typed failure when initialization fails',
    build: () => _buildCubit(
      _FakeMotionDetectionService(initializeResult: const Left(failure)),
    ),
    act: (cubit) => cubit.start(),
    expect: () => const [SquatLoading(), SquatFailed(failure)],
  );

  test('ignores a duplicate start call', () async {
    final service = _FakeMotionDetectionService();
    final cubit = _buildCubit(service);

    final first = cubit.start();
    final second = cubit.start();
    await Future.wait([first, second]);

    expect(service.initializeCalls, 1);
    await cubit.close();
  });

  test('waits for pending initialization and disposes on close', () async {
    final initialization = Completer<Result<Unit>>();
    final service = _FakeMotionDetectionService(
      initialization: initialization.future,
    );
    final cubit = _buildCubit(service);

    final start = cubit.start();
    await Future<void>.delayed(Duration.zero);
    final close = cubit.close();
    initialization.complete(const Right(unit));

    await Future.wait([start, close]);
    expect(service.disposeCalls, 1);
  });
}

SquatCubit _buildCubit(MotionDetectionService service) => SquatCubit(
  startWorkout: StartSquatWorkout(service),
  pauseWorkout: PauseSquatWorkout(service),
  disposeWorkout: DisposeSquatWorkout(service),
  processFrame: ProcessSquatFrame(SquatCounter()),
  observeFrames: ObservePoseFrames(service),
  switchCamera: SwitchWorkoutCamera(service),
);

class _FakeMotionDetectionService implements MotionDetectionService {
  _FakeMotionDetectionService({
    this.initializeResult = const Right(unit),
    this.initialization,
  });

  final Result<Unit> initializeResult;
  final Future<Result<Unit>>? initialization;
  int initializeCalls = 0;
  int disposeCalls = 0;
  final _frames = StreamController<Result<PoseFrameEntity>>.broadcast();

  @override
  Stream<Result<PoseFrameEntity>> get poseFrames => _frames.stream;
  @override
  Future<Result<Unit>> initialize() async {
    initializeCalls++;
    return initialization == null ? initializeResult : initialization!;
  }

  @override
  Future<Result<Unit>> start() async => const Right(unit);
  @override
  Future<Result<Unit>> stop() async => const Right(unit);
  @override
  Future<Result<Unit>> switchCamera() async => const Right(unit);
  @override
  Future<Result<Unit>> dispose() async {
    disposeCalls++;
    return const Right(unit);
  }
}
