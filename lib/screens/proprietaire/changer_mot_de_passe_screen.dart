import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangerMotDePasseScreen extends StatelessWidget {
  const ChangerMotDePasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ancienController = TextEditingController();
    final nouveauController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Changer mot de passe", style: GoogleFonts.manrope()),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: ancienController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Ancien mot de passe",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nouveauController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (ancienController.text.isEmpty ||
                    nouveauController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Mot de passe invalide")),
                  );
                  return;
                }

                // 🔁 Appel à ton backend ou base locale
                Navigator.pop(context);
              },
              child: const Text("Valider"),
            ),
          ],
        ),
      ),
    );
  }
}
