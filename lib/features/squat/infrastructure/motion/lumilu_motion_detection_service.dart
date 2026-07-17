import 'dart:async';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/functional/either.dart';
import '../../../../core/functional/unit.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/services/motion_detection_service.dart';
import 'lumilu_motion_data_source.dart';
import 'lumilu_pose_frame_mapper.dart';

class LumiluMotionDetectionService implements MotionDetectionService {
  LumiluMotionDetectionService(this._dataSource);
  final MotionDataSource _dataSource;
  bool _initialized = false;
  bool _running = false;
  bool _disposed = false;

  @override
  Stream<Result<PoseFrameEntity>> get poseFrames =>
      _dataSource.poseFrames.transform(
        StreamTransformer.fromHandlers(
          handleData: (frame, sink) => sink.add(Right(frame.toEntity())),
          handleError: (error, stackTrace, sink) =>
              sink.add(Left(_mapFailure(error))),
        ),
      );

  @override
  Future<Result<Unit>> initialize() async {
    if (_disposed) return _disposedFailure();
    if (_initialized) return const Right(unit);
    final result = await _guard(_dataSource.initialize);
    if (result.isRight) _initialized = true;
    return result;
  }

  @override
  Future<Result<Unit>> start() async {
    if (_disposed) return _disposedFailure();
    if (_running) return const Right(unit);
    final result = await _guard(_dataSource.start);
    if (result.isRight) _running = true;
    return result;
  }

  @override
  Future<Result<Unit>> stop() async {
    if (_disposed || !_running) return const Right(unit);
    final result = await _guard(_dataSource.stop);
    if (result.isRight) _running = false;
    return result;
  }

  @override
  Future<Result<Unit>> switchCamera() {
    if (_disposed) return Future.value(_disposedFailure());
    return _guard(_dataSource.switchCamera);
  }

  @override
  Future<Result<Unit>> dispose() async {
    if (_disposed) return const Right(unit);
    final stopped = await stop();
    final result = await _guard(_dataSource.dispose);
    if (result.isRight) {
      _disposed = true;
      _initialized = false;
      _running = false;
    }
    return result.isLeft ? result : stopped;
  }

  Future<Result<Unit>> _guard(Future<void> Function() operation) async {
    try {
      await operation();
      return const Right(unit);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  Result<Unit> _disposedFailure() => const Left(MotionFailure());

  AppFailure _mapFailure(Object error) => switch (error) {
    CameraPermissionException() => const CameraPermissionFailure(),
    MotionNotSupportedException() => const MotionNotSupportedFailure(),
    MotionException() => MotionFailure(cause: error),
    _ => UnexpectedFailure(cause: error),
  };
}
