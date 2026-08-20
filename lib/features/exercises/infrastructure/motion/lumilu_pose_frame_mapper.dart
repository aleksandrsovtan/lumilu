import 'package:lumilu_motion/lumilu_motion.dart';

import '../../domain/entities/pose_frame_entity.dart';

extension PoseFrameMapper on PoseFrame {
  PoseFrameEntity toEntity() => PoseFrameEntity(
    landmarks: landmarks
        .map((point) => point.toEntity())
        .toList(growable: false),
    worldLandmarks: worldLandmarks
        .map((point) => point.toEntity())
        .toList(growable: false),
  );
}

extension on PoseLandmark {
  PosePoint toEntity() =>
      PosePoint(x: x, y: y, z: z, visibility: visibility, presence: presence);
}
