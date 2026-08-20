import 'exercise_processor.dart';
import 'head_tilt_processor.dart';
import 'head_side_tilt_processor.dart';
import 'squat_processor.dart';

class ExerciseProcessorRegistry {
  const ExerciseProcessorRegistry();

  ExerciseProcessor create(String exerciseId) => switch (exerciseId) {
    'head_nod' ||
    'head_tilt_forward' ||
    'head_tilt_back' => HeadTiltProcessor(),
    'head_turn' => HeadSideTiltProcessor(),
    'squat' => SquatProcessor(),
    _ => throw UnsupportedError('Unknown exercise id: $exerciseId'),
  };
}
