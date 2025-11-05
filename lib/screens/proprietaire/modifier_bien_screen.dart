import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifierBienScreen extends StatelessWidget {
  final Map<String, dynamic> bien;

  const ModifierBienScreen({super.key, required this.bien});

  @override
  Widget build(BuildContext context) {
    final nomController = TextEditingController(text: bien['nom']);
    final adresseController = TextEditingController(text: bien['adresse']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le bien", style: GoogleFonts.manrope()),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom du bien"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: adresseController,
              decoration: const InputDecoration(labelText: "Adresse"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // 🔁 Enregistrer les modifications
              },
              child: const Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }
}
