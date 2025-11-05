import 'package:flutter/material.dart';

import '../screens/proprietaire/calendrier_entretien_screen.dart';
import '../screens/proprietaire/charges_depenses_screen.dart';
import '../screens/proprietaire/contrats_baux_screen.dart';
import '../screens/proprietaire/disponibiltes_screen.dart';
import '../screens/proprietaire/documents_screen.dart';
import '../screens/proprietaire/historique_locataires.dart';
import '../screens/proprietaire/notifications_screen.dart';
import '../screens/proprietaire/revenus_locatifs_screen.dart';

Widget resolveRoute(String route) {
  switch (route) {
    case '/disponibilites':
      return const DisponibilitesScreen();
    case '/contrats':
      return const ContratsBauxScreen();
    case '/documents':
      return const DocumentsScreen();
    case '/historique':
      return const HistoriqueLocatairesScreen();
    case '/revenus':
      return const RevenusLocatifsScreen();
    case '/depenses':
      return const ChargesDepensesScreen();
    case '/calendrier':
      return const CalendrierEntretienScreen();
    case '/notifications':
      return const NotificationsScreen();

    case '/proprietaire/partages':
      return const DocumentsScreen();
    default:
      return const Scaffold(body: Center(child: Text('Écran non trouvé')));
  }
}
