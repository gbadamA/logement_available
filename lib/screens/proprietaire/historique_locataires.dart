import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_animations.dart';
import 'locataire_details_screen.dart';

class HistoriqueLocatairesScreen extends StatelessWidget {
  const HistoriqueLocatairesScreen({super.key});

  final List<Map<String, dynamic>> historique = const [
    {
      'nom': 'Jean Kouassi',
      'logement': 'Appartement B2',
      'dateEntree': '01 Janv. 2022',
      'dateSortie': '31 Déc. 2023',
      'statut': 'Ancien',
    },
    {
      'nom': 'Aminata Touré',
      'logement': 'Studio A1',
      'dateEntree': '15 Mars 2023',
      'dateSortie': '14 Mars 2024',
      'statut': 'Ancien',
    },
    {
      'nom': 'Moussa Diabaté',
      'logement': 'Appartement C3',
      'dateEntree': '01 Oct. 2024',
      'dateSortie': 'En cours',
      'statut': 'Actuel',
    },
  ];

  Color _getStatutColor(String statut) {
    return statut == 'Actuel' ? Colors.green : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text('Historique des locataires', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: historique.isEmpty
            ? Center(
                key: const ValueKey('empty'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    emptyAnimation(height: 140),
                    const SizedBox(height: 16),
                    Text(
                      'Aucun locataire enregistré pour le moment.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                key: const ValueKey('list'),
                padding: const EdgeInsets.all(24),
                itemCount: historique.length,
                itemBuilder: (context, index) {
                  final locataire = historique[index];
                  return _buildLocataireCard(
                    context: context,
                    nom: locataire['nom'],
                    logement: locataire['logement'],
                    dateEntree: locataire['dateEntree'],
                    dateSortie: locataire['dateSortie'],
                    statut: locataire['statut'],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildLocataireCard({
    required BuildContext context,
    required String nom,
    required String logement,
    required String dateEntree,
    required String dateSortie,
    required String statut,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatutColor(statut).withOpacity(0.2),
          child: Icon(Icons.person, color: _getStatutColor(statut)),
        ),
        title: Text(
          nom,
          style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              logement,
              style: GoogleFonts.manrope(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              "Entrée : $dateEntree",
              style: GoogleFonts.manrope(fontSize: 12),
            ),
            Text(
              "Sortie : $dateSortie",
              style: GoogleFonts.manrope(fontSize: 12),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getStatutColor(statut).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statut,
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _getStatutColor(statut),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            slideFromRight(
              LocataireDetailsScreen(
                nom: nom,
                logement: logement,
                dateEntree: dateEntree,
                dateSortie: dateSortie,
                statut: statut,
              ),
            ),
          );
        },
      ),
    );
  }
}
