import 'package:flutter/material.dart';
import 'package:gestionbien/screens/proprietaire/settings_screen.dart';
import 'package:gestionbien/themes/text_theme.dart';
import 'package:lottie/lottie.dart';
import 'config/app_routes.dart';
import 'core/widgets/custom_drawer.dart';
import 'screens/proprietaire/dashboard_screen.dart';
import 'screens/proprietaire/biens_screen.dart';
import 'screens/proprietaire/paiement_proprietaire_screen.dart';
import 'screens/proprietaire/signalements_proprietaire_screen.dart';
import 'screens/proprietaire/messagerie_proprietaire_screen.dart';
import 'screens/proprietaire/documents_screen.dart';
import 'screens/proprietaire/statistiques_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImmoConnect',
      theme: ThemeData(
        textTheme: AppTextTheme.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      darkTheme: ThemeData(
        textTheme: AppTextTheme.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      themeMode: ThemeMode.system, // auto switch
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedPage = 'Tableau de bord';

  Widget _getBody() {
    switch (_selectedPage) {
      case 'Mes biens':
        return MesBiensScreen();
      case 'Paiements':
        return PaiementProprietaireScreen();
      case 'Signalements':
        return SignalementsProprietaireScreen();
      case 'Messagerie':
        return MessagerieProprietaireScreen();
      case 'Documents':
        return DocumentsScreen();
      case 'Statistiques':
        return StatistiquesScreen();
      case 'Paramètres':
        return SettingsProprietaireScreen();
      default:
        return ProprietaireDashboardScreen();
    }
  }

  void _selectPage(String title) {
    setState(() {
      _selectedPage = title;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedPage)),
      drawer: CustomDrawer(
        role: 'Propriétaire', // ou 'Locataire'
        selectedPage: _selectedPage,
        onSelect: (title) {
          setState(() {
            _selectedPage = title;
            Navigator.pop(context);
          });
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(
                    'assets/owner_avatar.json',
                    height: 60,
                  ), // fichier Lottie local
                  SizedBox(height: 10),
                  Text(
                    'Bienvenue Propriétaire',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'contact@immoconnect.ci',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Tableau de bord'),
              onTap: () => _selectPage('Tableau de bord'),
            ),
            ListTile(
              leading: Icon(Icons.home_work),
              title: Text('Mes biens'),
              onTap: () => _selectPage('Mes biens'),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Paiements'),
              onTap: () => _selectPage('Paiements'),
            ),
            ListTile(
              leading: Icon(Icons.report_problem),
              title: Text('Signalements'),
              onTap: () => _selectPage('Signalements'),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Messagerie'),
              onTap: () => _selectPage('Messagerie'),
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text('Documents'),
              onTap: () => _selectPage('Documents'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Statistiques'),
              onTap: () => _selectPage('Statistiques'),
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }
}
