import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';

class SplashGate extends StatefulWidget {
  const SplashGate({required this.child, super.key});

  final Widget child;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..forward();

  late final Animation<double> _exitOpacity = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(1.0), weight: 82),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 18,
    ),
  ]).animate(_controller);

  late final Animation<double> _welcomeEntrance = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.78, 1, curve: Curves.easeOutCubic),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      AnimatedBuilder(
        animation: _welcomeEntrance,
        child: widget.child,
        builder: (context, child) => Opacity(
          opacity: _welcomeEntrance.value,
          child: Transform.scale(
            scale: 1.025 - 0.025 * _welcomeEntrance.value,
            child: child,
          ),
        ),
      ),
      AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isCompleted) return const SizedBox.shrink();
          return IgnorePointer(
            child: Opacity(
              opacity: _exitOpacity.value,
              child: SplashScreen(progress: _controller.value),
            ),
          );
        },
      ),
    ],
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({required this.progress, super.key});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final entrance = Curves.easeOutBack.transform(
      ((progress - 0.04) / 0.30).clamp(0.0, 1.0),
    );
    final titleOpacity = Curves.easeOut.transform(
      ((progress - 0.20) / 0.22).clamp(0.0, 1.0),
    );

    return ColoredBox(
      color: isDark ? LumiluColors.twilight900 : LumiluColors.neutral100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isDark
              ? const RadialGradient(
                  center: Alignment(0, -0.06),
                  radius: 1.05,
                  colors: [LumiluColors.twilight700, LumiluColors.twilight900],
                  stops: [0, 0.82],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    LumiluColors.neutral50,
                    Color(0xFFF3F1F8),
                    LumiluColors.neutral100,
                  ],
                  stops: [0, 0.52, 1],
                ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _TwinklePainter(progress, isDark: isDark)),
            SafeArea(
              child: Center(
                child: Transform.translate(
                  offset: const Offset(0, -24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.scale(
                        scale: 0.82 + entrance * 0.18,
                        child: Opacity(
                          opacity: entrance.clamp(0.0, 1.0),
                          child: Container(
                            width: 224,
                            height: 224,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: LumiluColors.yellow500.withValues(
                                    alpha:
                                        0.10 +
                                        0.08 *
                                            math
                                                .sin(progress * math.pi * 5)
                                                .abs(),
                                  ),
                                  blurRadius: 56,
                                  spreadRadius: 8,
                                ),
                                BoxShadow(
                                  color: LumiluColors.lilac400.withValues(
                                    alpha: isDark ? 0.16 : 0.12,
                                  ),
                                  blurRadius: 88,
                                  spreadRadius: 16,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/icons/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Opacity(
                        opacity: titleOpacity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 260),
                            child: Image.asset(
                              'assets/icons/lumilu.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TwinklePainter extends CustomPainter {
  const _TwinklePainter(this.progress, {required this.isDark});

  final double progress;
  final bool isDark;

  static const _lights = [
    (0.20, 0.36, 2.1, 0.0, LumiluColors.yellow400),
    (0.80, 0.40, 1.5, 0.7, LumiluColors.mint400),
    (0.14, 0.53, 1.4, 1.4, LumiluColors.lilac400),
    (0.87, 0.57, 2.0, 2.1, LumiluColors.yellow500),
    (0.24, 0.66, 1.3, 2.8, LumiluColors.mint400),
    (0.76, 0.69, 1.6, 3.5, LumiluColors.lilac400),
    (0.32, 0.43, 0.9, 4.2, LumiluColors.yellow400),
    (0.69, 0.32, 1.0, 4.9, LumiluColors.mint400),
    (0.39, 0.71, 0.8, 5.6, LumiluColors.lilac400),
    (0.61, 0.48, 1.1, 6.1, LumiluColors.yellow400),
    (0.08, 0.61, 0.8, 0.9, LumiluColors.mint400),
    (0.92, 0.48, 0.9, 2.5, LumiluColors.lilac400),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < _lights.length; index++) {
      final (x, y, radius, phase, color) = _lights[index];
      final pulse = math
          .pow(
            (math.sin(progress * math.pi * (5 + index % 4) + phase) + 1) / 2,
            3,
          )
          .toDouble();
      final center = Offset(size.width * x, size.height * y);
      final displayColor = isDark
          ? color
          : Color.lerp(color, LumiluColors.twilight700, 0.32)!;
      final glow = Paint()
        ..color = displayColor.withValues(alpha: (isDark ? 0.18 : 0.10) * pulse)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, isDark ? 8 : 5);
      final core = Paint()
        ..color = displayColor.withValues(
          alpha: isDark ? 0.25 + 0.75 * pulse : 0.42 + 0.58 * pulse,
        );

      canvas.drawCircle(center, radius * (2.4 + pulse), glow);
      canvas.drawCircle(center, radius * (0.45 + pulse * 0.55), core);
      if (pulse > 0.72) {
        final ray = radius * 2.8 * pulse;
        final rayPaint = Paint()
          ..color = displayColor.withValues(
            alpha: (isDark ? 0.34 : 0.48) * pulse,
          )
          ..strokeWidth = isDark ? 0.7 : 0.9;
        canvas.drawLine(
          center - Offset(ray, 0),
          center + Offset(ray, 0),
          rayPaint,
        );
        canvas.drawLine(
          center - Offset(0, ray),
          center + Offset(0, ray),
          rayPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TwinklePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}
