import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/exercises/domain/entities/pose_frame_entity.dart';
import 'package:lumilu/features/exercises/domain/processors/exercise_processor.dart';
import 'package:lumilu/features/exercises/domain/processors/head_side_tilt_processor.dart';

void main() {
  test('counts a stable right then left lateral head tilt', () {
    final processor = HeadSideTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame());
    processor.process(_frame(headTilt: .14));
    processor.process(_frame(headTilt: .14));
    expect(processor.reading.repetitions, 0);
    expect(processor.reading.cue, ExerciseCue.moveLeft);
    processor.process(_frame(headTilt: -.14));
    processor.process(_frame(headTilt: -.14));
    expect(processor.reading.repetitions, 1);
    expect(processor.reading.cue, ExerciseCue.moveRight);
  });

  test('counts lateral tilts with mirrored front-camera coordinates', () {
    final processor = HeadSideTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame(mirrored: true));
    processor.process(_frame(headTilt: .14, mirrored: true));
    processor.process(_frame(headTilt: .14, mirrored: true));
    processor.process(_frame(headTilt: -.14, mirrored: true));
    processor.process(_frame(headTilt: -.14, mirrored: true));
    expect(processor.reading.repetitions, 1);
  });

  test('does not count when the head and torso lean together', () {
    final processor = HeadSideTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame());
    processor.process(_frame(bodyTilt: .18));
    processor.process(_frame(bodyTilt: .18));
    expect(processor.reading.repetitions, 0);
    expect(processor.reading.cue, ExerciseCue.moveRight);
  });
}

PoseFrameEntity _frame({
  double headTilt = 0,
  double bodyTilt = 0,
  bool mirrored = false,
}) {
  const point = PosePoint(x: .5, y: .5, z: 0, visibility: 1, presence: 1);
  final points = List<PosePoint>.filled(33, point);
  final earAngle = headTilt + bodyTilt;
  final shoulderAngle = bodyTilt;
  points[7] = _angledPoint(.5, .3, -.1, earAngle);
  points[8] = _angledPoint(.5, .3, .1, earAngle);
  points[11] = _angledPoint(.5, .55, -.2, shoulderAngle);
  points[12] = _angledPoint(.5, .55, .2, shoulderAngle);
  if (mirrored) {
    points[7] = _mirror(points[7]);
    points[8] = _mirror(points[8]);
    points[11] = _mirror(points[11]);
    points[12] = _mirror(points[12]);
  }
  return PoseFrameEntity(landmarks: points, worldLandmarks: points);
}

PosePoint _angledPoint(double cx, double cy, double offset, double angle) =>
    PosePoint(
      x: cx + (offset * math.cos(angle)),
      y: cy + (offset * math.sin(angle)),
      z: 0,
      visibility: 1,
      presence: 1,
    );

PosePoint _mirror(PosePoint point) => PosePoint(
  x: 1 - point.x,
  y: point.y,
  z: point.z,
  visibility: point.visibility,
  presence: point.presence,
);
