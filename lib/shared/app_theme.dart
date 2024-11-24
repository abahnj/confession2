import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._(); // Private constructor to prevent instantiation

  // Colors
  static const Color _iconColorLightInactive = Color.fromRGBO(0, 0, 0, .9);
  static const Color _iconColorActive = Colors.red;
  static const Color _iconColorDarkInactive =
      Color.fromRGBO(255, 255, 255, 0.3);

  // Light Theme
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: _iconColorActive,
    primaryIconTheme: const IconThemeData(
      color: _iconColorActive,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: _iconColorActive,
      unselectedItemColor: _iconColorLightInactive,
    ),
  );

  // Dark Theme
  static final ThemeData dark = ThemeData.dark().copyWith(
    iconTheme: const IconThemeData(
      color: _iconColorActive,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const ColorScheme.dark().primary,
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: _iconColorActive,
      unselectedItemColor: _iconColorDarkInactive,
    ),
  );
}
