import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/exercises/domain/entities/pose_frame_entity.dart';
import 'package:lumilu/features/exercises/presentation/cubit/workout_cubit.dart';
import 'package:lumilu/features/exercises/presentation/cubit/workout_state.dart';

void main() {
  test('reports red when most of the body is missing', () {
    expect(
      WorkoutCubit.assessPosition(_frame(visibleLandmarks: const {0, 11, 12})),
      PositionQuality.notVisible,
    );
  });

  test('reports orange when the body is detected too close to an edge', () {
    expect(
      WorkoutCubit.assessPosition(_frame(edgeLandmark: 31)),
      PositionQuality.almostReady,
    );
  });

  test('reports green when the full body is comfortably in frame', () {
    expect(WorkoutCubit.assessPosition(_frame()), PositionQuality.ready);
  });
}

PoseFrameEntity _frame({Set<int>? visibleLandmarks, int? edgeLandmark}) {
  const required = {0, 11, 12, 23, 24, 25, 26, 27, 28, 31, 32};
  final visible = visibleLandmarks ?? required;
  final points = List.generate(33, (index) {
    final detected = visible.contains(index);
    return PosePoint(
      x: index == edgeLandmark ? .99 : .5,
      y: .5,
      z: 0,
      visibility: detected ? 1 : 0,
      presence: detected ? 1 : 0,
    );
  });
  return PoseFrameEntity(landmarks: points, worldLandmarks: points);
}
