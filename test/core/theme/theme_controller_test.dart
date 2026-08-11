import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumilu/core/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('uses the device theme by default', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final controller = ThemeController(preferences);

    expect(controller.themeMode, ThemeMode.system);
  });

  test('restores and persists the selected theme', () async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
    final preferences = await SharedPreferences.getInstance();
    final controller = ThemeController(preferences);
    expect(controller.themeMode, ThemeMode.dark);

    await controller.setThemeMode(ThemeMode.light);

    expect(controller.themeMode, ThemeMode.light);
    expect(preferences.getString('theme_mode'), 'light');
  });
}
