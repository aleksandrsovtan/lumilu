import '../../../../core/result/result.dart';
import '../entities/pose_frame_entity.dart';
import '../services/motion_detection_service.dart';

class ObservePoseFrames {
  const ObservePoseFrames(this._motionDetection);
  final MotionDetectionService _motionDetection;

  Stream<Result<PoseFrameEntity>> call() => _motionDetection.poseFrames;
}
