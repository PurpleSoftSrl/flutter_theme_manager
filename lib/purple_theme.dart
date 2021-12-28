library purple_theme;

import 'package:flutter/material.dart';

class PurpleThemeHandler {
  void init({
    required ThemeData defaultTheme,
    required Map<String, ThemeData> allThemes,
  }) {
    _currentTheme = defaultTheme;
    _themes.addAll(allThemes);
  }

  static final Map<String, ThemeData> _themes = {};

  static ThemeData? _currentTheme;
  static ThemeData get currentTheme {
    assert(_currentTheme != null, 'Current theme is null, call init() to initialize it');
    return _currentTheme!;
  }

  static ThemeData? switchTheme(String theme) {
    final defaultTheme = _themes.entries.first.value;
    _currentTheme = _themes[theme] ?? defaultTheme;
    return _themes[theme];
  }
}

class PurpleTheme extends StatefulWidget {
  const PurpleTheme({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  static _PurpleThemeState of(BuildContext context) {
    return context.findAncestorStateOfType<_PurpleThemeState>()!;
  }

  @override
  _PurpleThemeState createState() => _PurpleThemeState();
}

class _PurpleThemeState extends State<PurpleTheme> {
  UniqueKey _key = UniqueKey();

  /// Change the current theme and rebuilds the widget
  void changeTheme(String newTheme) {
    PurpleThemeHandler.switchTheme(newTheme);
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: PurpleThemeHandler.currentTheme,
      key: _key,
      child: widget.child,
    );
  }
}
