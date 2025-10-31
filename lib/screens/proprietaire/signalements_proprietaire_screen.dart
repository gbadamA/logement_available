import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignalementsProprietaireScreen extends StatelessWidget {
  const SignalementsProprietaireScreen({super.key});

  final List<Map<String, dynamic>> signalements = const [
    {
      'locataire': 'Jean Kouassi',
      'logement': 'Appartement B2',
      'type': 'Fuite d’eau',
      'description': 'Fuite sous l’évier de la cuisine.',
      'date': '21 oct. 2025',
      'statut': 'En attente',
      'icone': Icons.water_drop,
    },
    {
      'locataire': 'Aminata Touré',
      'logement': 'Studio A1',
      'type': 'Panne électrique',
      'description': 'Plus de lumière dans le salon.',
      'date': '18 oct. 2025',
      'statut': 'Résolu',
      'icone': Icons.electrical_services,
    },
    {
      'locataire': 'Moussa Diabaté',
      'logement': 'Appartement C3',
      'type': 'Nuisance sonore',
      'description': 'Bruits excessifs la nuit.',
      'date': '15 oct. 2025',
      'statut': 'En cours',
      'icone': Icons.volume_up,
    },
  ];

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Résolu':
        return Colors.green;
      case 'En cours':
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
        automaticallyImplyLeading: false,
        title: Text('', style: textTheme.titleLarge),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: signalements.length,
        itemBuilder: (context, index) {
          final sig = signalements[index];
          return _buildSignalementCard(
            locataire: sig['locataire'],
            logement: sig['logement'],
            icon: sig['icone'],
            type: sig['type'],
            description: sig['description'],
            date: sig['date'],
            statut: sig['statut'],
            statutColor: _getStatutColor(sig['statut']),
          );
        },
      ),
    );
  }

  Widget _buildSignalementCard({
    required String locataire,
    required String logement,
    required IconData icon,
    required String type,
    required String description,
    required String date,
    required String statut,
    required Color statutColor,
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
              Text(
                'Locataire : $locataire',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Logement : $logement',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 28, color: Colors.orange),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
