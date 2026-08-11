// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lumilu';

  @override
  String get homeHeadline => 'Ready to get\nstronger?';

  @override
  String get homeDescription =>
      'Complete 5 squats. The camera recognizes your movements and counts every repetition.';

  @override
  String get startSquats => 'Start squats';

  @override
  String get profileSettingsTitle => 'Profile settings';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSystemDescription => 'Match your device settings';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get squatWorkoutTitle => 'SQUATS · 5 REPS';

  @override
  String kneeAngle(int angle) {
    return 'Knee angle: $angle°';
  }

  @override
  String get cameraUnavailable => 'Camera unavailable';

  @override
  String get pressStart => 'Press start';

  @override
  String get standFullyInFrame => 'Stand fully in the frame';

  @override
  String get standUp => 'Stand up';

  @override
  String get squatDown => 'Squat down';

  @override
  String get standStraight => 'Stand straight';

  @override
  String get achievementTitle => 'Great job!';

  @override
  String get achievementDescription => 'Your first 5 squats are complete.';

  @override
  String routeNotFound(String route) {
    return 'Route not found: $route';
  }

  @override
  String get cameraPermissionFailure => 'Allow the app to access the camera.';

  @override
  String get motionNotSupportedFailure =>
      'Pose recognition is not supported on this device.';

  @override
  String get motionFailure => 'Motion recognition could not be started.';

  @override
  String get unexpectedFailure => 'An unexpected error occurred.';
}
