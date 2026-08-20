import '../entities/pose_frame_entity.dart';
import '../services/squat_counter.dart';
import 'exercise_processor.dart';

class SquatProcessor implements ExerciseProcessor {
  SquatProcessor([SquatCounter? counter])
    : _counter = counter ?? SquatCounter();
  final SquatCounter _counter;

  @override
  String get exerciseId => 'squat';

  @override
  ExerciseReading get reading => ExerciseReading(
    repetitions: _counter.session.repetitions,
    cue: switch (_counter.session.phase.name) {
      'down' => ExerciseCue.standUp,
      _ => ExerciseCue.squatDown,
    },
  );

  @override
  ExerciseReading process(PoseFrameEntity frame) {
    _counter.update(frame);
    return reading;
  }

  @override
  ExerciseReading reset() {
    _counter.reset();
    return reading;
  }
}
