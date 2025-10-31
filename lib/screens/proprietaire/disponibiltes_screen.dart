import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisponibilitesScreen extends StatefulWidget {
  const DisponibilitesScreen({super.key});

  @override
  State<DisponibilitesScreen> createState() => _DisponibilitesScreenState();
}

class DisponibiliteData {
  final String nom;
  final String statut;
  final String localisation;
  final String type;
  final IconData icon;

  DisponibiliteData(
    this.nom,
    this.statut,
    this.localisation,
    this.type,
    this.icon,
  );
}

class _DisponibilitesScreenState extends State<DisponibilitesScreen> {
  String statutFiltre = 'Tous';
  String localisationFiltre = 'Toutes';
  String typeFiltre = 'Tous';

  final List<DisponibiliteData> tousLesLogements = [
    DisponibiliteData(
      'Appartement Riviera',
      'Disponible',
      'Abidjan',
      'Appartement',
      Icons.apartment,
    ),
    DisponibiliteData(
      'Studio Cocody',
      'Occupé',
      'Abidjan',
      'Studio',
      Icons.home,
    ),
    DisponibiliteData(
      'Villa Bingerville',
      'En attente',
      'Bingerville',
      'Villa',
      Icons.house,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logementsDisponibles = tousLesLogements
        .where((l) => l.statut == 'Disponible')
        .toList();

    // 🔍 Filtrage dynamique
    final logementsFiltres = tousLesLogements.where((logement) {
      final matchStatut =
          statutFiltre == 'Tous' || logement.statut == statutFiltre;
      final matchLocalisation =
          localisationFiltre == 'Toutes' ||
          logement.localisation == localisationFiltre;
      final matchType = typeFiltre == 'Tous' || logement.type == typeFiltre;
      return matchStatut && matchLocalisation && matchType;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Disponibilités', style: textTheme.titleLarge),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Filtrer les logements', style: textTheme.headlineMedium),
              const SizedBox(height: 16),

              // 🎛️ Filtres déroulants
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDropdown(
                    'Statut',
                    ['Tous', 'Disponible', 'Occupé', 'En attente'],
                    statutFiltre,
                    (val) {
                      setState(() => statutFiltre = val);
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildDropdown(
                    'Localisation',
                    ['Toutes', 'Abidjan', 'Bingerville'],
                    localisationFiltre,
                    (val) {
                      setState(() => localisationFiltre = val);
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildDropdown(
                    'Type',
                    ['Tous', 'Appartement', 'Studio', 'Villa'],
                    typeFiltre,
                    (val) {
                      setState(() => typeFiltre = val);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 🧩 Cartes filtrées
              ...logementsFiltres
                  .map((item) => _buildDisponibiliteCard(context, item))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  // 🎛️ Widget dropdown réutilisable
  Widget _buildDropdown(
    String label,
    List<String> options,
    String value,
    Function(String) onChanged,
  ) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.manrope(fontSize: 14)),
        const SizedBox(height: 4),
        DropdownButton<String>(
          value: value,
          items: options
              .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (val) => onChanged(val!),
        ),
      ],
    );
  }

  // 🧩 Carte stylée
  Widget _buildDisponibiliteCard(BuildContext context, DisponibiliteData data) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(data.icon, size: 40, color: Colors.indigo),
          const SizedBox(height: 12),
          Text(
            data.nom,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${data.localisation} • ${data.type}',
            style: GoogleFonts.manrope(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(data.statut),
            backgroundColor: data.statut == 'Disponible'
                ? Colors.green.shade100
                : data.statut == 'Occupé'
                ? Colors.red.shade100
                : Colors.amber.shade100,
          ),
        ],
      ),
    );
  }
}
