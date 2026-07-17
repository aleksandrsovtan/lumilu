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
  String get homeHeadline => 'Готові стати\nсильнішими?';

  @override
  String get homeDescription =>
      'Виконайте 5 присідань. Камера розпізнає рухи та порахує кожен повтор.';

  @override
  String get startSquats => 'Почати присідання';

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
