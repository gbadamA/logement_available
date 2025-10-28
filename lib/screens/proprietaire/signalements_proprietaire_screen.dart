import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignalementsProprietaireScreen extends StatelessWidget {
  const SignalementsProprietaireScreen({super.key});

  final List<Map<String, dynamic>> signalements = const [
    {
      'type': 'Fuite d’eau',
      'description': 'Fuite sous l’évier de la cuisine.',
      'date': '21 oct. 2025',
      'statut': 'En attente',
      'icone': Icons.water_drop,
    },
    {
      'type': 'Panne électrique',
      'description': 'Plus de lumière dans le salon.',
      'date': '18 oct. 2025',
      'statut': 'Résolu',
      'icone': Icons.electrical_services,
    },
    {
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Signalements reçus', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: signalements.length,
        itemBuilder: (context, index) {
          final sig = signalements[index];
          return _buildSignalementCard(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: Colors.indigo),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(description, style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey.shade700)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(date, style: GoogleFonts.manrope(fontSize: 12, color: Colors.grey.shade500)),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
