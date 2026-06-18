import 'package:flutter/material.dart';

/// Single source of truth for theme state — ValueNotifier-driven, no legacy.
class PurpleThemeHandler {
  void init({
    required ThemeData lightTheme,
    required ThemeData darkTheme,
    required Map<String, ThemeData> allThemes,
    bool isDark = false,
  }) {
    _light = lightTheme;
    _dark = darkTheme;
    _isDark = isDark;
    themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _themes.addAll(allThemes);
  }

  static final Map<String, ThemeData> _themes = {};

  static ThemeData? _light;
  static ThemeData? _dark;
  static bool _isDark = false;
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

  static ThemeData get lightTheme => _light!;
  static ThemeData get darkTheme => _dark!;
  static bool get isDark => _isDark;

  /// Toggle dark/light. Persist `Keys.isDarkMode` in the caller.
  static void toggleDarkMode() {
    _isDark = !_isDark;
    themeModeNotifier.value = _isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
