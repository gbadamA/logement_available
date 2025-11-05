import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class LangueScreen extends StatelessWidget {
  const LangueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langues = ['Français', 'Anglais', 'Espagnol'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Choisir la langue", style: GoogleFonts.manrope()),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: langues.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(langues[index], style: GoogleFonts.manrope()),
            trailing: const Icon(Icons.language),
            onTap: () {
              onTap:
              () {
                Locale newLocale;
                switch (langues[index]) {
                  case 'Français':
                    newLocale = const Locale('fr');
                    break;
                  case 'Anglais':
                    newLocale = const Locale('en');
                    break;
                  case 'Espagnol':
                    newLocale = const Locale('es');
                    break;
                  default:
                    newLocale = const Locale('fr');
                }

                MyApp.setLocale(context, newLocale); // méthode statique à créer
                Navigator.pop(context);
              };
              // 🔁 Appliquer la langue
            },
          );
        },
      ),
    );
  }
}
