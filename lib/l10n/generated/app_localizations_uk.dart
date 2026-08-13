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
  String get todayTab => 'Сьогодні';

  @override
  String get moveTab => 'Рух';

  @override
  String get rewardsTab => 'Нагороди';

  @override
  String get startWorkout => 'Почати тренування';

  @override
  String get movePlaceholderTitle => 'Обери наступний рух';

  @override
  String get movePlaceholderDescription =>
      'Тут з’являться тренування та веселі рухові активності.';

  @override
  String get moveTitle => 'Обери свій темп';

  @override
  String get moveDescription =>
      'Три готові комплекси — або створи той, що пасує саме тобі.';

  @override
  String get easyStartTitle => 'Легкий старт';

  @override
  String get easyStartDescription => 'М’яко розімнись і прокинься';

  @override
  String get easyStartMeta => '~ 5 хв · 4 вправи';

  @override
  String get inRhythmTitle => 'У ритмі';

  @override
  String get inRhythmDescription => 'Активний темп і заряд енергії';

  @override
  String get inRhythmMeta => '~ 10 хв · 7 вправ';

  @override
  String get fullPowerTitle => 'На повну';

  @override
  String get fullPowerDescription => 'Справжній виклик для всього тіла';

  @override
  String get fullPowerMeta => '~ 15 хв · 10 вправ';

  @override
  String get customWorkoutTitle => 'Свій комплекс';

  @override
  String get customWorkoutDescription => 'Збери тренування під свій настрій';

  @override
  String get createWorkoutTitle => 'Новий комплекс';

  @override
  String get createWorkoutDescription =>
      'Дай йому назву — вправи додамо наступним кроком.';

  @override
  String get workoutNameLabel => 'Назва комплексу';

  @override
  String get createWorkoutAction => 'Створити комплекс';

  @override
  String get startNow => 'Почати зараз';

  @override
  String approximateSeconds(int seconds) {
    return '~ $seconds с';
  }

  @override
  String get exerciseBreathingTitle => 'Спокійне дихання';

  @override
  String get exerciseBreathingDescription =>
      'Вдихай носом, повільно видихай і розслаб плечі.';

  @override
  String get exerciseShoulderCirclesTitle => 'Кола плечима';

  @override
  String get exerciseShoulderCirclesDescription =>
      'Роби широкі плавні кола плечима вперед і назад.';

  @override
  String get exerciseSideBendsTitle => 'Нахили в сторони';

  @override
  String get exerciseSideBendsDescription =>
      'Тягнися рукою над головою, не повертаючи корпус.';

  @override
  String get exerciseEasySquatsTitle => 'Легкі присідання';

  @override
  String get exerciseEasySquatsDescription =>
      'Відводь таз назад і тримай коліна над стопами.';

  @override
  String get exerciseMarchTitle => 'Ходьба на місці';

  @override
  String get exerciseMarchDescription =>
      'Підіймай коліна та активно працюй руками.';

  @override
  String get exerciseJumpingJacksTitle => 'Джампінг-джек';

  @override
  String get exerciseJumpingJacksDescription =>
      'Стрибай, одночасно розводячи ноги й руки.';

  @override
  String get exerciseSquatsTitle => 'Присідання';

  @override
  String get exerciseSquatsDescription =>
      'Опускайся до комфортної глибини з рівною спиною.';

  @override
  String get exerciseKneeRaisesTitle => 'Підйоми колін';

  @override
  String get exerciseKneeRaisesDescription =>
      'Почергово підтягуй коліна до грудей у темпі.';

  @override
  String get exerciseLungesTitle => 'Випади';

  @override
  String get exerciseLungesDescription =>
      'Крокуй вперед і м’яко опускай заднє коліно.';

  @override
  String get exercisePlankTitle => 'Планка';

  @override
  String get exercisePlankDescription =>
      'Тримай тіло рівною лінією та напружуй живіт.';

  @override
  String get exerciseMountainClimbersTitle => 'Альпініст';

  @override
  String get exerciseMountainClimbersDescription =>
      'У планці почергово підтягай коліна до грудей.';

  @override
  String get exercisePushUpsTitle => 'Віджимання';

  @override
  String get exercisePushUpsDescription =>
      'Опускай груди, зберігаючи корпус прямим.';

  @override
  String get exerciseJumpSquatsTitle => 'Присідання зі стрибком';

  @override
  String get exerciseJumpSquatsDescription =>
      'Вистрибуй із присідання та м’яко приземляйся.';

  @override
  String get exerciseBurpeesTitle => 'Берпі';

  @override
  String get exerciseBurpeesDescription =>
      'Перейди в планку, поверни ноги й вистрибни вгору.';

  @override
  String get exerciseHighKneesTitle => 'Високі коліна';

  @override
  String get exerciseHighKneesDescription =>
      'Біжи на місці, підіймаючи коліна до рівня таза.';

  @override
  String get exerciseBicycleCrunchesTitle => 'Велосипед';

  @override
  String get exerciseBicycleCrunchesDescription =>
      'Почергово тягни лікоть до протилежного коліна.';

  @override
  String get rewardsPlaceholderTitle => 'Твої нагороди';

  @override
  String get rewardsPlaceholderDescription =>
      'Тут з’являться досягнення та приємні моменти прогресу.';

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
