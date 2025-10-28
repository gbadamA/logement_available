import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/presentation_screen.dart';
import '../screens/locataire/modifier_profil_locataire_screen.dart';
import '../screens/proprietaire/modifier_profil_screen.dart';
import 'routes/locataire_routes.dart';
import 'routes/proprietaire_routes.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => PresentationScreen(),
    '/Home_login': (context) => LoginSignupScreen(),
    '/modifier_profil': (context) => ModifierProfilScreen(),
    '/modifier_profil_locataire': (context) => ModifierProfilLocataireScreen(),
    ...LocataireRoutes.routes,
    ...ProprietaireRoutes.routes,
  };
}
