import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestionbien/config/app_routes.dart';
import 'package:gestionbien/themes/app_theme.dart';
import 'package:gestionbien/screens/proprietaire/settings_screen.dart';
import 'package:gestionbien/screens/proprietaire/dashboard_screen.dart';
import 'package:gestionbien/screens/proprietaire/biens_screen.dart';
import 'package:gestionbien/screens/proprietaire/paiement_proprietaire_screen.dart';
import 'package:gestionbien/screens/proprietaire/signalements_proprietaire_screen.dart';
import 'package:gestionbien/screens/proprietaire/messagerie_proprietaire_screen.dart';
import 'package:gestionbien/screens/proprietaire/documents_screen.dart';
import 'package:gestionbien/screens/proprietaire/statistiques_screen.dart';
import 'package:gestionbien/core/widgets/custom_drawer.dart';
import 'package:lottie/lottie.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('fr');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Immobilière',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      locale: _locale,
      supportedLocales: const [Locale('fr'), Locale('en'), Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: '/home_proprietaire',
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedPage = 'Tableau de bord';

  Widget _getBody() {
    switch (_selectedPage) {
      case 'Mes biens':
        return const MesBiensScreen();
      case 'Paiements':
        return const PaiementProprietaireScreen();
      case 'Signalements':
        return const SignalementsProprietaireScreen();
      case 'Messagerie':
        return const MessagerieProprietaireScreen();
      case 'Documents':
        return const DocumentsScreen();
      case 'Statistiques':
        return const StatistiquesScreen();
      case 'Paramètres':
        return const SettingsProprietaireScreen();
      default:
        return const ProprietaireDashboardScreen();
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
        role: 'Propriétaire',
        selectedPage: _selectedPage,
        onSelect: _selectPage,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset('assets/owner_avatar.json', height: 60),
                  const SizedBox(height: 10),
                  const Text(
                    'Bienvenue Propriétaire',
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                  const Text(
                    'contact@immoconnect.ci',
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Tableau de bord'),
              onTap: () => _selectPage('Tableau de bord'),
            ),
            ListTile(
              leading: const Icon(Icons.home_work),
              title: const Text('Mes biens'),
              onTap: () => _selectPage('Mes biens'),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Paiements'),
              onTap: () => _selectPage('Paiements'),
            ),
            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('Signalements'),
              onTap: () => _selectPage('Signalements'),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Messagerie'),
              onTap: () => _selectPage('Messagerie'),
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Documents'),
              onTap: () => _selectPage('Documents'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Statistiques'),
              onTap: () => _selectPage('Statistiques'),
            ),
          ],
        ),
      ),
      body: _getBody(),
    );
  }
}
