import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeProvider() {
    _getDarkThemeProfile();
  }

  Future<void> _getDarkThemeProfile() async {
    final SharedPreferences prefs = await _prefs;
    isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    isDark = value;
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }
}
