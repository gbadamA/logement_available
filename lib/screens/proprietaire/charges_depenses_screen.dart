import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gestionbien/screens/proprietaire/depenses_mensuelles_details_screen.dart';

import '../../utils/app_animations.dart'; // 🎬 Animations centralisées

class ChargesDepensesScreen extends StatelessWidget {
  const ChargesDepensesScreen({super.key});

  final List<Map<String, dynamic>> depenses = const [
    {
      'mois': 'Janvier 2024',
      'categorie': 'Entretien',
      'montant': 50000,
      'statut': 'Payé',
    },
    {
      'mois': 'Janvier 2024',
      'categorie': 'Impôts fonciers',
      'montant': 120000,
      'statut': 'Payé',
    },
    {
      'mois': 'Février 2024',
      'categorie': 'Réparations',
      'montant': 80000,
      'statut': 'En attente',
    },
    {
      'mois': 'Mars 2024',
      'categorie': 'Factures eau/électricité',
      'montant': 60000,
      'statut': 'Payé',
    },
  ];

  Color _getStatutColor(String statut) =>
      statut == 'Payé' ? Colors.green : Colors.redAccent;

  Color _getColorForCategory(String key) {
    switch (key) {
      case 'Entretien':
        return Colors.blue;
      case 'Impôts fonciers':
        return Colors.orange;
      case 'Réparations':
        return Colors.purple;
      case 'Factures eau/électricité':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAnnuel = depenses.fold<int>(
      0,
      (sum, d) => sum + d['montant'] as int,
    );
    final moisGroupes = <String, List<Map<String, dynamic>>>{};
    for (var d in depenses) {
      moisGroupes.putIfAbsent(d['mois'], () => []).add(d);
    }

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Charges & Dépenses",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: depenses.isEmpty
            ? Center(
                key: const ValueKey('empty'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    emptyAnimation(height: 140),
                    const SizedBox(height: 16),
                    Text(
                      'Aucune dépense enregistrée pour le moment.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView(
                key: const ValueKey('list'),
                padding: const EdgeInsets.all(24),
                children: [
                  _buildResume(totalAnnuel),
                  const SizedBox(height: 24),
                  Text(
                    "Répartition par catégorie",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(height: 250, child: _buildPieChart()),
                  const SizedBox(height: 24),
                  Text(
                    "Détails des dépenses",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...moisGroupes.entries.map((entry) {
                    final totalMois = entry.value.fold<int>(
                      0,
                      (s, d) => s + d['montant'] as int,
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${entry.key} — Total : $totalMois CFA",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...entry.value.map(
                          (d) => _buildDepenseCard(context, d),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }

  Widget _buildResume(int totalAnnuel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Total dépenses en 2024",
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$totalAnnuel CFA",
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    final Map<String, int> categories = {};
    for (var d in depenses) {
      categories[d['categorie']] =
          (categories[d['categorie']] ?? 0) + d['montant'] as int;
    }
    final total = categories.values.fold<int>(0, (s, v) => s + v);

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        pieTouchData: PieTouchData(enabled: true),
        sections: categories.entries.map((entry) {
          final pourcentage = (entry.value / total) * 100;
          return PieChartSectionData(
            value: entry.value.toDouble(),
            title: "${pourcentage.toStringAsFixed(1)}%",
            color: _getColorForCategory(entry.key),
            radius: 80,
            titleStyle: GoogleFonts.manrope(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDepenseCard(BuildContext context, Map<String, dynamic> d) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatutColor(d['statut']).withOpacity(0.2),
          child: Icon(Icons.receipt_long, color: _getStatutColor(d['statut'])),
        ),
        title: Text(
          d['categorie'],
          style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("Mois : ${d['mois']}"),
        trailing: Text(
          "${d['montant']} CFA",
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: _getStatutColor(d['statut']),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            slideFromRight(DepensesMensuellesDetailsScreen(mois: d['mois'])),
          );
        },
      ),
    );
  }
}
