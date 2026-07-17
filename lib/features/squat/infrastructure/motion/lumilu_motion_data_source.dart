import 'package:lumilu_motion/lumilu_motion.dart';

import '../../../../core/errors/app_exception.dart';

abstract interface class MotionDataSource {
  Stream<PoseFrame> get poseFrames;
  Future<void> initialize();
  Future<void> start();
  Future<void> stop();
  Future<void> switchCamera();
  Future<void> dispose();
}

class LumiluMotionDataSource implements MotionDataSource {
  LumiluMotionDataSource(this.detector);
  final LumiluMotionDetector detector;

  @override
  Stream<PoseFrame> get poseFrames => detector.poseFrames;

  @override
  Future<void> initialize() async {
    if (!await detector.isSupported()) {
      throw const MotionNotSupportedException();
    }
    final permission = await detector.requestCameraPermission();
    if (permission != CameraPermissionStatus.granted) {
      throw const CameraPermissionException();
    }
    await detector.initialize(
      const MotionDetectorConfig(
        cameraFacing: CameraFacing.front,
        numPoses: 1,
        minPoseDetectionConfidence: 0.6,
        minPosePresenceConfidence: 0.6,
        minTrackingConfidence: 0.6,
      ),
    );
  }

  @override
  Future<void> start() => detector.start();
  @override
  Future<void> stop() => detector.stop();
  @override
  Future<void> switchCamera() => detector.switchCamera();

  @override
  Future<void> dispose() async => detector.dispose();
}
