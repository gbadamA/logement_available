import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'effectuer_paiement_locataire_screen.dart';

class PaiementLocataireScreen extends StatelessWidget {
  const PaiementLocataireScreen({super.key});

  // 📋 Liste des paiements du locataire
  final List<Map<String, dynamic>> paiements = const [
    {
      'montant': '250 000 FCFA',
      'date': '05 oct. 2025',
      'statut': 'Validé',
      'moyen': 'Mobile Money',
      'icone': Icons.check_circle,
      'recuFinalUrl': 'https://example.com/recu_final_octobre_2025.pdf',
    },
    {
      'montant': '250 000 FCFA',
      'date': '05 sept. 2025',
      'statut': 'Validé',
      'moyen': 'Virement bancaire',
      'icone': Icons.check_circle,
      'recuFinalUrl': 'https://example.com/recu_final_septembre_2025.pdf',
    },
    {
      'montant': '250 000 FCFA',
      'date': '05 nov. 2025',
      'statut': 'En attente',
      'moyen': 'Mobile Money',
      'icone': Icons.hourglass_bottom,
      'recuFinalUrl': null,
    },
  ];

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Validé':
        return Colors.green;
      case 'En attente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Mes paiements', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: Column(
        children: [
          // 🔘 Bouton pour effectuer un nouveau paiement
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EffectuerPaiementLocataireScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Effectuer un paiement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 📋 Liste des paiements
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: paiements.length,
              itemBuilder: (context, index) {
                final paiement = paiements[index];
                return _buildPaiementCard(
                  icon: paiement['icone'],
                  montant: paiement['montant'],
                  date: paiement['date'],
                  moyen: paiement['moyen'],
                  statut: paiement['statut'],
                  statutColor: _getStatutColor(paiement['statut']),
                  recuFinalUrl: paiement['recuFinalUrl'],
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🧾 Carte individuelle de paiement
  Widget _buildPaiementCard({
    required IconData icon,
    required String montant,
    required String date,
    required String moyen,
    required String statut,
    required Color statutColor,
    required String? recuFinalUrl,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
              // 🔹 En-tête avec icône et statut
              Row(
                children: [
                  Icon(icon, size: 28, color: statutColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Montant : $montant', style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Date : $date', style: GoogleFonts.manrope(fontSize: 14)),
                        Text('Moyen : $moyen', style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statutColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statut,
                      style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: statutColor),
                    ),
                  ),
                ],
              ),

              // 📎 Bouton pour télécharger le reçu final si disponible
              if (recuFinalUrl != null && statut == 'Validé') ...[
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    launchUrl(Uri.parse(recuFinalUrl));
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Télécharger le reçu final'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
