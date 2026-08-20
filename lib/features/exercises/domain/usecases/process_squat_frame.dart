import '../entities/pose_frame_entity.dart';
import '../entities/squat_session.dart';
import '../services/squat_counter.dart';

class ProcessSquatFrame {
  const ProcessSquatFrame(this._counter);
  final SquatCounter _counter;

  SquatSession call(PoseFrameEntity frame) {
    _counter.update(frame);
    return _counter.session;
  }

  SquatSession reset() {
    _counter.reset();
    return _counter.session;
  }
}
