import 'package:equatable/equatable.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/entities/squat_session.dart';

const _unset = Object();

sealed class SquatState extends Equatable {
  const SquatState();
}

final class SquatInitial extends SquatState {
  const SquatInitial();
  @override
  List<Object> get props => [];
}

final class SquatLoading extends SquatState {
  const SquatLoading();
  @override
  List<Object> get props => [];
}

final class SquatActive extends SquatState {
  const SquatActive({
    required this.session,
    required this.isRunning,
    this.frame,
    this.transientFailure,
  });
  final SquatSession session;
  final PoseFrameEntity? frame;
  final bool isRunning;
  final AppFailure? transientFailure;

  SquatActive copyWith({
    SquatSession? session,
    PoseFrameEntity? frame,
    bool? isRunning,
    Object? transientFailure = _unset,
  }) => SquatActive(
    session: session ?? this.session,
    frame: frame ?? this.frame,
    isRunning: isRunning ?? this.isRunning,
    transientFailure: identical(transientFailure, _unset)
        ? this.transientFailure
        : transientFailure as AppFailure?,
  );

  @override
  List<Object?> get props => [session, frame, isRunning, transientFailure];
}

final class SquatCompleted extends SquatState {
  const SquatCompleted({required this.session, required this.frame});
  final SquatSession session;
  final PoseFrameEntity frame;
  @override
  List<Object> get props => [session, frame];
}

final class SquatFailed extends SquatState {
  const SquatFailed(this.failure);
  final AppFailure failure;
  @override
  List<Object> get props => [failure];
}
