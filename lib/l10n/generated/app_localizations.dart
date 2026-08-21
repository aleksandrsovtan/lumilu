import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Lumilu'**
  String get appTitle;

  /// No description provided for @welcomeHeadlineStart.
  ///
  /// In en, this message translates to:
  /// **'Start every day in'**
  String get welcomeHeadlineStart;

  /// No description provided for @welcomeHeadlineMotion.
  ///
  /// In en, this message translates to:
  /// **'motion'**
  String get welcomeHeadlineMotion;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Fun daily workouts and simple exercises for the whole family.'**
  String get welcomeDescription;

  /// No description provided for @welcomeCta.
  ///
  /// In en, this message translates to:
  /// **'Let’s move'**
  String get welcomeCta;

  /// No description provided for @welcomeHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get welcomeHaveAccount;

  /// No description provided for @welcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get welcomeSignIn;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @signInDescription.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Sign in to continue moving with Lumilu.'**
  String get signInDescription;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signUpTitle;

  /// No description provided for @signUpDescription.
  ///
  /// In en, this message translates to:
  /// **'A few details and your family’s movement journey can begin.'**
  String get signUpDescription;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @nameValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters.'**
  String get nameValidation;

  /// No description provided for @emailValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get emailValidation;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get passwordRequired;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters, one uppercase Latin letter and one number. Latin characters only.'**
  String get passwordValidation;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @signInAction.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInAction;

  /// No description provided for @forgotPasswordAction.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordAction;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we’ll send you a secure link to choose a new password.'**
  String get forgotPasswordDescription;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @passwordResetSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get passwordResetSentTitle;

  /// No description provided for @passwordResetSentDescription.
  ///
  /// In en, this message translates to:
  /// **'We sent a password reset link to {email}.'**
  String passwordResetSentDescription(String email);

  /// No description provided for @passwordResetUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account was found for this email.'**
  String get passwordResetUserNotFound;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountPrompt;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'New to Lumilu?'**
  String get noAccountPrompt;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'This email address is invalid.'**
  String get authInvalidEmail;

  /// No description provided for @authInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'The email or password is incorrect.'**
  String get authInvalidCredentials;

  /// No description provided for @authEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get authEmailInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters, one uppercase Latin letter and one number.'**
  String get authWeakPassword;

  /// No description provided for @authUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authUserDisabled;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get authNetworkError;

  /// No description provided for @authTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get authTooManyRequests;

  /// No description provided for @authDatabaseError.
  ///
  /// In en, this message translates to:
  /// **'The profile could not be saved. Please try again.'**
  String get authDatabaseError;

  /// No description provided for @quickRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick registration'**
  String get quickRegistrationTitle;

  /// No description provided for @createProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Create profile'**
  String get createProfileTitle;

  /// No description provided for @firstWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'First workout'**
  String get firstWorkoutTitle;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Ready to get\nstronger?'**
  String get homeHeadline;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 squats. The camera recognizes your movements and counts every repetition.'**
  String get homeDescription;

  /// No description provided for @startSquats.
  ///
  /// In en, this message translates to:
  /// **'Start squats'**
  String get startSquats;

  /// No description provided for @todayTab.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTab;

  /// No description provided for @moveTab.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get moveTab;

  /// No description provided for @rewardsTab.
  ///
  /// In en, this message translates to:
  /// **'Lumi'**
  String get rewardsTab;

  /// No description provided for @startWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start exercises'**
  String get startWorkout;

  /// No description provided for @movePlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your next move'**
  String get movePlaceholderTitle;

  /// No description provided for @movePlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'Workouts and playful movement activities will live here.'**
  String get movePlaceholderDescription;

  /// No description provided for @moveTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your pace'**
  String get moveTitle;

  /// No description provided for @moveDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick one of three ready-made workouts or build one just for you.'**
  String get moveDescription;

  /// No description provided for @easyStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Easy start'**
  String get easyStartTitle;

  /// No description provided for @easyStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Warm up gently and wake up'**
  String get easyStartDescription;

  /// No description provided for @easyStartMeta.
  ///
  /// In en, this message translates to:
  /// **'~ 5 min · 3 exercises'**
  String get easyStartMeta;

  /// No description provided for @inRhythmTitle.
  ///
  /// In en, this message translates to:
  /// **'In rhythm'**
  String get inRhythmTitle;

  /// No description provided for @inRhythmDescription.
  ///
  /// In en, this message translates to:
  /// **'An active pace and energy boost'**
  String get inRhythmDescription;

  /// No description provided for @inRhythmMeta.
  ///
  /// In en, this message translates to:
  /// **'~ 10 min · 3 exercises'**
  String get inRhythmMeta;

  /// No description provided for @fullPowerTitle.
  ///
  /// In en, this message translates to:
  /// **'Full power'**
  String get fullPowerTitle;

  /// No description provided for @fullPowerDescription.
  ///
  /// In en, this message translates to:
  /// **'A real challenge for your whole body'**
  String get fullPowerDescription;

  /// No description provided for @fullPowerMeta.
  ///
  /// In en, this message translates to:
  /// **'~ 15 min · 3 exercises'**
  String get fullPowerMeta;

  /// No description provided for @exerciseHeadForwardTitle.
  ///
  /// In en, this message translates to:
  /// **'Head tilt forward'**
  String get exerciseHeadForwardTitle;

  /// No description provided for @exerciseHeadForwardDescription.
  ///
  /// In en, this message translates to:
  /// **'Gently bring your chin toward your chest, then return to neutral.'**
  String get exerciseHeadForwardDescription;

  /// No description provided for @exerciseHeadBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Head tilt back'**
  String get exerciseHeadBackTitle;

  /// No description provided for @exerciseHeadBackDescription.
  ///
  /// In en, this message translates to:
  /// **'Gently look upward, then return to neutral.'**
  String get exerciseHeadBackDescription;

  /// No description provided for @exerciseHeadNodTitle.
  ///
  /// In en, this message translates to:
  /// **'Head forward — back'**
  String get exerciseHeadNodTitle;

  /// No description provided for @exerciseHeadNodDescription.
  ///
  /// In en, this message translates to:
  /// **'Tilt your head forward, then back. The repetition counts in the back position.'**
  String get exerciseHeadNodDescription;

  /// No description provided for @exerciseHeadTurnTitle.
  ///
  /// In en, this message translates to:
  /// **'Head tilts right — left'**
  String get exerciseHeadTurnTitle;

  /// No description provided for @exerciseHeadTurnDescription.
  ///
  /// In en, this message translates to:
  /// **'Tilt your ear toward the right shoulder, then the left. Keep your face forward and your torso upright.'**
  String get exerciseHeadTurnDescription;

  /// No description provided for @workoutGetReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get ready!'**
  String get workoutGetReadyTitle;

  /// No description provided for @workoutCameraSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Place your phone where Lumi can see your whole body.'**
  String get workoutCameraSetupDescription;

  /// No description provided for @workoutFullBodyVisible.
  ///
  /// In en, this message translates to:
  /// **'Full body visible'**
  String get workoutFullBodyVisible;

  /// No description provided for @workoutDistance.
  ///
  /// In en, this message translates to:
  /// **'About 2–3 m away'**
  String get workoutDistance;

  /// No description provided for @workoutGoodLighting.
  ///
  /// In en, this message translates to:
  /// **'Good lighting'**
  String get workoutGoodLighting;

  /// No description provided for @workoutPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Video is not recorded or saved.'**
  String get workoutPrivacy;

  /// No description provided for @workoutOpenCamera.
  ///
  /// In en, this message translates to:
  /// **'Open camera'**
  String get workoutOpenCamera;

  /// No description provided for @workoutBodyVisible.
  ///
  /// In en, this message translates to:
  /// **'Great! Lumi can see you ✨'**
  String get workoutBodyVisible;

  /// No description provided for @workoutAlmostInFrame.
  ///
  /// In en, this message translates to:
  /// **'Almost there — step away from the camera'**
  String get workoutAlmostInFrame;

  /// No description provided for @workoutStepAwayFromCamera.
  ///
  /// In en, this message translates to:
  /// **'Step away from the camera'**
  String get workoutStepAwayFromCamera;

  /// No description provided for @workoutExitTitle.
  ///
  /// In en, this message translates to:
  /// **'End workout?'**
  String get workoutExitTitle;

  /// No description provided for @workoutExitDescription.
  ///
  /// In en, this message translates to:
  /// **'If you close the camera now, your progress in this workout will be lost.'**
  String get workoutExitDescription;

  /// No description provided for @workoutStayAction.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get workoutStayAction;

  /// No description provided for @workoutExitAction.
  ///
  /// In en, this message translates to:
  /// **'End workout'**
  String get workoutExitAction;

  /// No description provided for @workoutAmazing.
  ///
  /// In en, this message translates to:
  /// **'Amazing! ✨'**
  String get workoutAmazing;

  /// No description provided for @workoutNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get workoutNext;

  /// No description provided for @workoutSkipRest.
  ///
  /// In en, this message translates to:
  /// **'Skip rest'**
  String get workoutSkipRest;

  /// No description provided for @workoutPaused.
  ///
  /// In en, this message translates to:
  /// **'Workout paused'**
  String get workoutPaused;

  /// No description provided for @workoutRestartExercise.
  ///
  /// In en, this message translates to:
  /// **'Restart exercise'**
  String get workoutRestartExercise;

  /// No description provided for @workoutKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going! ✨'**
  String get workoutKeepGoing;

  /// No description provided for @headTiltForwardHint.
  ///
  /// In en, this message translates to:
  /// **'Lower your chin a little'**
  String get headTiltForwardHint;

  /// No description provided for @headTurnRightHint.
  ///
  /// In en, this message translates to:
  /// **'Tilt your head toward the right shoulder'**
  String get headTurnRightHint;

  /// No description provided for @headTurnLeftHint.
  ///
  /// In en, this message translates to:
  /// **'Now tilt toward the left shoulder'**
  String get headTurnLeftHint;

  /// No description provided for @headTiltBackHint.
  ///
  /// In en, this message translates to:
  /// **'Look up a little'**
  String get headTiltBackHint;

  /// No description provided for @workoutCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'You did it!'**
  String get workoutCompleteTitle;

  /// No description provided for @workoutMoves.
  ///
  /// In en, this message translates to:
  /// **'moves'**
  String get workoutMoves;

  /// No description provided for @workoutExercises.
  ///
  /// In en, this message translates to:
  /// **'exercises'**
  String get workoutExercises;

  /// No description provided for @workoutDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get workoutDone;

  /// No description provided for @customWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom workout'**
  String get customWorkoutTitle;

  /// No description provided for @customWorkoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Build a workout to match your mood'**
  String get customWorkoutDescription;

  /// No description provided for @createWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'New workout'**
  String get createWorkoutTitle;

  /// No description provided for @createWorkoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Give it a name — exercises come in the next step.'**
  String get createWorkoutDescription;

  /// No description provided for @workoutNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Workout name'**
  String get workoutNameLabel;

  /// No description provided for @createWorkoutAction.
  ///
  /// In en, this message translates to:
  /// **'Create workout'**
  String get createWorkoutAction;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @approximateSeconds.
  ///
  /// In en, this message translates to:
  /// **'~ {seconds} sec'**
  String approximateSeconds(int seconds);

  /// No description provided for @exerciseBreathingTitle.
  ///
  /// In en, this message translates to:
  /// **'Calm breathing'**
  String get exerciseBreathingTitle;

  /// No description provided for @exerciseBreathingDescription.
  ///
  /// In en, this message translates to:
  /// **'Breathe in through your nose, exhale slowly and relax your shoulders.'**
  String get exerciseBreathingDescription;

  /// No description provided for @exerciseShoulderCirclesTitle.
  ///
  /// In en, this message translates to:
  /// **'Shoulder circles'**
  String get exerciseShoulderCirclesTitle;

  /// No description provided for @exerciseShoulderCirclesDescription.
  ///
  /// In en, this message translates to:
  /// **'Make broad, smooth shoulder circles forward and backward.'**
  String get exerciseShoulderCirclesDescription;

  /// No description provided for @exerciseSideBendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Side bends'**
  String get exerciseSideBendsTitle;

  /// No description provided for @exerciseSideBendsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reach one arm overhead without rotating your torso.'**
  String get exerciseSideBendsDescription;

  /// No description provided for @exerciseEasySquatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Easy squats'**
  String get exerciseEasySquatsTitle;

  /// No description provided for @exerciseEasySquatsDescription.
  ///
  /// In en, this message translates to:
  /// **'Push your hips back and keep your knees above your feet.'**
  String get exerciseEasySquatsDescription;

  /// No description provided for @exerciseMarchTitle.
  ///
  /// In en, this message translates to:
  /// **'March in place'**
  String get exerciseMarchTitle;

  /// No description provided for @exerciseMarchDescription.
  ///
  /// In en, this message translates to:
  /// **'Lift your knees and move your arms with energy.'**
  String get exerciseMarchDescription;

  /// No description provided for @exerciseJumpingJacksTitle.
  ///
  /// In en, this message translates to:
  /// **'Jumping jacks'**
  String get exerciseJumpingJacksTitle;

  /// No description provided for @exerciseJumpingJacksDescription.
  ///
  /// In en, this message translates to:
  /// **'Jump while opening your legs and raising your arms.'**
  String get exerciseJumpingJacksDescription;

  /// No description provided for @exerciseSquatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Squats'**
  String get exerciseSquatsTitle;

  /// No description provided for @exerciseSquatsDescription.
  ///
  /// In en, this message translates to:
  /// **'Lower to a comfortable depth while keeping your back straight.'**
  String get exerciseSquatsDescription;

  /// No description provided for @exerciseKneeRaisesTitle.
  ///
  /// In en, this message translates to:
  /// **'Knee raises'**
  String get exerciseKneeRaisesTitle;

  /// No description provided for @exerciseKneeRaisesDescription.
  ///
  /// In en, this message translates to:
  /// **'Alternately drive each knee toward your chest.'**
  String get exerciseKneeRaisesDescription;

  /// No description provided for @exerciseLungesTitle.
  ///
  /// In en, this message translates to:
  /// **'Lunges'**
  String get exerciseLungesTitle;

  /// No description provided for @exerciseLungesDescription.
  ///
  /// In en, this message translates to:
  /// **'Step forward and gently lower your back knee.'**
  String get exerciseLungesDescription;

  /// No description provided for @exercisePlankTitle.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get exercisePlankTitle;

  /// No description provided for @exercisePlankDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep your body in one line and brace your core.'**
  String get exercisePlankDescription;

  /// No description provided for @exerciseMountainClimbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Mountain climbers'**
  String get exerciseMountainClimbersTitle;

  /// No description provided for @exerciseMountainClimbersDescription.
  ///
  /// In en, this message translates to:
  /// **'From plank, alternate driving your knees toward your chest.'**
  String get exerciseMountainClimbersDescription;

  /// No description provided for @exercisePushUpsTitle.
  ///
  /// In en, this message translates to:
  /// **'Push-ups'**
  String get exercisePushUpsTitle;

  /// No description provided for @exercisePushUpsDescription.
  ///
  /// In en, this message translates to:
  /// **'Lower your chest while keeping your body straight.'**
  String get exercisePushUpsDescription;

  /// No description provided for @exerciseJumpSquatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jump squats'**
  String get exerciseJumpSquatsTitle;

  /// No description provided for @exerciseJumpSquatsDescription.
  ///
  /// In en, this message translates to:
  /// **'Jump out of the squat and land softly.'**
  String get exerciseJumpSquatsDescription;

  /// No description provided for @exerciseBurpeesTitle.
  ///
  /// In en, this message translates to:
  /// **'Burpees'**
  String get exerciseBurpeesTitle;

  /// No description provided for @exerciseBurpeesDescription.
  ///
  /// In en, this message translates to:
  /// **'Move to plank, bring your feet back and jump up.'**
  String get exerciseBurpeesDescription;

  /// No description provided for @exerciseHighKneesTitle.
  ///
  /// In en, this message translates to:
  /// **'High knees'**
  String get exerciseHighKneesTitle;

  /// No description provided for @exerciseHighKneesDescription.
  ///
  /// In en, this message translates to:
  /// **'Run in place and lift your knees to hip height.'**
  String get exerciseHighKneesDescription;

  /// No description provided for @exerciseBicycleCrunchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Bicycle crunches'**
  String get exerciseBicycleCrunchesTitle;

  /// No description provided for @exerciseBicycleCrunchesDescription.
  ///
  /// In en, this message translates to:
  /// **'Bring each elbow toward the opposite knee.'**
  String get exerciseBicycleCrunchesDescription;

  /// No description provided for @rewardsPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Your rewards'**
  String get rewardsPlaceholderTitle;

  /// No description provided for @rewardsPlaceholderDescription.
  ///
  /// In en, this message translates to:
  /// **'Achievements and joyful milestones will appear here.'**
  String get rewardsPlaceholderDescription;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get profileSettingsTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how Lumilu looks on this device.'**
  String get appearanceDescription;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Match your device settings'**
  String get themeSystemDescription;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used throughout the app.'**
  String get languageDescription;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get languageSystem;

  /// No description provided for @languageSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow your device settings'**
  String get languageSystemDescription;

  /// No description provided for @logoutAction.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutAction;

  /// No description provided for @squatWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'SQUATS · 5 REPS'**
  String get squatWorkoutTitle;

  /// No description provided for @kneeAngle.
  ///
  /// In en, this message translates to:
  /// **'Knee angle: {angle}°'**
  String kneeAngle(int angle);

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable'**
  String get cameraUnavailable;

  /// No description provided for @pressStart.
  ///
  /// In en, this message translates to:
  /// **'Press start'**
  String get pressStart;

  /// No description provided for @standFullyInFrame.
  ///
  /// In en, this message translates to:
  /// **'Stand fully in the frame'**
  String get standFullyInFrame;

  /// No description provided for @standUp.
  ///
  /// In en, this message translates to:
  /// **'Stand up'**
  String get standUp;

  /// No description provided for @squatDown.
  ///
  /// In en, this message translates to:
  /// **'Squat down'**
  String get squatDown;

  /// No description provided for @standStraight.
  ///
  /// In en, this message translates to:
  /// **'Stand straight'**
  String get standStraight;

  /// No description provided for @achievementTitle.
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get achievementTitle;

  /// No description provided for @achievementDescription.
  ///
  /// In en, this message translates to:
  /// **'Your first 5 squats are complete.'**
  String get achievementDescription;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Route not found: {route}'**
  String routeNotFound(String route);

  /// No description provided for @cameraPermissionFailure.
  ///
  /// In en, this message translates to:
  /// **'Allow the app to access the camera.'**
  String get cameraPermissionFailure;

  /// No description provided for @motionNotSupportedFailure.
  ///
  /// In en, this message translates to:
  /// **'Pose recognition is not supported on this device.'**
  String get motionNotSupportedFailure;

  /// No description provided for @motionFailure.
  ///
  /// In en, this message translates to:
  /// **'Motion recognition could not be started.'**
  String get motionFailure;

  /// No description provided for @unexpectedFailure.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedFailure;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
