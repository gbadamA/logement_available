import 'package:flutter/material.dart';

import 'app_theme.dart';

enum UserRole { locataire, proprietaire }

class ThemeManager extends ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  UserRole _role = UserRole.locataire;

  ThemeData get themeData => _themeData;
  UserRole get role => _role;

  void setRole(UserRole role) {
    _role = role;
    _themeData = _getThemeForRole(role);
    notifyListeners();
  }

  ThemeData _getThemeForRole(UserRole role) {
    switch (role) {
      case UserRole.locataire:
        return AppTheme.lightTheme;
      case UserRole.proprietaire:
        return AppTheme.lightTheme.copyWith(
          scaffoldBackgroundColor: Colors.orange.shade100,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
          ),
        );
    }
  }
}
