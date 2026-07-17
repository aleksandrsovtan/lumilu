import 'package:equatable/equatable.dart';

enum SquatPhase { unknown, standing, down }

class SquatSession extends Equatable {
  const SquatSession({
    this.repetitions = 0,
    this.kneeAngle,
    this.phase = SquatPhase.unknown,
  });

  final int repetitions;
  final double? kneeAngle;
  final SquatPhase phase;

  @override
  List<Object?> get props => [repetitions, kneeAngle, phase];
}
