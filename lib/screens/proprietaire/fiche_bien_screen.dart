import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FicheBienScreen extends StatelessWidget {
  final Map<String, dynamic> bien;

  const FicheBienScreen({super.key, required this.bien});

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Occupé':
        return Colors.green;
      case 'Libre':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          bien['nom'],
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📍 Adresse
            Text(bien['adresse'], style: GoogleFonts.manrope(fontSize: 16)),
            const SizedBox(height: 12),

            // 🏷️ Type
            Text(
              "Type : ${bien['type']}",
              style: GoogleFonts.manrope(fontSize: 14),
            ),

            // 👤 Locataire
            if (bien['locataire'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Locataire : ${bien['locataire']}",
                  style: GoogleFonts.manrope(fontSize: 14),
                ),
              ),

            const SizedBox(height: 16),

            // 🔘 Statut
            Row(
              children: [
                const Icon(Icons.info_outline, size: 18),
                const SizedBox(width: 8),
                Text(
                  bien['statut'],
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    color: _getStatutColor(bien['statut']),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 🛠️ Actions
            Text(
              "Actions",
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/modifier-bien', arguments: bien);
              },
              icon: const Icon(Icons.edit),
              label: const Text("Modifier ce bien"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/ajouter-entretien',
                  arguments: bien,
                );
              },
              icon: const Icon(Icons.build),
              label: const Text("Ajouter un entretien"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
