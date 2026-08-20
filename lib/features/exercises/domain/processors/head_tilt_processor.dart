import '../entities/pose_frame_entity.dart';
import 'exercise_processor.dart';

enum _NodPhase { forward, back }

/// Counts a forward -> back head movement, at the stable back position.
class HeadTiltProcessor implements ExerciseProcessor {
  HeadTiltProcessor({
    this.requiredStableFrames = 2,
    this.forwardThreshold = .08,
    this.backThreshold = .06,
  });

  final int requiredStableFrames;
  final double forwardThreshold;
  final double backThreshold;
  int _repetitions = 0;
  int _stableFrames = 0;
  _NodPhase _phase = _NodPhase.forward;
  double? _neutralPitch;

  @override
  String get exerciseId => 'head_nod';

  @override
  ExerciseReading get reading => ExerciseReading(
    repetitions: _repetitions,
    cue: _phase == _NodPhase.forward
        ? ExerciseCue.moveForward
        : ExerciseCue.moveBack,
  );

  @override
  ExerciseReading process(PoseFrameEntity frame) {
    final pitch = _headPitch(frame);
    if (pitch == null) return reading;
    _neutralPitch ??= pitch;
    final delta = pitch - _neutralPitch!;
    final reachedTarget = _phase == _NodPhase.forward
        ? delta >= forwardThreshold
        : delta <= -backThreshold;
    if (!reachedTarget) {
      _stableFrames = 0;
      return reading;
    }
    _stableFrames++;
    if (_stableFrames < requiredStableFrames) return reading;
    _stableFrames = 0;
    if (_phase == _NodPhase.forward) {
      _phase = _NodPhase.back;
    } else {
      _repetitions++;
      _phase = _NodPhase.forward;
    }
    return reading;
  }

  double? _headPitch(PoseFrameEntity frame) {
    final points = frame.landmarks;
    if (points.length != 33) return null;
    final nose = points[0];
    final ears = [points[7], points[8]];
    final shoulders = [points[11], points[12]];
    if (![nose, ...ears, ...shoulders].every(_isReliable)) return null;
    final earY = (ears[0].y + ears[1].y) / 2;
    final neckLength = ((shoulders[0].y + shoulders[1].y) / 2) - earY;
    if (neckLength.abs() < .01) return null;
    return (nose.y - earY) / neckLength;
  }

  bool _isReliable(PosePoint point) =>
      point.visibility >= .55 && point.presence >= .55;

  @override
  ExerciseReading reset() {
    _repetitions = 0;
    _stableFrames = 0;
    _phase = _NodPhase.forward;
    _neutralPitch = null;
    return reading;
  }
}
