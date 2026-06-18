import 'package:flutter/material.dart';

/// Reactive theme mode — official Flutter `ValueNotifier` pattern.
///
/// Usage:
/// ```dart
/// // Wrap MaterialApp with AnimatedBuilder:
/// AnimatedBuilder(
///   animation: themeModeNotifier,
///   builder: (_, __) => MaterialApp(
///     themeMode: themeModeNotifier.value,
///     theme: lightTheme,
///     darkTheme: darkTheme,
///     ...
///   ),
/// )
///
/// // Toggle from any widget:
/// toggleDarkMode();
///
/// // Read current mode:
/// if (isDarkMode) { ... }
/// ```
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.light);

ThemeData? _lightTheme;
ThemeData? _darkTheme;

void initThemes({required ThemeData light, required ThemeData dark, bool isDark = false}) {
  _lightTheme = light;
  _darkTheme = dark;
  themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
}

ThemeData get lightTheme => _lightTheme!;
ThemeData get darkTheme => _darkTheme!;
bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

void toggleDarkMode() {
  themeModeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
}
