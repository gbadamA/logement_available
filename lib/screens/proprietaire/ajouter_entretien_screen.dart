import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AjouterEntretienScreen extends StatelessWidget {
  final Map<String, dynamic> bien;

  const AjouterEntretienScreen({super.key, required this.bien});

  @override
  Widget build(BuildContext context) {
    final titreController = TextEditingController();
    final logement = bien['nom'];
    String statut = 'Prévu';

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un entretien", style: GoogleFonts.manrope()),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: titreController,
              decoration: const InputDecoration(
                labelText: "Titre de l’entretien",
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: statut,
              items: const [
                DropdownMenuItem(value: "Prévu", child: Text("Prévu")),
                DropdownMenuItem(value: "Réalisé", child: Text("Réalisé")),
                DropdownMenuItem(value: "Reporté", child: Text("Reporté")),
              ],
              onChanged: (val) => statut = val!,
              decoration: const InputDecoration(labelText: "Statut"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // 🔁 Enregistrer l’entretien
              },
              child: const Text("Ajouter"),
            ),
          ],
        ),
      ),
    );
  }
}
