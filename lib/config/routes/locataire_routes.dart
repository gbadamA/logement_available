import 'package:flutter/material.dart';

import '../../screens/locataire/dashboard_screen.dart';
import '../../screens/locataire/demande_location_screen.dart';
import '../../screens/locataire/eposer_signalement_locataire_screen.dart';
import '../../screens/locataire/chat_locataire_screen.dart';
import '../../screens/locataire/paiement_locataire_screen.dart';
import '../../screens/locataire/profil_locataire_screen.dart';
import '../../screens/locataire/settings_locataire_screen.dart';

class LocataireRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/home_locataire': (context) => LocataireDashboardScreen(),
    '/demande_location': (context) => const DemandeLocationScreen(),
    '/paiement_loyer_locataire': (context) => PaiementLocataireScreen(),
    '/maintenance': (context) => DeposerSignalementLocataireScreen(),
    '/messages_locataire': (context) => ChatLocataireScreen(destinataire: ''),
    '/profil_locataire': (context) => ProfilLocataireScreen(),
    '/settings_locataire': (context) => SettingsLocataireScreen(),
  };
}
