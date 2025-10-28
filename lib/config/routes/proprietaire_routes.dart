import 'package:flutter/material.dart';
import '../../main.dart';
import '../../screens/proprietaire/biens_screen.dart';
import '../../screens/proprietaire/documents_screen.dart';
import '../../screens/proprietaire/messagerie_proprietaire_screen.dart';
import '../../screens/proprietaire/paiement_proprietaire_screen.dart';
import '../../screens/proprietaire/settings_screen.dart';
import '../../screens/proprietaire/signalements_proprietaire_screen.dart';
import '../../screens/proprietaire/statistiques_screen.dart';

class ProprietaireRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/home_proprietaire': (context) => HomePage(),
    '/biens': (context) => MesBiensScreen(),
    '/statistiques': (context) => StatistiquesScreen(),
    '/documents': (context) => DocumentsScreen(),
    '/messages': (context) => MessagerieProprietaireScreen(),
    '/paiements': (context) => PaiementProprietaireScreen(),
    '/settings': (context) => SettingsProprietaireScreen(),
    '/signalement': (context) => SignalementsProprietaireScreen(),
  };
}
