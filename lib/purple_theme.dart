import 'package:flutter/material.dart';

/// Global theme state — no legacy, no backward-compat, one source of truth.
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
    _currentTheme = isDark ? darkTheme : lightTheme;
    _themes.addAll(allThemes);
  }

  static final Map<String, ThemeData> _themes = {};

  static ThemeData? _currentTheme;
  static ThemeData? _light;
  static ThemeData? _dark;
  static bool _isDark = false;

  static ThemeData get currentTheme {
    assert(_currentTheme != null, 'Current theme is null, call init() to initialize it');
    return _currentTheme!;
  }

  static ThemeData get lightTheme => _light!;
  static ThemeData get darkTheme => _dark!;
  static ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;
  static bool get isDark => _isDark;

  static ThemeData? switchTheme(String theme) {
    final defaultTheme = _themes.entries.first.value;
    _currentTheme = _themes[theme] ?? defaultTheme;
    return _themes[theme];
  }

  /// Toggles dark/light.
  static void setDarkMode(bool dark) {
    _isDark = dark;
    _currentTheme = dark ? _dark : _light;
  }
}

class PurpleTheme extends StatefulWidget {
  const PurpleTheme({super.key, required this.child});

  final Widget child;

  static PurpleThemeState of(BuildContext context) =>
      context.findAncestorStateOfType<PurpleThemeState>()!;

  @override
  PurpleThemeState createState() => PurpleThemeState();
}

class PurpleThemeState extends State<PurpleTheme> {
  UniqueKey _key = UniqueKey();

  void changeTheme(String newTheme) {
    PurpleThemeHandler.switchTheme(newTheme);
    _rebuild();
  }

  void toggleDarkMode() {
    PurpleThemeHandler.setDarkMode(!PurpleThemeHandler.isDark);
    _rebuild();
  }

  /// Rebuild the entire widget tree — use after locale or other global state changes.
  void rebuild() => _rebuild();

  void _rebuild() => setState(() => _key = UniqueKey());

  ThemeMode get themeMode => PurpleThemeHandler.themeMode;
  bool get isDark => PurpleThemeHandler.isDark;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: PurpleThemeHandler.currentTheme,
      key: _key,
      child: widget.child,
    );
  }
}
