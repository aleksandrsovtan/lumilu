import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/injection_container.dart';
import 'core/di/modules/squat_module.dart';
import 'features/achievement/presentation/pages/achievement_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/squat/infrastructure/motion/lumilu_camera_preview.dart';
import 'features/squat/presentation/pages/squat_screen.dart';
import 'l10n/generated/app_localizations.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const squat = '/squat';
  static const achievement = '/achievement';
}

typedef SquatRouteBuilder = Widget Function(BuildContext context);

GoRouter createAppRouter({SquatRouteBuilder? squatBuilder}) => GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) =>
          HomeScreen(onStartSquats: () => context.push(AppRoutes.squat)),
    ),
    GoRoute(
      path: AppRoutes.squat,
      builder: (context, state) =>
          squatBuilder?.call(context) ?? _buildSquatRoute(context),
    ),
    GoRoute(
      path: AppRoutes.achievement,
      builder: (context, state) => const AchievementScreen(),
    ),
  ],
  errorBuilder: (context, state) => Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Text(
        AppLocalizations.of(context)?.routeNotFound('${state.uri}') ??
            'Route not found: ${state.uri}',
      ),
    ),
  ),
);

Widget _buildSquatRoute(BuildContext context) {
  final dependencies = getIt<SquatRouteDependencies>();
  return BlocProvider(
    create: (_) => dependencies.cubit,
    child: SquatScreen(
      cameraPreview: LumiluCameraPreview(detector: dependencies.detector),
      onFinished: () => context.go(AppRoutes.achievement),
    ),
  );
}

final GoRouter appRouter = createAppRouter();
