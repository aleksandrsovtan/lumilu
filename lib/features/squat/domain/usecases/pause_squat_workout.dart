import '../../../../core/functional/unit.dart';
import '../../../../core/result/result.dart';
import '../services/motion_detection_service.dart';

class PauseSquatWorkout {
  const PauseSquatWorkout(this._motionDetection);
  final MotionDetectionService _motionDetection;

  Future<Result<Unit>> call() => _motionDetection.stop();
}
