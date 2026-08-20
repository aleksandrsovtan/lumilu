import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations_extension.dart';
import '../../../../shared/presentation/extensions/app_failure_l10n.dart';
import '../../../move/domain/entities/workout_complex.dart';
import '../../../move/presentation/extensions/workout_complex_presentation.dart';
import '../../domain/entities/pose_frame_entity.dart';
import '../../domain/processors/exercise_processor.dart';
import '../cubit/workout_cubit.dart';
import '../cubit/workout_state.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({
    required this.complex,
    required this.cameraPreview,
    required this.onDone,
    required this.onClose,
    super.key,
  });
  final WorkoutComplex complex;
  final Widget cameraPreview;
  final VoidCallback onDone;
  final VoidCallback onClose;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  // The detector is attached to the native camera view. Keep that same view
  // alive when the UI moves from setup to workout; recreating it after
  // detector.start() leaves the detector connected to the disposed view.
  final _cameraPreviewKey = GlobalKey();

  bool _closing = false;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) async {
      if (!didPop) await _closeWorkout();
    },
    child: BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final cameraPreview = KeyedSubtree(
          key: _cameraPreviewKey,
          child: widget.cameraPreview,
        );
        return switch (state.stage) {
          WorkoutStage.initial || WorkoutStage.loading || WorkoutStage.failed =>
            _CameraSetup(state: state, cameraPreview: cameraPreview),
          WorkoutStage.completed => _Completed(
            state: state,
            exerciseCount: widget.complex.exerciseCount,
            onDone: widget.onDone,
          ),
          _ => _CameraWorkout(
            state: state,
            exercises: widget.complex.exercises,
            cameraPreview: cameraPreview,
            onClose: widget.onClose,
          ),
        };
      },
    ),
  );

  Future<void> _closeWorkout() async {
    if (_closing) return;
    _closing = true;
    await context.read<WorkoutCubit>().prepareToClose();
    if (mounted) widget.onClose();
  }
}

class _CameraSetup extends StatelessWidget {
  const _CameraSetup({required this.state, required this.cameraPreview});
  final WorkoutState state;
  final Widget cameraPreview;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Stack(
      children: [
        // iOS requires the native platform view to exist before detector.start.
        // Keep it mounted during setup without showing a camera frame yet.
        Positioned(
          left: 0,
          top: 0,
          width: 1,
          height: 1,
          child: IgnorePointer(
            child: Opacity(opacity: 0, child: cameraPreview),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Icon(
                  Icons.phone_iphone_rounded,
                  size: 92,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  context.l10n.workoutGetReadyTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10n.workoutCameraSetupDescription,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  '✓ ${context.l10n.workoutFullBodyVisible}\n✓ ${context.l10n.workoutDistance}\n✓ ${context.l10n.workoutGoodLighting}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.8),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline_rounded, size: 18),
                    const SizedBox(width: 6),
                    Text(context.l10n.workoutPrivacy),
                  ],
                ),
                const Spacer(),
                if (state.stage == WorkoutStage.failed && state.failure != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      state.failure!.localizedMessage(context.l10n),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                FilledButton.icon(
                  key: const Key('open-workout-camera'),
                  onPressed:
                      state.stage == WorkoutStage.initial ||
                          state.stage == WorkoutStage.failed
                      ? context.read<WorkoutCubit>().startCamera
                      : null,
                  icon: state.stage == WorkoutStage.loading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.camera_alt_rounded),
                  label: Text(context.l10n.workoutOpenCamera),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _CameraWorkout extends StatelessWidget {
  const _CameraWorkout({
    required this.state,
    required this.exercises,
    required this.cameraPreview,
    required this.onClose,
  });
  final WorkoutState state;
  final List<WorkoutExercise> exercises;
  final Widget cameraPreview;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final exercise = state.exercise(exercises);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Colors.black),
          cameraPreview,
          CustomPaint(painter: _SkeletonPainter(state.frame)),
          if (state.stage == WorkoutStage.positioning ||
              state.stage == WorkoutStage.countdown)
            _PositionGlow(quality: state.positionQuality),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xAA000000),
                  Colors.transparent,
                  Color(0xBB000000),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () => _confirmClose(context),
                        icon: const Icon(Icons.close),
                      ),
                      const Spacer(),
                      IconButton.filledTonal(
                        onPressed: context.read<WorkoutCubit>().switchCamera,
                        icon: const Icon(Icons.cameraswitch_rounded),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (state.stage == WorkoutStage.positioning) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .58),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        state.positionQuality == PositionQuality.almostReady
                            ? context.l10n.workoutAlmostInFrame
                            : context.l10n.workoutStepAwayFromCamera,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ] else if (state.stage == WorkoutStage.countdown) ...[
                    Text(
                      '${state.countdown}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 112,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ] else if (state.stage == WorkoutStage.rest) ...[
                    Text(
                      context.l10n.workoutAmazing,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        shadows: _cameraTextShadows,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${context.l10n.workoutNext}: ${exercises[state.exerciseIndex + 1].title(context.l10n)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        shadows: _cameraTextShadows,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '00:${state.restSeconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                      onPressed: context.read<WorkoutCubit>().skipRest,
                      child: Text(context.l10n.workoutSkipRest),
                    ),
                  ] else ...[
                    Text(
                      exercise.title(context.l10n),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        shadows: _cameraTextShadows,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${state.repetitions} / ${exercise.targetRepetitions}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 88,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _cue(context, state),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        shadows: _cameraTextShadows,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: state.repetitions / exercise.targetRepetitions,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 24),
                    IconButton.filled(
                      onPressed: context.read<WorkoutCubit>().togglePause,
                      icon: Icon(
                        state.stage == WorkoutStage.paused
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                    ),
                    if (state.stage == WorkoutStage.paused)
                      TextButton(
                        onPressed: context.read<WorkoutCubit>().restartExercise,
                        child: Text(context.l10n.workoutRestartExercise),
                      ),
                  ],
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _cameraTextShadows = [
    Shadow(color: Color(0xCC000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  String _cue(BuildContext context, WorkoutState state) {
    if (state.stage == WorkoutStage.paused) return context.l10n.workoutPaused;
    return switch (state.cue) {
      ExerciseCue.moveForward => context.l10n.headTiltForwardHint,
      ExerciseCue.moveBack => context.l10n.headTiltBackHint,
      ExerciseCue.moveRight => context.l10n.headTurnRightHint,
      ExerciseCue.moveLeft => context.l10n.headTurnLeftHint,
      ExerciseCue.squatDown => context.l10n.squatDown,
      ExerciseCue.standUp => context.l10n.standUp,
      ExerciseCue.getReady => context.l10n.workoutKeepGoing,
    };
  }

  Future<void> _confirmClose(BuildContext context) async {
    final shouldClose = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.workoutExitTitle),
        content: Text(context.l10n.workoutExitDescription),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  key: const Key('end-workout-action'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text(context.l10n.workoutExitAction),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  key: const Key('continue-workout-action'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(context.l10n.workoutStayAction),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (shouldClose != true || !context.mounted) return;
    await context.read<WorkoutCubit>().prepareToClose();
    if (context.mounted) onClose();
  }
}

class _PositionGlow extends StatelessWidget {
  const _PositionGlow({required this.quality});

  final PositionQuality quality;

  @override
  Widget build(BuildContext context) {
    final color = switch (quality) {
      PositionQuality.notVisible => const Color(0xFFE53935),
      PositionQuality.almostReady => const Color(0xFFFF8F00),
      PositionQuality.ready => const Color(0xFF35D07F),
    };
    return IgnorePointer(child: CustomPaint(painter: _EdgeMistPainter(color)));
  }
}

class _EdgeMistPainter extends CustomPainter {
  const _EdgeMistPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final mist = color.withValues(alpha: .52);
    const depth = 46.0;
    final edges = <(Rect, Alignment, Alignment)>[
      (
        Rect.fromLTWH(0, 0, size.width, depth),
        Alignment.topCenter,
        Alignment.bottomCenter,
      ),
      (
        Rect.fromLTWH(0, size.height - depth, size.width, depth),
        Alignment.bottomCenter,
        Alignment.topCenter,
      ),
      (
        Rect.fromLTWH(0, 0, depth, size.height),
        Alignment.centerLeft,
        Alignment.centerRight,
      ),
      (
        Rect.fromLTWH(size.width - depth, 0, depth, size.height),
        Alignment.centerRight,
        Alignment.centerLeft,
      ),
    ];
    for (final edge in edges) {
      final paint = Paint()
        ..shader = LinearGradient(
          begin: edge.$2,
          end: edge.$3,
          colors: [mist, Colors.transparent],
        ).createShader(edge.$1);
      canvas.drawRect(edge.$1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _EdgeMistPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _Completed extends StatelessWidget {
  const _Completed({
    required this.state,
    required this.exerciseCount,
    required this.onDone,
  });
  final WorkoutState state;
  final int exerciseCount;
  final VoidCallback onDone;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '✨',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 80),
            ),
            Text(
              context.l10n.workoutCompleteTitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Metric(
                  value: '${state.totalMoves}',
                  label: context.l10n.workoutMoves,
                ),
                _Metric(
                  value: '$exerciseCount / $exerciseCount',
                  label: context.l10n.workoutExercises,
                ),
              ],
            ),
            const SizedBox(height: 48),
            FilledButton(
              onPressed: onDone,
              child: Text(context.l10n.workoutDone),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
      ),
      Text(label),
    ],
  );
}

class _SkeletonPainter extends CustomPainter {
  const _SkeletonPainter(this.frame);
  final PoseFrameEntity? frame;
  static const connections = [
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
      ..color = const Color(0xFF70D8A8)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    for (final line in connections) {
      canvas.drawLine(
        Offset(points[line.$1].x * size.width, points[line.$1].y * size.height),
        Offset(points[line.$2].x * size.width, points[line.$2].y * size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SkeletonPainter oldDelegate) =>
      oldDelegate.frame != frame;
}
