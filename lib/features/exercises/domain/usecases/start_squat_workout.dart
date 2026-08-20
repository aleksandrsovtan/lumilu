import '../../../../core/errors/app_failure.dart';
import '../../../../core/functional/either.dart';
import '../../../../core/functional/unit.dart';
import '../../../../core/result/result.dart';
import '../services/motion_detection_service.dart';

class StartSquatWorkout {
  const StartSquatWorkout(this._motionDetection);
  final MotionDetectionService _motionDetection;

  Future<Result<Unit>> call({required bool initialize}) async {
    if (initialize) {
      final initialized = await _motionDetection.initialize();
      if (initialized case Left<AppFailure, Unit>()) return initialized;
    }
    return _motionDetection.start();
  }
}
