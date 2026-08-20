import 'package:equatable/equatable.dart';

class PosePoint extends Equatable {
  const PosePoint({
    required this.x,
    required this.y,
    required this.z,
    required this.visibility,
    required this.presence,
  });

  final double x;
  final double y;
  final double z;
  final double visibility;
  final double presence;

  @override
  List<Object> get props => [x, y, z, visibility, presence];
}

class PoseFrameEntity extends Equatable {
  PoseFrameEntity({
    required List<PosePoint> landmarks,
    required List<PosePoint> worldLandmarks,
  }) : landmarks = List.unmodifiable(landmarks),
       worldLandmarks = List.unmodifiable(worldLandmarks);

  final List<PosePoint> landmarks;
  final List<PosePoint> worldLandmarks;

  @override
  List<Object> get props => [landmarks, worldLandmarks];
}
