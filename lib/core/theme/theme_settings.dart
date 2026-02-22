import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class ThemeSettings {
  ThemeSettings._();

  static const _themeKey = 'settings.ui_theme';
  static final ValueNotifier<UiThemePreset> _currentTheme =
      ValueNotifier<UiThemePreset>(UiThemePreset.warmInk);
  static bool _initialized = false;

  static ValueListenable<UiThemePreset> get listenable => _currentTheme;
  static UiThemePreset get current => _currentTheme.value;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final themeId = prefs.getString(_themeKey);
    final preset = themeId == null
        ? UiThemePreset.warmInk
        : (uiThemePresetFromId(themeId) ?? UiThemePreset.warmInk);
    AppColors.apply(uiThemeSpecs[preset]!);
    _currentTheme.value = preset;
    _initialized = true;
  }

  static Future<void> setTheme(UiThemePreset preset) async {
    AppColors.apply(uiThemeSpecs[preset]!);
    if (_currentTheme.value != preset) {
      _currentTheme.value = preset;
    }
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, uiThemeSpecs[preset]!.id);
  }
}
