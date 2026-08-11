import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/extensions/app_failure_l10n.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/entities/squat_session.dart';
import '../cubit/squat_cubit.dart';
import '../cubit/squat_state.dart';

class SquatScreen extends StatefulWidget {
  const SquatScreen({
    required this.cameraPreview,
    required this.onFinished,
    super.key,
  });
  final Widget cameraPreview;
  final VoidCallback onFinished;

  @override
  State<SquatScreen> createState() => _SquatScreenState();
}

class _SquatScreenState extends State<SquatScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<SquatCubit>().start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      context.read<SquatCubit>().pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<SquatCubit, SquatState>(
    listenWhen: (previous, current) => current is SquatCompleted,
    listener: (context, state) => widget.onFinished(),
    builder: (context, state) {
      final l10n = AppLocalizations.of(context)!;
      final session = switch (state) {
        SquatActive(:final session) => session,
        SquatCompleted(:final session) => session,
        _ => const SquatSession(),
      };
      final frame = switch (state) {
        SquatActive(:final frame) => frame,
        SquatCompleted(:final frame) => frame,
        _ => null,
      };
      final isRunning = state is SquatActive && state.isRunning;

      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: Colors.black),
            widget.cameraPreview,
            CustomPaint(painter: _SkeletonPainter(frame)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(l10n.squatWorkoutTitle, textAlign: TextAlign.center),
                    const Spacer(),
                    Text(
                      '${session.repetitions}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 104,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    LinearProgressIndicator(
                      value: session.repetitions / SquatCubit.targetRepetitions,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _hint(l10n, state, frame, session.phase),
                      textAlign: TextAlign.center,
                    ),
                    if (session.kneeAngle case final angle?)
                      Text(
                        l10n.kneeAngle(angle.round()),
                        textAlign: TextAlign.center,
                      ),
                    if (state is SquatLoading)
                      const Padding(
                        padding: EdgeInsets.all(18),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state case SquatFailed(:final failure))
                      Text(
                        failure.localizedMessage(AppLocalizations.of(context)!),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    if (state case SquatActive(:final transientFailure?))
                      Text(
                        transientFailure.localizedMessage(
                          AppLocalizations.of(context)!,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.orangeAccent),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: state is SquatActive
                              ? context.read<SquatCubit>().toggle
                              : null,
                          icon: Icon(
                            isRunning ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        IconButton.filledTonal(
                          onPressed: state is SquatActive
                              ? context.read<SquatCubit>().reset
                              : null,
                          icon: const Icon(Icons.refresh),
                        ),
                        IconButton.filledTonal(
                          onPressed: state is SquatActive
                              ? context.read<SquatCubit>().switchCamera
                              : null,
                          icon: const Icon(Icons.cameraswitch),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  String _hint(
    AppLocalizations l10n,
    SquatState state,
    PoseFrameEntity? frame,
    SquatPhase phase,
  ) {
    if (state is SquatFailed) return l10n.cameraUnavailable;
    if (state is! SquatActive || !state.isRunning) return l10n.pressStart;
    if (frame?.landmarks.length != 33) return l10n.standFullyInFrame;
    return switch (phase) {
      SquatPhase.down => l10n.standUp,
      SquatPhase.standing => l10n.squatDown,
      SquatPhase.unknown => l10n.standStraight,
    };
  }
}

class _SkeletonPainter extends CustomPainter {
  const _SkeletonPainter(this.frame);
  final PoseFrameEntity? frame;
  static const connections = <(int, int)>[
    (11, 12),
    (11, 13),
    (13, 15),
    (12, 14),
    (14, 16),
    (11, 23),
    (12, 24),
    (23, 24),
    (23, 25),
    (25, 27),
    (24, 26),
    (26, 28),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final points = frame?.landmarks ?? const <PosePoint>[];
    if (points.length != 33) return;
    final paint = Paint()
      ..color = LumiluColors.green500
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Offset point(int index) =>
        Offset(points[index].x * size.width, points[index].y * size.height);
    for (final connection in connections) {
      canvas.drawLine(point(connection.$1), point(connection.$2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SkeletonPainter oldDelegate) =>
      oldDelegate.frame != frame;
}
