import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MesLocationsScreen extends StatelessWidget {
  const MesLocationsScreen({super.key});

  // 📋 Liste simulée des locations du locataire
  final List<Map<String, dynamic>> locations = const [
    {
      'bien': 'Résidence Cocody Riviera',
      'type': 'Appartement',
      'adresse': 'Cocody Riviera 3, Abidjan',
      'statut': 'Actif',
      'dateDebut': '01 janv. 2025',
      'dateFin': '31 déc. 2025',
      'contratUrl': 'https://example.com/contrat_riviera.pdf',
    },
    {
      'bien': 'Studio Angré 8e Tranche',
      'type': 'Studio',
      'adresse': 'Angré 8e Tranche, Abidjan',
      'statut': 'Expiré',
      'dateDebut': '01 janv. 2024',
      'dateFin': '31 déc. 2024',
      'contratUrl': 'https://example.com/contrat_angre.pdf',
    },
  ];

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Actif':
        return Colors.green;
      case 'Expiré':
        return Colors.red;
      case 'En attente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes locations',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final loc = locations[index];
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
                    loc['bien'],
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 📍 Type et adresse
                  Text(
                    '${loc['type']} • ${loc['adresse']}',
                    style: GoogleFonts.manrope(fontSize: 14),
                  ),

                  const SizedBox(height: 8),

                  // 📅 Dates
                  Text(
                    'Du ${loc['dateDebut']} au ${loc['dateFin']}',
                    style: GoogleFonts.manrope(fontSize: 14),
                  ),

                  const SizedBox(height: 12),

                  // 🔘 Statut + bouton contrat
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
                            loc['statut'],
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          loc['statut'],
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getStatutColor(loc['statut']),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse(loc['contratUrl']));
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Contrat'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 📤 Action
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // 🔁 Naviguer vers demande (résiliation, renouvellement…)
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Faire une demande'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        textStyle: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
