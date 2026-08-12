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
  String get welcomeHeadlineStart => 'Start every day in';

  @override
  String get welcomeHeadlineMotion => 'motion';

  @override
  String get welcomeDescription =>
      'Fun daily workouts and simple exercises for the whole family.';

  @override
  String get welcomeCta => 'Let’s move';

  @override
  String get welcomeHaveAccount => 'Already have an account?';

  @override
  String get welcomeSignIn => 'Sign in';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInDescription =>
      'Welcome back. Sign in to continue moving with Lumilu.';

  @override
  String get signUpTitle => 'Create your account';

  @override
  String get signUpDescription =>
      'A few details and your family’s movement journey can begin.';

  @override
  String get nameLabel => 'Your name';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameValidation => 'Enter at least 2 characters.';

  @override
  String get emailValidation => 'Enter a valid email address.';

  @override
  String get passwordRequired => 'Enter your password.';

  @override
  String get passwordValidation =>
      'Use at least 8 characters, one uppercase Latin letter and one number. Latin characters only.';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signInAction => 'Sign in';

  @override
  String get forgotPasswordAction => 'Forgot password?';

  @override
  String get forgotPasswordTitle => 'Reset your password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email and we’ll send you a secure link to choose a new password.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get passwordResetSentTitle => 'Check your inbox';

  @override
  String passwordResetSentDescription(String email) {
    return 'We sent a password reset link to $email.';
  }

  @override
  String get passwordResetUserNotFound =>
      'No account was found for this email.';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get noAccountPrompt => 'New to Lumilu?';

  @override
  String get authInvalidEmail => 'This email address is invalid.';

  @override
  String get authInvalidCredentials => 'The email or password is incorrect.';

  @override
  String get authEmailInUse => 'An account with this email already exists.';

  @override
  String get authWeakPassword =>
      'Use at least 8 characters, one uppercase Latin letter and one number.';

  @override
  String get authUserDisabled => 'This account has been disabled.';

  @override
  String get authNetworkError =>
      'Check your internet connection and try again.';

  @override
  String get authTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get authDatabaseError =>
      'The profile could not be saved. Please try again.';

  @override
  String get quickRegistrationTitle => 'Quick registration';

  @override
  String get createProfileTitle => 'Create profile';

  @override
  String get firstWorkoutTitle => 'First workout';

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
  String get appearanceDescription => 'Choose how Lumilu looks on this device.';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSystemDescription => 'Match your device settings';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageDescription =>
      'Choose the language used throughout the app.';

  @override
  String get languageSystem => 'Device language';

  @override
  String get languageSystemDescription => 'Follow your device settings';

  @override
  String get logoutAction => 'Log out';

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
