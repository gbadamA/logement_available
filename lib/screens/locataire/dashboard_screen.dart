import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/widgets/LocataireDrawer.dart';

class LocataireDashboardScreen extends StatefulWidget {
  @override
  _LocataireDashboardScreenState createState() => _LocataireDashboardScreenState();
}

class _LocataireDashboardScreenState extends State<LocataireDashboardScreen> {
  String _selectedPage = 'Mes locations';

  // 📋 Liste simulée des locations
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

  Widget _buildMesLocations() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final loc = locations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc['bien'], style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${loc['type']} • ${loc['adresse']}', style: GoogleFonts.manrope(fontSize: 14)),
                const SizedBox(height: 8),
                Text('Du ${loc['dateDebut']} au ${loc['dateFin']}', style: GoogleFonts.manrope(fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatutColor(loc['statut']).withOpacity(0.1),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/demande_location');
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Faire une demande'),
                  ),

                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    switch (_selectedPage) {
      case 'Mes locations':
        return _buildMesLocations();
      default:
        return Center(child: Text(_selectedPage, style: GoogleFonts.manrope(fontSize: 16)));
    }
  }

  void _handleDrawerSelection(String title) {
    Navigator.pop(context);
    if (title == 'Mes locations') {
      setState(() => _selectedPage = title);
    } else {
      switch (title) {
        case 'Paiement du loyer':
          Navigator.pushNamed(context, '/paiement_loyer_locataire');
          break;
        case 'Demande de maintenance':
          Navigator.pushNamed(context, '/maintenance');
          break;
        case 'Messages':
          Navigator.pushNamed(context, '/messages_locataire');
          break;
        case 'Faire une demande':
          Navigator.pushNamed(context, '/demande_location');
          break;
        case 'Profil':
          Navigator.pushNamed(context, '/profil_locataire');
          break;
        case 'Paramètres':
          Navigator.pushNamed(context, '/settings_locataire');
          break;
        case 'Faire une demande':
          Navigator.pushNamed(context, '/demande_location');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPage),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      drawer: LocataireDrawer(
        selectedPage: _selectedPage,
        onSelect: _handleDrawerSelection,
      ),
      body: _buildContent(),
    );
  }
}
