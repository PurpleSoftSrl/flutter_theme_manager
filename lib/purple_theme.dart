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
    _themes.addAll(allThemes);
    _setDarkMode(isDark);
  }

  static final Map<String, ThemeData> _themes = {};

  static ThemeData? _light;
  static ThemeData? _dark;
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  static ThemeData get lightTheme => _light!;
  static ThemeData get darkTheme => _dark!;
  static ThemeMode get themeMode => themeModeNotifier.value;
  static bool get isDark => themeModeNotifier.value == ThemeMode.dark;

  static void toggleDarkMode() => _setDarkMode(themeModeNotifier.value != ThemeMode.dark);

  static void _setDarkMode(bool dark) {
    themeModeNotifier.value = dark ? ThemeMode.dark : ThemeMode.light;
  }
}
