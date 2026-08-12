import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/localization/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('uses device locale by default', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    expect(LocaleController(preferences).locale, isNull);
  });

  test('persists and clears selected locale', () async {
    SharedPreferences.setMockInitialValues({'app_locale': 'uk'});
    final preferences = await SharedPreferences.getInstance();
    final controller = LocaleController(preferences);
    expect(controller.locale, const Locale('uk'));

    await controller.setLocale(const Locale('en'));
    expect(controller.locale, const Locale('en'));
    expect(preferences.getString('app_locale'), 'en');

    await controller.setLocale(null);
    expect(controller.locale, isNull);
    expect(preferences.containsKey('app_locale'), isFalse);
  });
}
