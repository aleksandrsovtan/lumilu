import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/di/injection_container.dart';
import 'core/localization/locale_controller.dart';
import 'core/di/modules/exercises_module.dart';
import 'core/theme/theme_controller.dart';
import 'features/achievement/presentation/pages/achievement_screen.dart';
import 'features/auth/presentation/pages/auth_form_screen.dart';
import 'features/auth/presentation/pages/forgot_password_screen.dart';
import 'features/auth/presentation/controllers/auth_session_controller.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'app/presentation/pages/app_shell_screen.dart';
import 'features/move/presentation/pages/move_screen.dart';
import 'features/move/domain/entities/workout_complex.dart';
import 'features/profile/presentation/pages/profile_settings_screen.dart';
import 'features/lumi/presentation/pages/lumi_screen.dart';
import 'features/exercises/infrastructure/motion/lumilu_camera_preview.dart';
import 'features/exercises/presentation/pages/squat_screen.dart';
import 'features/exercises/presentation/pages/workout_preview_screen.dart';
import 'features/exercises/presentation/pages/workout_screen.dart';
import 'features/exercises/presentation/cubit/workout_cubit.dart';
import 'features/today/presentation/pages/today_screen.dart';
import 'features/welcome/presentation/pages/welcome_screen.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/presentation/pages/title_screen.dart';

abstract final class AppRoutes {
  static const welcome = '/';
  static const today = '/today';
  static const move = '/move';
  static const lumi = '/lumi';
  static const home = today;
  static const signIn = '/sign-in';
  static const quickRegistration = '/quick-registration';
  static const forgotPassword = '/forgot-password';
  static const createProfile = '/create-profile';
  static const firstWorkout = '/first-workout';
  static const squat = '/squat';
  static const workoutPreview = '/workout-preview';
  static const workout = '/workout';
  static const achievement = '/achievement';
  static const profileSettings = '/profile/settings';
}

typedef SquatRouteBuilder = Widget Function(BuildContext context);

GoRouter createAppRouter({
  SquatRouteBuilder? squatBuilder,
  ThemeController? themeController,
  LocaleController? localeController,
  AuthSessionController? authSessionController,
}) => GoRouter(
  initialLocation: AppRoutes.welcome,
  refreshListenable: authSessionController,
  redirect: (context, state) {
    if (authSessionController == null) return null;
    final isAuthenticated = authSessionController.isAuthenticated;
    final path = state.uri.path;
    final isAuthRoute =
        path == AppRoutes.welcome ||
        path == AppRoutes.signIn ||
        path == AppRoutes.quickRegistration ||
        path == AppRoutes.forgotPassword;
    if (isAuthenticated && isAuthRoute) return AppRoutes.home;
    if (!isAuthenticated && !isAuthRoute) return AppRoutes.welcome;
    return null;
  },
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
      builder: (context, state) => AuthFormScreen(
        mode: AuthFormMode.signIn,
        onSuccess: () => context.go(AppRoutes.home),
        onSwitchMode: () => context.go(AppRoutes.quickRegistration),
        onForgotPassword: () => context.push(AppRoutes.forgotPassword),
      ),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => ForgotPasswordScreen(
        onSendReset: getIt<AuthRepository>().sendPasswordResetEmail,
        onBackToSignIn: () => context.go(AppRoutes.signIn),
      ),
    ),
    GoRoute(
      path: AppRoutes.quickRegistration,
      builder: (context, state) => AuthFormScreen(
        mode: AuthFormMode.signUp,
        onSuccess: () => context.go(AppRoutes.home),
        onSwitchMode: () => context.go(AppRoutes.signIn),
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppShellScreen(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        onOpenProfile: () => context.push(AppRoutes.profileSettings),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.today,
              builder: (context, state) => TodayScreen(
                onStartWorkout: () => context.push(AppRoutes.squat),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.move,
              builder: (context, state) => MoveScreen(
                onStartWorkout: (WorkoutComplex complex) => context.push(
                  squatBuilder == null
                      ? AppRoutes.workoutPreview
                      : AppRoutes.squat,
                  extra: squatBuilder == null ? complex : null,
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.lumi,
              builder: (context, state) => const LumiScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.squat,
      builder: (context, state) =>
          squatBuilder?.call(context) ?? _buildSquatRoute(context),
    ),
    GoRoute(
      path: AppRoutes.workoutPreview,
      builder: (context, state) {
        final complex = state.extra! as WorkoutComplex;
        return WorkoutPreviewScreen(
          complex: complex,
          onStart: () => context.push(AppRoutes.workout, extra: complex),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.workout,
      builder: (context, state) {
        final complex = state.extra! as WorkoutComplex;
        final dependencies = getIt<ExerciseRouteDependencies>();
        return BlocProvider(
          create: (_) => WorkoutCubit(
            exercises: complex.exercises,
            motion: dependencies.service,
          ),
          child: WorkoutScreen(
            complex: complex,
            cameraPreview: LumiluCameraPreview(detector: dependencies.detector),
            onClose: () => context.go(AppRoutes.move),
            onDone: () => context.go(AppRoutes.home),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.achievement,
      builder: (context, state) => const AchievementScreen(),
    ),
    if (themeController != null && localeController != null)
      GoRoute(
        path: AppRoutes.profileSettings,
        builder: (context, state) => ProfileSettingsScreen(
          themeController: themeController,
          localeController: localeController,
          onLogout: () async {
            await getIt<AuthRepository>().signOut();
            if (context.mounted) context.go(AppRoutes.welcome);
          },
        ),
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
  final dependencies = getIt<ExerciseRouteDependencies>();
  return BlocProvider(
    create: (_) => dependencies.cubit,
    child: SquatScreen(
      cameraPreview: LumiluCameraPreview(detector: dependencies.detector),
      onFinished: () => context.go(AppRoutes.achievement),
    ),
  );
}
