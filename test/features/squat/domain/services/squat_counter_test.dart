import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/squat/domain/entities/pose_frame_entity.dart';
import 'package:lumilu/features/squat/domain/entities/squat_session.dart';
import 'package:lumilu/features/squat/domain/services/squat_counter.dart';

void main() {
  test('counts a stable down-to-standing transition', () {
    final counter = SquatCounter(requiredStableFrames: 2);

    counter.update(_frame(180));
    counter.update(_frame(180));
    counter.update(_frame(90));
    counter.update(_frame(90));
    expect(counter.session.phase, SquatPhase.down);
    expect(counter.session.repetitions, 0);

    counter.update(_frame(180));
    expect(counter.session.repetitions, 0);
    expect(counter.update(_frame(180)), isTrue);
    expect(counter.session.repetitions, 1);
  });

  test('ignores an unstable single-frame threshold crossing', () {
    final counter = SquatCounter(requiredStableFrames: 2);
    counter.update(_frame(180));
    counter.update(_frame(180));
    counter.update(_frame(90));
    counter.update(_frame(130));
    counter.update(_frame(180));
    counter.update(_frame(180));
    expect(counter.session.repetitions, 0);
  });
}

PoseFrameEntity _frame(double kneeAngle) {
  const empty = PosePoint(x: 0, y: 0, z: 0, visibility: 1, presence: 1);
  final points = List<PosePoint>.filled(33, empty);
  final radians = kneeAngle * math.pi / 180;
  for (final side in [(23, 25, 27), (24, 26, 28)]) {
    points[side.$1] = const PosePoint(
      x: 1,
      y: 0,
      z: 0,
      visibility: 1,
      presence: 1,
    );
    points[side.$2] = empty;
    points[side.$3] = PosePoint(
      x: math.cos(radians),
      y: math.sin(radians),
      z: 0,
      visibility: 1,
      presence: 1,
    );
  }
  return PoseFrameEntity(landmarks: points, worldLandmarks: points);
}
