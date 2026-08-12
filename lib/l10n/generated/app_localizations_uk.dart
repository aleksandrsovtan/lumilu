// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Lumilu';

  @override
  String get welcomeHeadlineStart => 'Починай кожен день у';

  @override
  String get welcomeHeadlineMotion => 'русі';

  @override
  String get welcomeDescription =>
      'Весела зарядка та прості вправи для всієї родини.';

  @override
  String get welcomeCta => 'Почнімо рухатись';

  @override
  String get welcomeHaveAccount => 'Вже маєте акаунт?';

  @override
  String get welcomeSignIn => 'Увійти';

  @override
  String get signInTitle => 'Вхід';

  @override
  String get signInDescription =>
      'Раді бачити знову. Увійдіть, щоб продовжити рухатися з Lumilu.';

  @override
  String get signUpTitle => 'Створіть акаунт';

  @override
  String get signUpDescription =>
      'Кілька деталей — і ваша сімейна подорож у русі почнеться.';

  @override
  String get nameLabel => 'Ваше ім’я';

  @override
  String get emailLabel => 'Електронна пошта';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get nameValidation => 'Введіть щонайменше 2 символи.';

  @override
  String get emailValidation => 'Введіть коректну електронну адресу.';

  @override
  String get passwordRequired => 'Введіть пароль.';

  @override
  String get passwordValidation =>
      'Використайте щонайменше 8 символів, одну велику латинську літеру та одну цифру. Лише латиниця.';

  @override
  String get showPassword => 'Показати пароль';

  @override
  String get hidePassword => 'Сховати пароль';

  @override
  String get signInAction => 'Увійти';

  @override
  String get forgotPasswordAction => 'Забули пароль?';

  @override
  String get forgotPasswordTitle => 'Відновлення пароля';

  @override
  String get forgotPasswordDescription =>
      'Введіть електронну адресу — ми надішлемо безпечне посилання для створення нового пароля.';

  @override
  String get sendResetLink => 'Надіслати посилання';

  @override
  String get passwordResetSentTitle => 'Перевірте пошту';

  @override
  String passwordResetSentDescription(String email) {
    return 'Ми надіслали посилання для відновлення пароля на $email.';
  }

  @override
  String get passwordResetUserNotFound => 'Акаунт із цією адресою не знайдено.';

  @override
  String get backToSignIn => 'Повернутися до входу';

  @override
  String get createAccount => 'Створити акаунт';

  @override
  String get haveAccountPrompt => 'Вже маєте акаунт?';

  @override
  String get noAccountPrompt => 'Вперше в Lumilu?';

  @override
  String get authInvalidEmail => 'Ця електронна адреса некоректна.';

  @override
  String get authInvalidCredentials =>
      'Неправильна електронна адреса або пароль.';

  @override
  String get authEmailInUse => 'Акаунт із цією адресою вже існує.';

  @override
  String get authWeakPassword =>
      'Використайте щонайменше 8 символів, одну велику латинську літеру та одну цифру.';

  @override
  String get authUserDisabled => 'Цей акаунт вимкнено.';

  @override
  String get authNetworkError =>
      'Перевірте з’єднання з інтернетом і спробуйте ще раз.';

  @override
  String get authTooManyRequests => 'Забагато спроб. Спробуйте пізніше.';

  @override
  String get authDatabaseError =>
      'Не вдалося зберегти профіль. Спробуйте ще раз.';

  @override
  String get quickRegistrationTitle => 'Швидка реєстрація';

  @override
  String get createProfileTitle => 'Створення профілю';

  @override
  String get firstWorkoutTitle => 'Перша зарядка';

  @override
  String get homeHeadline => 'Готові стати\nсильнішими?';

  @override
  String get homeDescription =>
      'Виконайте 5 присідань. Камера розпізнає рухи та порахує кожен повтор.';

  @override
  String get startSquats => 'Почати присідання';

  @override
  String get profileSettingsTitle => 'Налаштування профілю';

  @override
  String get appearanceTitle => 'Вигляд';

  @override
  String get appearanceDescription =>
      'Оберіть вигляд Lumilu на цьому пристрої.';

  @override
  String get themeSystem => 'Системна';

  @override
  String get themeSystemDescription => 'Відповідно до налаштувань пристрою';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get languageTitle => 'Мова';

  @override
  String get languageDescription => 'Оберіть мову для всього застосунку.';

  @override
  String get languageSystem => 'Мова пристрою';

  @override
  String get languageSystemDescription => 'Відповідно до налаштувань пристрою';

  @override
  String get logoutAction => 'Вийти з акаунта';

  @override
  String get squatWorkoutTitle => 'ПРИСІДАННЯ · 5 ПОВТОРІВ';

  @override
  String kneeAngle(int angle) {
    return 'Кут коліна: $angle°';
  }

  @override
  String get cameraUnavailable => 'Камера недоступна';

  @override
  String get pressStart => 'Натисніть старт';

  @override
  String get standFullyInFrame => 'Станьте повністю в кадр';

  @override
  String get standUp => 'Випрямляйтесь';

  @override
  String get squatDown => 'Присідайте';

  @override
  String get standStraight => 'Станьте рівно';

  @override
  String get achievementTitle => 'Чудова робота!';

  @override
  String get achievementDescription => 'Перші 5 присідань виконано.';

  @override
  String routeNotFound(String route) {
    return 'Маршрут не знайдено: $route';
  }

  @override
  String get cameraPermissionFailure => 'Надайте застосунку доступ до камери.';

  @override
  String get motionNotSupportedFailure =>
      'Розпізнавання поз не підтримується на цьому пристрої.';

  @override
  String get motionFailure => 'Не вдалося запустити розпізнавання рухів.';

  @override
  String get unexpectedFailure => 'Сталася непередбачена помилка.';
}
