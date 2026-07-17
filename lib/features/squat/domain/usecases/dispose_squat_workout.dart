import '../../../../core/functional/unit.dart';
import '../../../../core/result/result.dart';
import '../services/motion_detection_service.dart';

class DisposeSquatWorkout {
  const DisposeSquatWorkout(this._motionDetection);
  final MotionDetectionService _motionDetection;

  Future<Result<Unit>> call() => _motionDetection.dispose();
}
