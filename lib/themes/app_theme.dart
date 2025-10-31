import 'package:flutter/material.dart';
import 'package:gestionbien/themes/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.orange.shade50,
    primaryColor: Colors.orange,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    textTheme: AppTextTheme.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.orange.shade700,
    primaryColor: Colors.orange,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    textTheme: AppTextTheme.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
