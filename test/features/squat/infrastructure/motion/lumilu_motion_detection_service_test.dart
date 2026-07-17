import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/features/squat/infrastructure/motion/lumilu_motion_data_source.dart';
import 'package:lumilu/features/squat/infrastructure/motion/lumilu_motion_detection_service.dart';
import 'package:lumilu_motion/lumilu_motion.dart';

void main() {
  test('motion lifecycle operations are idempotent', () async {
    final dataSource = _FakeMotionDataSource();
    final service = LumiluMotionDetectionService(dataSource);

    await service.initialize();
    await service.initialize();
    await service.start();
    await service.start();
    await service.stop();
    await service.stop();
    await service.dispose();
    await service.dispose();

    expect(dataSource.initializeCalls, 1);
    expect(dataSource.startCalls, 1);
    expect(dataSource.stopCalls, 1);
    expect(dataSource.disposeCalls, 1);
  });

  test('dispose stops a running detector before releasing it', () async {
    final dataSource = _FakeMotionDataSource();
    final service = LumiluMotionDetectionService(dataSource);

    await service.initialize();
    await service.start();
    await service.dispose();

    expect(dataSource.operations, ['initialize', 'start', 'stop', 'dispose']);
  });
}

class _FakeMotionDataSource implements MotionDataSource {
  int initializeCalls = 0;
  int startCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;
  final operations = <String>[];

  @override
  Stream<PoseFrame> get poseFrames => const Stream.empty();

  @override
  Future<void> initialize() async {
    initializeCalls++;
    operations.add('initialize');
  }

  @override
  Future<void> start() async {
    startCalls++;
    operations.add('start');
  }

  @override
  Future<void> stop() async {
    stopCalls++;
    operations.add('stop');
  }

  @override
  Future<void> switchCamera() async {}

  @override
  Future<void> dispose() async {
    disposeCalls++;
    operations.add('dispose');
  }
}
