import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PaiementProprietaireScreen extends StatefulWidget {
  const PaiementProprietaireScreen({super.key});

  @override
  State<PaiementProprietaireScreen> createState() => _PaiementProprietaireScreenState();
}

class _PaiementProprietaireScreenState extends State<PaiementProprietaireScreen> {
  List<Map<String, dynamic>> paiements = [
    {
      'locataire': 'Koffi Jean',
      'montant': '250 000 FCFA',
      'date': '05 oct. 2025',
      'statut': 'Reçu',
      'moyen': 'Virement bancaire',
      'icone': Icons.payment,
      'recuUrl': 'https://example.com/recu_octobre_2025.pdf',
      'valide': false,
    },
    {
      'locataire': 'Traoré Mariam',
      'montant': '180 000 FCFA',
      'date': '03 sept. 2025',
      'statut': 'Reçu',
      'moyen': 'Mobile Money',
      'icone': Icons.payment,
      'recuUrl': 'https://example.com/recu_septembre_2025.pdf',
      'valide': true,
    },
    {
      'locataire': 'Ouattara Karim',
      'montant': '250 000 FCFA',
      'date': '05 nov. 2025',
      'statut': 'En attente',
      'moyen': 'Espèces',
      'icone': Icons.hourglass_bottom,
      'recuUrl': null,
      'valide': false,
    },
  ];

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Reçu':
        return Colors.green;
      case 'En attente':
        return Colors.orange;
      case 'Effectué':
        return Colors.blue;
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
        title: Text('Paiements reçus', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: paiements.length,
        itemBuilder: (context, index) {
          final paiement = paiements[index];
          return _buildPaiementCard(
            index: index,
            icon: paiement['icone'],
            locataire: paiement['locataire'],
            montant: paiement['montant'],
            date: paiement['date'],
            moyen: paiement['moyen'],
            statut: paiement['statut'],
            statutColor: _getStatutColor(paiement['statut']),
            recuUrl: paiement['recuUrl'],
            valide: paiement['valide'],
          );
        },
      ),
    );
  }

  Widget _buildPaiementCard({
    required int index,
    required IconData icon,
    required String locataire,
    required String montant,
    required String date,
    required String moyen,
    required String statut,
    required Color statutColor,
    required String? recuUrl,
    required bool valide,
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
              // 🔹 En-tête
              Row(
                children: [
                  Icon(icon, size: 28, color: Colors.indigo),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locataire, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Montant : $montant', style: GoogleFonts.manrope(fontSize: 14)),
                        Text('Date : $date', style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey.shade600)),
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

              // 📎 Voir le reçu
              if (recuUrl != null) ...[
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    launchUrl(Uri.parse(recuUrl));
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Voir le reçu'),
                ),
              ],

              // ✅ Paiement validé
              if (valide && statut == 'Effectué') ...[
                const SizedBox(height: 8),
                Text(
                  '✅ Paiement effectué',
                  style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                ),
              ],

              // ✅ Bouton de validation
              if (!valide && statut == 'Reçu') ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      paiements[index]['valide'] = true;
                      paiements[index]['statut'] = 'Effectué';
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Paiement validé et marqué comme effectué ✅')),
                    );
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Valider le paiement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
