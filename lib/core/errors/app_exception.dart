sealed class AppException implements Exception {
  const AppException(this.message, [this.cause]);
  final String message;
  final Object? cause;
}

final class CameraPermissionException extends AppException {
  const CameraPermissionException() : super('Camera permission is denied.');
}

final class MotionNotSupportedException extends AppException {
  const MotionNotSupportedException()
    : super('Motion detection is not supported.');
}

final class MotionException extends AppException {
  const MotionException(super.message, [super.cause]);
}
