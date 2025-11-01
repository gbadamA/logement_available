import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class RevenusMensuelsDetailsScreen extends StatelessWidget {
  final String mois;

  const RevenusMensuelsDetailsScreen({super.key, required this.mois});

  final List<Map<String, dynamic>> paiements = const [
    {
      'locataire': 'Jean Kouassi',
      'logement': 'Appartement B2',
      'montant': 150000,
      'statut': 'Payé',
      'date': '05 Janv. 2024',
    },
    {
      'locataire': 'Aminata Touré',
      'logement': 'Studio A1',
      'montant': 150000,
      'statut': 'Payé',
      'date': '03 Janv. 2024',
    },
    {
      'locataire': 'Moussa Diabaté',
      'logement': 'Appartement C3',
      'montant': 150000,
      'statut': 'En attente',
      'date': '-',
    },
  ];

  Color _getStatutColor(String statut) {
    return statut == 'Payé' ? Colors.green : Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final total = paiements.fold<int>(0, (sum, p) => sum + p['montant'] as int);
    final encaisse = paiements
        .where((p) => p['statut'] == 'Payé')
        .fold<int>(0, (s, p) => s + p['montant'] as int);
    final enAttente = total - encaisse;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Détails - $mois",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // 🔹 Résumé du mois
          Ink(
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
                    "Total attendu",
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
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Graphique camembert
          Text(
            "Répartition Payé / En attente",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: encaisse.toDouble(),
                    color: Colors.green,
                    title: "${((encaisse / total) * 100).toStringAsFixed(1)}%",
                    radius: 80,
                    titleStyle: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: enAttente.toDouble(),
                    color: Colors.redAccent,
                    title: "${((enAttente / total) * 100).toStringAsFixed(1)}%",
                    radius: 80,
                    titleStyle: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Liste des paiements
          Text(
            "Paiements des locataires",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...paiements.map((p) => _buildPaiementCard(p)).toList(),
        ],
      ),
    );
  }

  Widget _buildPaiementCard(Map<String, dynamic> p) {
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
            backgroundColor: _getStatutColor(p['statut']).withOpacity(0.2),
            child: Icon(Icons.person, color: _getStatutColor(p['statut'])),
          ),
          title: Text(
            p['locataire'],
            style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['logement'],
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
              Text("Montant : ${p['montant']} CFA"),
              Text("Date : ${p['date']}"),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatutColor(p['statut']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              p['statut'],
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getStatutColor(p['statut']),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
