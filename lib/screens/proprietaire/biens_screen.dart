import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MesBiensScreen extends StatelessWidget {
  const MesBiensScreen({super.key});

  // 📋 Liste simulée des biens du propriétaire
  final List<Map<String, dynamic>> biens = const [
    {
      'nom': 'Résidence Cocody Riviera',
      'type': 'Appartement',
      'adresse': 'Cocody Riviera 3, Abidjan',
      'statut': 'Occupé',
      'locataire': 'Koffi Jean',
    },
    {
      'nom': 'Villa Zone 4',
      'type': 'Maison',
      'adresse': 'Rue des Jardins, Zone 4',
      'statut': 'Libre',
      'locataire': null,
    },
    {
      'nom': 'Studio Angré 8e Tranche',
      'type': 'Studio',
      'adresse': 'Angré 8e Tranche, Abidjan',
      'statut': 'Occupé',
      'locataire': 'Traoré Mariam',
    },
  ];

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: biens.length,
        itemBuilder: (context, index) {
          final bien = biens[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏠 Nom du bien
                  Text(
                    bien['nom'],
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 📍 Type et adresse
                  Text(
                    '${bien['type']} • ${bien['adresse']}',
                    style: GoogleFonts.manrope(fontSize: 14),
                  ),

                  const SizedBox(height: 8),

                  // 👤 Locataire (si occupé)
                  if (bien['locataire'] != null)
                    Text(
                      'Locataire : ${bien['locataire']}',
                      style: GoogleFonts.manrope(fontSize: 14),
                    ),

                  const SizedBox(height: 12),

                  // 🔘 Statut + bouton Gérer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatutColor(
                            bien['statut'],
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          bien['statut'],
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getStatutColor(bien['statut']),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // 🔁 Naviguer vers la fiche du bien
                        },
                        icon: const Icon(Icons.settings),
                        label: const Text('Gérer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ➕ Bouton flottant pour ajouter un bien
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // 🔁 Naviguer vers l’écran d’ajout
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter un bien'),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
