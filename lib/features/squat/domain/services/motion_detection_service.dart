import '../../../../core/functional/unit.dart';
import '../../../../core/result/result.dart';
import '../entities/pose_frame_entity.dart';

abstract interface class MotionDetectionService {
  Stream<Result<PoseFrameEntity>> get poseFrames;

  Future<Result<Unit>> initialize();
  Future<Result<Unit>> start();
  Future<Result<Unit>> stop();
  Future<Result<Unit>> switchCamera();
  Future<Result<Unit>> dispose();
}
