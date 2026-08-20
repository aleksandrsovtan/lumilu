import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/exercises/domain/entities/pose_frame_entity.dart';
import 'package:lumilu/features/exercises/domain/processors/exercise_processor.dart';
import 'package:lumilu/features/exercises/domain/processors/head_tilt_processor.dart';

void main() {
  test('counts forward then back when the back position is reached', () {
    final processor = HeadTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame(.36));
    processor.process(_frame(.56));
    processor.process(_frame(.56));
    expect(processor.reading.repetitions, 0);
    expect(processor.reading.cue, ExerciseCue.moveBack);
    processor.process(_frame(.18));
    processor.process(_frame(.18));
    expect(processor.reading.repetitions, 1);
    expect(processor.reading.cue, ExerciseCue.moveForward);
  });

  test('does not count when only one half of the cycle is completed', () {
    final processor = HeadTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame(.36));
    processor.process(_frame(.56));
    processor.process(_frame(.56));
    expect(processor.reading.repetitions, 0);
  });

  test('counts the smaller pitch changes produced by a real camera', () {
    final processor = HeadTiltProcessor(requiredStableFrames: 2);
    processor.process(_frame(.36));

    for (var repetition = 1; repetition <= 3; repetition++) {
      processor.process(_frame(.45));
      processor.process(_frame(.45));
      processor.process(_frame(.29));
      processor.process(_frame(.29));
      expect(processor.reading.repetitions, repetition);
    }
  });
}

PoseFrameEntity _frame(double pitch) {
  const point = PosePoint(x: .5, y: .5, z: 0, visibility: 1, presence: 1);
  final points = List<PosePoint>.filled(33, point);
  points[7] = const PosePoint(x: .45, y: .3, z: 0, visibility: 1, presence: 1);
  points[8] = const PosePoint(x: .55, y: .3, z: 0, visibility: 1, presence: 1);
  points[11] = const PosePoint(x: .4, y: .7, z: 0, visibility: 1, presence: 1);
  points[12] = const PosePoint(x: .6, y: .7, z: 0, visibility: 1, presence: 1);
  points[0] = PosePoint(
    x: .5,
    y: .3 + (.4 * pitch),
    z: 0,
    visibility: 1,
    presence: 1,
  );
  return PoseFrameEntity(landmarks: points, worldLandmarks: points);
}
