import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class DepensesMensuellesDetailsScreen extends StatelessWidget {
  final String mois;

  const DepensesMensuellesDetailsScreen({super.key, required this.mois});

  final List<Map<String, dynamic>> depenses = const [
    {
      'categorie': 'Entretien',
      'montant': 50000,
      'statut': 'Payé',
      'date': '10 Janv. 2024',
    },
    {
      'categorie': 'Impôts fonciers',
      'montant': 120000,
      'statut': 'Payé',
      'date': '15 Janv. 2024',
    },
    {
      'categorie': 'Réparations',
      'montant': 80000,
      'statut': 'En attente',
      'date': '-',
    },
  ];

  Color _getStatutColor(String statut) {
    return statut == 'Payé' ? Colors.green : Colors.redAccent;
  }

  Color _getColorForCategory(String key) {
    switch (key) {
      case 'Entretien':
        return Colors.blue;
      case 'Impôts fonciers':
        return Colors.orange;
      case 'Réparations':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = depenses.fold<int>(0, (sum, d) => sum + d['montant'] as int);

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Dépenses - $mois",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildResume(total),
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
            "Détails des charges",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...depenses.map((d) => _buildDepenseCard(d)).toList(),
        ],
      ),
    );
  }

  Widget _buildResume(int total) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Total dépenses",
              style: GoogleFonts.manrope(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$total CFA",
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
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

  Widget _buildDepenseCard(Map<String, dynamic> d) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getStatutColor(d['statut']).withOpacity(0.2),
            child: Icon(
              Icons.receipt_long,
              color: _getStatutColor(d['statut']),
            ),
          ),
          title: Text(
            d['categorie'],
            style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("Date : ${d['date']}"),
          trailing: Text(
            "${d['montant']} CFA",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.w700,
              color: _getStatutColor(d['statut']),
            ),
          ),
        ),
      ),
    );
  }
}
