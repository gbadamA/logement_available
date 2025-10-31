import 'package:flutter/material.dart';
import '../../main.dart';
import '../../screens/proprietaire/biens_screen.dart';
import '../../screens/proprietaire/contrat_details_screen.dart';
import '../../screens/proprietaire/contrats_baux_screen.dart';
import '../../screens/proprietaire/disponibiltes_screen.dart';
import '../../screens/proprietaire/documents_screen.dart';
import '../../screens/proprietaire/historique_locataires.dart';
import '../../screens/proprietaire/messagerie_proprietaire_screen.dart';
import '../../screens/proprietaire/paiement_proprietaire_screen.dart';
import '../../screens/proprietaire/photos_documents_screen.dart';
import '../../screens/proprietaire/revenus_locatifs_screen.dart';
import '../../screens/proprietaire/settings_screen.dart';
import '../../screens/proprietaire/signalements_proprietaire_screen.dart';
import '../../screens/proprietaire/statistiques_screen.dart';

class ProprietaireRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/home_proprietaire': (context) => HomePage(),
    '/biens': (context) => MesBiensScreen(),
    '/contrats': (context) => ContratsBauxScreen(),
    '/historique': (context) => HistoriqueLocatairesScreen(),
    '/disponibilites': (context) => DisponibilitesScreen(),
    '/statistiques': (context) => StatistiquesScreen(),
    '/documents': (context) => DocumentsScreen(),
    '/messages': (context) => MessagerieProprietaireScreen(),
    '/paiements': (context) => PaiementProprietaireScreen(),
    '/settings': (context) => SettingsProprietaireScreen(),
    '/documents': (context) => PhotosDocumentsScreen(),
    '/signalement': (context) => SignalementsProprietaireScreen(),
    '/revenus': (context) => RevenusLocatifsScreen(),
    '/contrat-details': (context) => ContratDetailsScreen(
      locataire: 'Jean Kouassi',
      logement: 'Appartement B2',
      dateDebut: '01 Janv. 2024',
      dateFin: '31 Déc. 2024',
      statut: 'Actif',
    ),
  };
}
