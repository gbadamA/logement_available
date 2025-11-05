import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AjouterBienScreen extends StatelessWidget {
  const AjouterBienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nomController = TextEditingController();
    final adresseController = TextEditingController();
    final typeController = TextEditingController();
    String statut = 'Libre';

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un bien", style: GoogleFonts.manrope()),
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
              controller: typeController,
              decoration: const InputDecoration(
                labelText: "Type (Appartement, Studio...)",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: adresseController,
              decoration: const InputDecoration(labelText: "Adresse"),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: statut,
              items: const [
                DropdownMenuItem(value: "Libre", child: Text("Libre")),
                DropdownMenuItem(value: "Occupé", child: Text("Occupé")),
              ],
              onChanged: (val) => statut = val!,
              decoration: const InputDecoration(labelText: "Statut"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // 🔁 Enregistrer le bien (à connecter à ta base ou liste)
              },
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
