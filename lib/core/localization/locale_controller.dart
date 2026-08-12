import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  LocaleController(this._preferences)
    : _locale = _decode(_preferences.getString(_preferenceKey));

  static const _preferenceKey = 'app_locale';
  final SharedPreferences _preferences;
  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> setLocale(Locale? value) async {
    if (_locale == value) return;
    _locale = value;
    notifyListeners();
    if (value == null) {
      await _preferences.remove(_preferenceKey);
    } else {
      await _preferences.setString(_preferenceKey, value.languageCode);
    }
  }

  static Locale? _decode(String? value) => switch (value) {
    'uk' => const Locale('uk'),
    'en' => const Locale('en'),
    _ => null,
  };
}
