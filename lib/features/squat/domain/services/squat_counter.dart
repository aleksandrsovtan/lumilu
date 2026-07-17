import 'dart:math' as math;

import '../entities/pose_frame_entity.dart';
import '../entities/squat_session.dart';

class SquatCounter {
  SquatCounter({
    this.standingAngle = 160,
    this.downAngle = 100,
    this.minimumLandmarkConfidence = 0.55,
    this.requiredStableFrames = 3,
  }) : assert(downAngle < standingAngle),
       assert(requiredStableFrames > 0);

  final double standingAngle;
  final double downAngle;
  final double minimumLandmarkConfidence;
  final int requiredStableFrames;

  SquatSession session = const SquatSession();
  SquatPhase? _candidatePhase;
  int _candidateFrames = 0;

  bool update(PoseFrameEntity frame) {
    final angle = _kneeAngle(frame);
    if (angle == null) {
      session = SquatSession(repetitions: session.repetitions);
      _clearCandidate();
      return false;
    }
    final candidate = angle <= downAngle
        ? SquatPhase.down
        : angle >= standingAngle
        ? SquatPhase.standing
        : null;
    session = SquatSession(
      repetitions: session.repetitions,
      kneeAngle: angle,
      phase: session.phase,
    );
    if (candidate == null || candidate == session.phase) {
      _clearCandidate();
      return false;
    }
    if (_candidatePhase == candidate) {
      _candidateFrames++;
    } else {
      _candidatePhase = candidate;
      _candidateFrames = 1;
    }
    if (_candidateFrames < requiredStableFrames) return false;
    final completed =
        session.phase == SquatPhase.down && candidate == SquatPhase.standing;
    session = SquatSession(
      repetitions: session.repetitions + (completed ? 1 : 0),
      kneeAngle: angle,
      phase: candidate,
    );
    _clearCandidate();
    return completed;
  }

  void reset() {
    session = const SquatSession();
    _clearCandidate();
  }

  double? _kneeAngle(PoseFrameEntity frame) {
    final points = frame.worldLandmarks.length == 33
        ? frame.worldLandmarks
        : frame.landmarks;
    if (points.length != 33) return null;
    final angles = <double>[];
    _addAngle(angles, points, 23, 25, 27);
    _addAngle(angles, points, 24, 26, 28);
    return angles.isEmpty
        ? null
        : angles.reduce((a, b) => a + b) / angles.length;
  }

  void _addAngle(
    List<double> output,
    List<PosePoint> points,
    int hip,
    int knee,
    int ankle,
  ) {
    final a = points[hip];
    final b = points[knee];
    final c = points[ankle];
    if (![a, b, c].every(_isReliable)) return;
    final bax = a.x - b.x, bay = a.y - b.y, baz = a.z - b.z;
    final bcx = c.x - b.x, bcy = c.y - b.y, bcz = c.z - b.z;
    final lengthA = math.sqrt(bax * bax + bay * bay + baz * baz);
    final lengthC = math.sqrt(bcx * bcx + bcy * bcy + bcz * bcz);
    if (lengthA == 0 || lengthC == 0) return;
    final cosine = ((bax * bcx + bay * bcy + baz * bcz) / (lengthA * lengthC))
        .clamp(-1.0, 1.0);
    output.add(math.acos(cosine) * 180 / math.pi);
  }

  bool _isReliable(PosePoint point) =>
      point.visibility >= minimumLandmarkConfidence &&
      point.presence >= minimumLandmarkConfidence;

  void _clearCandidate() {
    _candidatePhase = null;
    _candidateFrames = 0;
  }
}
