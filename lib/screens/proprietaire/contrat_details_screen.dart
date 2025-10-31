import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContratDetailsScreen extends StatelessWidget {
  final String locataire;
  final String logement;
  final String dateDebut;
  final String dateFin;
  final String statut;

  const ContratDetailsScreen({
    super.key,
    required this.locataire,
    required this.logement,
    required this.dateDebut,
    required this.dateFin,
    required this.statut,
  });

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
    final statutColor = _getStatutColor(statut);

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          'Détails du contrat',
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
            // 📝 Informations principales
            _buildInfoCard(
              title: 'Informations générales',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Locataire', locataire),
                  _buildInfoRow('Logement', logement),
                  _buildInfoRow('Date début', dateDebut),
                  _buildInfoRow('Date fin', dateFin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Statut :'),
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
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: statutColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📂 Pièces jointes
            _buildInfoCard(
              title: 'Pièces jointes',
              child: Column(
                children: [
                  _buildAttachmentRow(
                    Icons.picture_as_pdf,
                    'Contrat signé.pdf',
                  ),
                  _buildAttachmentRow(Icons.image, 'État des lieux.png'),
                  _buildAttachmentRow(
                    Icons.receipt_long,
                    'Quittance de loyer.pdf',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ✍️ Signature électronique
            _buildInfoCard(
              title: 'Signature électronique',
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: const Center(
                      child: Text('Zone de signature (à implémenter)'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // logique de sauvegarde de signature
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Signer électroniquement'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
  Widget _buildInfoCard({required String title, required Widget child}) {
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

  // 🔹 Ligne d’info
  Widget _buildInfoRow(String label, String value) {
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

  // 🔹 Ligne pièce jointe
  Widget _buildAttachmentRow(IconData icon, String filename) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.indigo),
      title: Text(filename, style: GoogleFonts.manrope(fontSize: 14)),
      trailing: IconButton(
        icon: const Icon(Icons.download, color: Colors.grey),
        onPressed: () {
          // logique de téléchargement
        },
      ),
    );
  }
}
