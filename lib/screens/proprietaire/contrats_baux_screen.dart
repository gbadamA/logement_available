import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'contrat_details_screen.dart';
import 'nouveau_contrat.dart';

class ContratsBauxScreen extends StatelessWidget {
  const ContratsBauxScreen({super.key});

  final List<Map<String, dynamic>> contrats = const [
    {
      'locataire': 'Jean Kouassi',
      'logement': 'Appartement B2',
      'dateDebut': '01 Janv. 2024',
      'dateFin': '31 Déc. 2024',
      'statut': 'Actif',
    },
    {
      'locataire': 'Aminata Touré',
      'logement': 'Studio A1',
      'dateDebut': '15 Mars 2023',
      'dateFin': '14 Mars 2024',
      'statut': 'Expiré',
    },
    {
      'locataire': 'Moussa Diabaté',
      'logement': 'Appartement C3',
      'dateDebut': '01 Oct. 2025',
      'dateFin': '30 Sept. 2026',
      'statut': 'En attente',
    },
  ];

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Actif':
        return Colors.green;
      case 'En attente':
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text('Contrats & Baux', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: contrats.length,
        itemBuilder: (context, index) {
          final c = contrats[index];
          return _buildContratCard(
            context: context, // 👈 on passe le context ici
            locataire: c['locataire'],
            logement: c['logement'],
            dateDebut: c['dateDebut'],
            dateFin: c['dateFin'],
            statut: c['statut'],
            statutColor: _getStatutColor(c['statut']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NouveauContratScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Nouveau contrat"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildContratCard({
    required BuildContext context, // 👈 paramètre ajouté
    required String locataire,
    required String logement,
    required String dateDebut,
    required String dateFin,
    required String statut,
    required Color statutColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigation vers détails du contrat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ContratDetailsScreen(
                locataire: locataire,
                logement: logement,
                dateDebut: dateDebut,
                dateFin: dateFin,
                statut: statut,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👤 Locataire + logement
                Text(
                  '$locataire - $logement',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),

                // 📅 Dates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Début : $dateDebut',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      'Fin : $dateFin',
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 🟢 Statut + actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statutColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        statut,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statutColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.indigo,
                          ),
                          onPressed: () {
                            // Voir détails via le même Navigator.push
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ContratDetailsScreen(
                                  locataire: locataire,
                                  logement: logement,
                                  dateDebut: dateDebut,
                                  dateFin: dateFin,
                                  statut: statut,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.green),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Renouveler le contrat"),
                                content: const Text(
                                  "Voulez-vous prolonger ce contrat d’un an ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Annuler"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // 👉 logique de mise à jour (ex: Firebase update)
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Contrat renouvelé avec succès ✅",
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Confirmer"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Résilier le contrat"),
                                content: const Text(
                                  "Êtes-vous sûr de vouloir résilier ce contrat ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Non"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // 👉 logique de mise à jour (ex: Firebase update)
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Contrat résilié ❌"),
                                        ),
                                      );
                                    },
                                    child: const Text("Oui, résilier"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
