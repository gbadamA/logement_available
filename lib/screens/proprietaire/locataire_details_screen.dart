import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocataireDetailsScreen extends StatelessWidget {
  final String nom;
  final String logement;
  final String dateEntree;
  final String dateSortie;
  final String statut;

  const LocataireDetailsScreen({
    super.key,
    required this.nom,
    required this.logement,
    required this.dateEntree,
    required this.dateSortie,
    required this.statut,
  });

  Color _getStatutColor(String statut) {
    return statut == 'Actuel' ? Colors.green : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Détails du locataire",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profil locataire
            _buildCard(
              "Profil",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow("Nom", nom),
                  _buildRow("Logement", logement),
                  _buildRow("Date d’entrée", dateEntree),
                  _buildRow("Date de sortie", dateSortie),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Statut :"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatutColor(statut).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statut,
                          style: GoogleFonts.manrope(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getStatutColor(statut),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📑 Contrats liés
            _buildCard(
              "Contrats liés",
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Colors.indigo,
                    ),
                    title: const Text("Contrat 2022-2023"),
                    subtitle: const Text("Statut : Expiré"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // 👉 Navigation vers détails du contrat
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Colors.indigo,
                    ),
                    title: const Text("Contrat 2024-2025"),
                    subtitle: const Text("Statut : Actif"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // 👉 Navigation vers détails du contrat
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 💰 Paiements
            _buildCard(
              "Historique des paiements",
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.payment, color: Colors.green),
                    title: const Text("Janvier 2024"),
                    subtitle: const Text("Payé le 05 Janvier"),
                    trailing: const Text("150 000 CFA"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.payment, color: Colors.green),
                    title: const Text("Février 2024"),
                    subtitle: const Text("Payé le 03 Février"),
                    trailing: const Text("150 000 CFA"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.warning, color: Colors.redAccent),
                    title: const Text("Mars 2024"),
                    subtitle: const Text("En attente"),
                    trailing: const Text("150 000 CFA"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🚨 Signalements
            _buildCard(
              "Signalements",
              Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.report_problem,
                      color: Colors.orange,
                    ),
                    title: const Text("Fuite d’eau"),
                    subtitle: const Text("Signalé le 12 Février 2024"),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.report_problem,
                      color: Colors.orange,
                    ),
                    title: const Text("Climatisation en panne"),
                    subtitle: const Text("Signalé le 20 Mars 2024"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Carte réutilisable
  Widget _buildCard(String title, Widget child) {
    return Ink(
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
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  // 🔹 Ligne info
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
