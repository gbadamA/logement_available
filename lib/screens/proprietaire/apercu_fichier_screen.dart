import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApercuFichierScreen extends StatelessWidget {
  final String type;
  final String nom;

  const ApercuFichierScreen({super.key, required this.type, required this.nom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(nom, style: GoogleFonts.manrope(color: Colors.white)),
      ),
      body: Center(
        child: type == 'image'
            ? InteractiveViewer(
                child: Image.asset(
                  "assets/$nom", // 👉 à remplacer par ton chemin réel
                  fit: BoxFit.contain,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 80,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Aperçu PDF non implémenté",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        // 👉 Ici tu peux utiliser un package comme `flutter_pdfview`
                      },
                      icon: const Icon(Icons.open_in_new),
                      label: const Text("Ouvrir avec lecteur PDF"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
