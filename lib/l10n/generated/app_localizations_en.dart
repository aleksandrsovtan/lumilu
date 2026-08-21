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
  String get todayTab => 'Today';

  @override
  String get moveTab => 'Move';

  @override
  String get rewardsTab => 'Lumi';

  @override
  String get startWorkout => 'Start exercises';

  @override
  String get movePlaceholderTitle => 'Choose your next move';

  @override
  String get movePlaceholderDescription =>
      'Workouts and playful movement activities will live here.';

  @override
  String get moveTitle => 'Choose your pace';

  @override
  String get moveDescription =>
      'Pick one of three ready-made workouts or build one just for you.';

  @override
  String get easyStartTitle => 'Easy start';

  @override
  String get easyStartDescription => 'Warm up gently and wake up';

  @override
  String get easyStartMeta => '~ 5 min · 3 exercises';

  @override
  String get inRhythmTitle => 'In rhythm';

  @override
  String get inRhythmDescription => 'An active pace and energy boost';

  @override
  String get inRhythmMeta => '~ 10 min · 3 exercises';

  @override
  String get fullPowerTitle => 'Full power';

  @override
  String get fullPowerDescription => 'A real challenge for your whole body';

  @override
  String get fullPowerMeta => '~ 15 min · 3 exercises';

  @override
  String get exerciseHeadForwardTitle => 'Head tilt forward';

  @override
  String get exerciseHeadForwardDescription =>
      'Gently bring your chin toward your chest, then return to neutral.';

  @override
  String get exerciseHeadBackTitle => 'Head tilt back';

  @override
  String get exerciseHeadBackDescription =>
      'Gently look upward, then return to neutral.';

  @override
  String get exerciseHeadNodTitle => 'Head forward — back';

  @override
  String get exerciseHeadNodDescription =>
      'Tilt your head forward, then back. The repetition counts in the back position.';

  @override
  String get exerciseHeadTurnTitle => 'Head tilts right — left';

  @override
  String get exerciseHeadTurnDescription =>
      'Tilt your ear toward the right shoulder, then the left. Keep your face forward and your torso upright.';

  @override
  String get workoutGetReadyTitle => 'Let\'s get ready!';

  @override
  String get workoutCameraSetupDescription =>
      'Place your phone where Lumi can see your whole body.';

  @override
  String get workoutFullBodyVisible => 'Full body visible';

  @override
  String get workoutDistance => 'About 2–3 m away';

  @override
  String get workoutGoodLighting => 'Good lighting';

  @override
  String get workoutPrivacy => 'Video is not recorded or saved.';

  @override
  String get workoutOpenCamera => 'Open camera';

  @override
  String get workoutBodyVisible => 'Great! Lumi can see you ✨';

  @override
  String get workoutAlmostInFrame => 'Almost there — step away from the camera';

  @override
  String get workoutStepAwayFromCamera => 'Step away from the camera';

  @override
  String get workoutExitTitle => 'End workout?';

  @override
  String get workoutExitDescription =>
      'If you close the camera now, your progress in this workout will be lost.';

  @override
  String get workoutStayAction => 'Keep going';

  @override
  String get workoutExitAction => 'End workout';

  @override
  String get workoutAmazing => 'Amazing! ✨';

  @override
  String get workoutNext => 'Next';

  @override
  String get workoutSkipRest => 'Skip rest';

  @override
  String get workoutPaused => 'Workout paused';

  @override
  String get workoutRestartExercise => 'Restart exercise';

  @override
  String get workoutKeepGoing => 'Keep going! ✨';

  @override
  String get headTiltForwardHint => 'Lower your chin a little';

  @override
  String get headTurnRightHint => 'Tilt your head toward the right shoulder';

  @override
  String get headTurnLeftHint => 'Now tilt toward the left shoulder';

  @override
  String get headTiltBackHint => 'Look up a little';

  @override
  String get workoutCompleteTitle => 'You did it!';

  @override
  String get workoutMoves => 'moves';

  @override
  String get workoutExercises => 'exercises';

  @override
  String get workoutDone => 'Done';

  @override
  String get customWorkoutTitle => 'Custom workout';

  @override
  String get customWorkoutDescription => 'Build a workout to match your mood';

  @override
  String get createWorkoutTitle => 'New workout';

  @override
  String get createWorkoutDescription =>
      'Give it a name — exercises come in the next step.';

  @override
  String get workoutNameLabel => 'Workout name';

  @override
  String get createWorkoutAction => 'Create workout';

  @override
  String get startNow => 'Start now';

  @override
  String approximateSeconds(int seconds) {
    return '~ $seconds sec';
  }

  @override
  String get exerciseBreathingTitle => 'Calm breathing';

  @override
  String get exerciseBreathingDescription =>
      'Breathe in through your nose, exhale slowly and relax your shoulders.';

  @override
  String get exerciseShoulderCirclesTitle => 'Shoulder circles';

  @override
  String get exerciseShoulderCirclesDescription =>
      'Make broad, smooth shoulder circles forward and backward.';

  @override
  String get exerciseSideBendsTitle => 'Side bends';

  @override
  String get exerciseSideBendsDescription =>
      'Reach one arm overhead without rotating your torso.';

  @override
  String get exerciseEasySquatsTitle => 'Easy squats';

  @override
  String get exerciseEasySquatsDescription =>
      'Push your hips back and keep your knees above your feet.';

  @override
  String get exerciseMarchTitle => 'March in place';

  @override
  String get exerciseMarchDescription =>
      'Lift your knees and move your arms with energy.';

  @override
  String get exerciseJumpingJacksTitle => 'Jumping jacks';

  @override
  String get exerciseJumpingJacksDescription =>
      'Jump while opening your legs and raising your arms.';

  @override
  String get exerciseSquatsTitle => 'Squats';

  @override
  String get exerciseSquatsDescription =>
      'Lower to a comfortable depth while keeping your back straight.';

  @override
  String get exerciseKneeRaisesTitle => 'Knee raises';

  @override
  String get exerciseKneeRaisesDescription =>
      'Alternately drive each knee toward your chest.';

  @override
  String get exerciseLungesTitle => 'Lunges';

  @override
  String get exerciseLungesDescription =>
      'Step forward and gently lower your back knee.';

  @override
  String get exercisePlankTitle => 'Plank';

  @override
  String get exercisePlankDescription =>
      'Keep your body in one line and brace your core.';

  @override
  String get exerciseMountainClimbersTitle => 'Mountain climbers';

  @override
  String get exerciseMountainClimbersDescription =>
      'From plank, alternate driving your knees toward your chest.';

  @override
  String get exercisePushUpsTitle => 'Push-ups';

  @override
  String get exercisePushUpsDescription =>
      'Lower your chest while keeping your body straight.';

  @override
  String get exerciseJumpSquatsTitle => 'Jump squats';

  @override
  String get exerciseJumpSquatsDescription =>
      'Jump out of the squat and land softly.';

  @override
  String get exerciseBurpeesTitle => 'Burpees';

  @override
  String get exerciseBurpeesDescription =>
      'Move to plank, bring your feet back and jump up.';

  @override
  String get exerciseHighKneesTitle => 'High knees';

  @override
  String get exerciseHighKneesDescription =>
      'Run in place and lift your knees to hip height.';

  @override
  String get exerciseBicycleCrunchesTitle => 'Bicycle crunches';

  @override
  String get exerciseBicycleCrunchesDescription =>
      'Bring each elbow toward the opposite knee.';

  @override
  String get rewardsPlaceholderTitle => 'Your rewards';

  @override
  String get rewardsPlaceholderDescription =>
      'Achievements and joyful milestones will appear here.';

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
