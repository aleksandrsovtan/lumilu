import 'package:equatable/equatable.dart';

sealed class AppFailure extends Equatable {
  const AppFailure({this.cause});
  final Object? cause;

  @override
  List<Object?> get props => [cause];
}

final class CameraPermissionFailure extends AppFailure {
  const CameraPermissionFailure();
}

final class MotionNotSupportedFailure extends AppFailure {
  const MotionNotSupportedFailure();
}

final class MotionFailure extends AppFailure {
  const MotionFailure({super.cause});
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({super.cause});
}
