import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/lumilu_theme.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/presentation/widgets/lumilu_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    required this.onGetStarted,
    required this.onSignIn,
    super.key,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(
          color: Theme.of(context).brightness == Brightness.dark
              ? LumiluColors.twilight900
              : LumiluColors.neutral200,
        ),
        Image.asset(
          'assets/images/welcome_background.webp',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        const IgnorePointer(child: CustomPaint(painter: _GrainPainter())),
        SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 42,
                    maxWidth: 560,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 290,
                          height: 84,
                          child: Image.asset(
                            'assets/icons/lumilu.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          height: constraints.maxHeight < 700 ? 225 : 305,
                          child: Image.asset(
                            'assets/images/lumi.webp',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Semantics(
                          header: true,
                          child: Text.rich(
                            key: const Key('welcome-headline'),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.welcomeHeadlineStart}\n',
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: _GradientText(
                                    AppLocalizations.of(
                                      context,
                                    )!.welcomeHeadlineMotion,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displaySmall
                                ?.copyWith(
                                  fontSize: 31,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? LumiluColors.neutral0
                                      : LumiluColors.twilight800,
                                  fontWeight: FontWeight.w700,
                                  height: 1.06,
                                  letterSpacing: -1.1,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 390),
                          child: Text(
                            AppLocalizations.of(context)!.welcomeDescription,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? LumiluColors.twilight300
                                      : LumiluColors.neutral600,
                                  height: 1.38,
                                ),
                          ),
                        ),
                        const Spacer(),
                        LumiluButton(
                          key: const Key('welcome-get-started'),
                          label: AppLocalizations.of(context)!.welcomeCta,
                          onPressed: onGetStarted,
                        ),
                        const SizedBox(height: 18),
                        Semantics(
                          button: true,
                          child: GestureDetector(
                            key: const Key('welcome-sign-in'),
                            onTap: onSignIn,
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.welcomeHaveAccount} ',
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.welcomeSignIn,
                                      style: const TextStyle(
                                        color: LumiluColors.mint400,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? LumiluColors.twilight300
                                          : LumiluColors.neutral600,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _GradientText extends StatelessWidget {
  const _GradientText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (bounds) => const LinearGradient(
      colors: [
        LumiluColors.yellow500,
        LumiluColors.mint400,
        LumiluColors.lilac500,
      ],
    ).createShader(bounds),
    child: Text(
      text,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontSize: 31,
        fontWeight: FontWeight.w700,
        height: 1.06,
        letterSpacing: -1.1,
      ),
    ),
  );
}

class _GrainPainter extends CustomPainter {
  const _GrainPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final light = Paint()..color = Colors.white.withValues(alpha: 0.07);
    final dark = Paint()
      ..color = LumiluColors.twilight900.withValues(alpha: 0.045);
    final count = (size.width * size.height / 430).round();

    for (var index = 0; index < count; index++) {
      final point = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final radius = 0.25 + random.nextDouble() * 0.55;
      canvas.drawCircle(point, radius, index.isEven ? light : dark);
    }
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => false;
}
