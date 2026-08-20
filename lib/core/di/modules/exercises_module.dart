import 'package:get_it/get_it.dart';
import 'package:lumilu_motion/lumilu_motion.dart';

import '../../../features/exercises/domain/services/squat_counter.dart';
import '../../../features/exercises/domain/usecases/dispose_squat_workout.dart';
import '../../../features/exercises/domain/usecases/observe_pose_frames.dart';
import '../../../features/exercises/domain/usecases/pause_squat_workout.dart';
import '../../../features/exercises/domain/usecases/process_squat_frame.dart';
import '../../../features/exercises/domain/usecases/start_squat_workout.dart';
import '../../../features/exercises/domain/usecases/switch_workout_camera.dart';
import '../../../features/exercises/infrastructure/motion/lumilu_motion_data_source.dart';
import '../../../features/exercises/infrastructure/motion/lumilu_motion_detection_service.dart';
import '../../../features/exercises/presentation/cubit/squat_cubit.dart';

final class ExercisesModuleMarker {}

final class ExerciseRouteDependencies {
  ExerciseRouteDependencies() : detector = LumiluMotionDetector() {
    service = LumiluMotionDetectionService(LumiluMotionDataSource(detector));
    cubit = SquatCubit(
      startWorkout: StartSquatWorkout(service),
      pauseWorkout: PauseSquatWorkout(service),
      disposeWorkout: DisposeSquatWorkout(service),
      processFrame: ProcessSquatFrame(SquatCounter()),
      observeFrames: ObservePoseFrames(service),
      switchCamera: SwitchWorkoutCamera(service),
    );
  }

  final LumiluMotionDetector detector;
  late final LumiluMotionDetectionService service;
  late final SquatCubit cubit;
}

void registerExercisesModule(GetIt getIt) {
  getIt
    ..registerSingleton(ExercisesModuleMarker())
    ..registerFactory(ExerciseRouteDependencies.new);
}
