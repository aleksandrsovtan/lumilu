import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/injection_container.dart';
import 'core/di/modules/squat_module.dart';
import 'core/theme/theme_controller.dart';
import 'features/achievement/presentation/pages/achievement_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/profile/presentation/pages/profile_settings_screen.dart';
import 'features/squat/infrastructure/motion/lumilu_camera_preview.dart';
import 'features/squat/presentation/pages/squat_screen.dart';
import 'features/welcome/presentation/pages/welcome_screen.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/presentation/pages/title_screen.dart';

abstract final class AppRoutes {
  static const welcome = '/';
  static const home = '/home';
  static const signIn = '/sign-in';
  static const quickRegistration = '/quick-registration';
  static const createProfile = '/create-profile';
  static const firstWorkout = '/first-workout';
  static const squat = '/squat';
  static const achievement = '/achievement';
  static const profileSettings = '/profile/settings';
}

typedef SquatRouteBuilder = Widget Function(BuildContext context);

GoRouter createAppRouter({
  SquatRouteBuilder? squatBuilder,
  ThemeController? themeController,
}) => GoRouter(
  initialLocation: AppRoutes.welcome,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => WelcomeScreen(
        onGetStarted: () => context.push(AppRoutes.quickRegistration),
        onSignIn: () => context.push(AppRoutes.signIn),
      ),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      builder: (context, state) =>
          TitleScreen(title: AppLocalizations.of(context)!.signInTitle),
    ),
    GoRoute(
      path: AppRoutes.quickRegistration,
      builder: (context, state) => TitleScreen(
        title: AppLocalizations.of(context)!.quickRegistrationTitle,
      ),
    ),
    GoRoute(
      path: AppRoutes.createProfile,
      builder: (context, state) =>
          TitleScreen(title: AppLocalizations.of(context)!.createProfileTitle),
    ),
    GoRoute(
      path: AppRoutes.firstWorkout,
      builder: (context, state) =>
          TitleScreen(title: AppLocalizations.of(context)!.firstWorkoutTitle),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => HomeScreen(
        onStartSquats: () => context.push(AppRoutes.squat),
        onOpenProfile: () => context.push(AppRoutes.profileSettings),
      ),
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
    if (themeController != null)
      GoRoute(
        path: AppRoutes.profileSettings,
        builder: (context, state) =>
            ProfileSettingsScreen(themeController: themeController),
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
