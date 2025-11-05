import 'package:flutter/material.dart';
import 'package:gestionbien/config/routes/locataire_routes.dart';
import 'package:gestionbien/config/routes/proprietaire_routes.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/presentation_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/locataire/modifier_profil_locataire_screen.dart';
import '../screens/proprietaire/ajouter_bien screen.dart';
import '../screens/proprietaire/ajouter_entretien_screen.dart';
import '../screens/proprietaire/changer_mot_de_passe_screen.dart';
import '../screens/proprietaire/fiche_bien_screen.dart';
import '../screens/proprietaire/contrat_details_screen.dart';
import '../screens/locataire/chat_locataire_screen.dart';
import '../screens/proprietaire/langue_screen.dart';
import '../screens/proprietaire/modifier_bien_screen.dart';
import '../screens/proprietaire/modifier_profil_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => PresentationScreen(),
    '/signup': (context) => SignupScreen(),
    '/Home_login': (context) => LoginSignupScreen(),
    '/modifier_profil': (context) => ModifierProfilScreen(),
    '/modifier_profil_locataire': (context) => ModifierProfilLocataireScreen(),
    ...LocataireRoutes.routes,
    ...ProprietaireRoutes.routes,
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/fiche-bien':
        final bien = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => FicheBienScreen(bien: bien));

      case '/contrat-details':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ContratDetailsScreen(
            locataire: args['locataire']!,
            logement: args['logement']!,
            dateDebut: args['dateDebut']!,
            dateFin: args['dateFin']!,
            statut: args['statut']!,
          ),
        );

      case '/messages_locataire':
        final destinataire = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChatLocataireScreen(destinataire: destinataire),
        );
      case '/modifier-bien':
        final bien = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ModifierBienScreen(bien: bien),
        );
      case '/ajouter-entretien':
        final bien = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AjouterEntretienScreen(bien: bien),
        );
      case '/ajouter-bien':
        return MaterialPageRoute(builder: (_) => const AjouterBienScreen());
      case '/changer-mdp':
        return MaterialPageRoute(
          builder: (_) => const ChangerMotDePasseScreen(),
        );

      case '/langue':
        return MaterialPageRoute(builder: (_) => const LangueScreen());

      default:
        return null;
    }
  }
}
