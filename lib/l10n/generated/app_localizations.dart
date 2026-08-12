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
  /// **'Rewards'**
  String get rewardsTab;

  /// No description provided for @startWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start Workout'**
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
