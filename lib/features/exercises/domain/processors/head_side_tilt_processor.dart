import 'dart:math' as math;

import '../entities/pose_frame_entity.dart';
import 'exercise_processor.dart';

enum _SideTiltPhase { right, left }

/// Counts a right -> left lateral head tilt, at the stable left position.
class HeadSideTiltProcessor implements ExerciseProcessor {
  HeadSideTiltProcessor({
    this.requiredStableFrames = 2,
    this.tiltThreshold = .10,
  });

  final int requiredStableFrames;
  final double tiltThreshold;
  int _repetitions = 0;
  int _stableFrames = 0;
  _SideTiltPhase _phase = _SideTiltPhase.right;
  double? _neutralTilt;
  double? _rightDirection;

  // Keep the backend exercise id stable while detecting a lateral tilt.
  @override
  String get exerciseId => 'head_turn';

  @override
  ExerciseReading get reading => ExerciseReading(
    repetitions: _repetitions,
    cue: _phase == _SideTiltPhase.right
        ? ExerciseCue.moveRight
        : ExerciseCue.moveLeft,
  );

  @override
  ExerciseReading process(PoseFrameEntity frame) {
    final tilt = _headTilt(frame);
    if (tilt == null) return reading;
    _neutralTilt ??= tilt;
    final delta = tilt - _neutralTilt!;
    final reachedTarget = _phase == _SideTiltPhase.right
        ? delta.abs() >= tiltThreshold
        : _rightDirection != null && delta * _rightDirection! <= -tiltThreshold;
    if (!reachedTarget) {
      _stableFrames = 0;
      return reading;
    }
    _stableFrames++;
    if (_stableFrames < requiredStableFrames) return reading;
    _stableFrames = 0;
    if (_phase == _SideTiltPhase.right) {
      // Front-camera coordinates may be mirrored, so learn the sign from the
      // first prompted side instead of hard-coding it.
      _rightDirection = delta.sign;
      _phase = _SideTiltPhase.left;
    } else {
      _repetitions++;
      _phase = _SideTiltPhase.right;
    }
    return reading;
  }

  double? _headTilt(PoseFrameEntity frame) {
    final points = frame.landmarks;
    if (points.length != 33) return null;
    final leftEar = points[7];
    final rightEar = points[8];
    final leftShoulder = points[11];
    final rightShoulder = points[12];
    if (![leftEar, rightEar, leftShoulder, rightShoulder].every(_isReliable)) {
      return null;
    }

    final earAngle = math.atan2(
      rightEar.y - leftEar.y,
      (rightEar.x - leftEar.x).abs(),
    );
    final shoulderAngle = math.atan2(
      rightShoulder.y - leftShoulder.y,
      (rightShoulder.x - leftShoulder.x).abs(),
    );
    // Subtract torso roll: leaning the whole body must not count as tilting
    // the head toward a shoulder.
    return earAngle - shoulderAngle;
  }

  bool _isReliable(PosePoint point) =>
      point.visibility >= .55 && point.presence >= .55;

  @override
  ExerciseReading reset() {
    _repetitions = 0;
    _stableFrames = 0;
    _phase = _SideTiltPhase.right;
    _neutralTilt = null;
    _rightDirection = null;
    return reading;
  }
}
