import 'package:get_it/get_it.dart';
import 'package:lumilu_motion/lumilu_motion.dart';

import '../../../features/squat/domain/services/squat_counter.dart';
import '../../../features/squat/domain/usecases/dispose_squat_workout.dart';
import '../../../features/squat/domain/usecases/observe_pose_frames.dart';
import '../../../features/squat/domain/usecases/pause_squat_workout.dart';
import '../../../features/squat/domain/usecases/process_squat_frame.dart';
import '../../../features/squat/domain/usecases/start_squat_workout.dart';
import '../../../features/squat/domain/usecases/switch_workout_camera.dart';
import '../../../features/squat/infrastructure/motion/lumilu_motion_data_source.dart';
import '../../../features/squat/infrastructure/motion/lumilu_motion_detection_service.dart';
import '../../../features/squat/presentation/cubit/squat_cubit.dart';

final class SquatModuleMarker {}

final class SquatRouteDependencies {
  SquatRouteDependencies() : detector = LumiluMotionDetector() {
    final service = LumiluMotionDetectionService(
      LumiluMotionDataSource(detector),
    );
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
  late final SquatCubit cubit;
}

void registerSquatModule(GetIt getIt) {
  getIt
    ..registerSingleton(SquatModuleMarker())
    ..registerFactory(SquatRouteDependencies.new);
}
