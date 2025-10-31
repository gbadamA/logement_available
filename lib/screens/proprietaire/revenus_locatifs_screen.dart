import 'package:flutter/material.dart';
import 'package:gestionbien/screens/proprietaire/revenus_mensuel_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenusLocatifsScreen extends StatelessWidget {
  const RevenusLocatifsScreen({super.key});

  final List<Map<String, dynamic>> revenus = const [
    {
      'mois': 'Janvier 2024',
      'total': 450000,
      'encaissé': 450000,
      'enAttente': 0,
    },
    {
      'mois': 'Février 2024',
      'total': 450000,
      'encaissé': 300000,
      'enAttente': 150000,
    },
    {'mois': 'Mars 2024', 'total': 450000, 'encaissé': 450000, 'enAttente': 0},
  ];

  @override
  Widget build(BuildContext context) {
    final totalAnnuel = revenus.fold<int>(
      0,
      (sum, item) => sum + item['encaissé'] as int,
    );

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Revenus locatifs",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // 🔹 Résumé global
          _buildResume(totalAnnuel),

          const SizedBox(height: 24),

          // 🔹 Liste mensuelle
          Text(
            "Détails mensuels",
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          ...revenus.map((r) => _buildRevenuCard(context, r)).toList(),
        ],
      ),
    );
  }

  Widget _buildResume(int totalAnnuel) {
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
              "Total encaissé en 2024",
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
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenuCard(BuildContext context, Map<String, dynamic> r) {
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
            backgroundColor: Colors.orange.shade100,
            child: const Icon(Icons.calendar_month, color: Colors.orange),
          ),
          title: Text(
            r['mois'],
            style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total : ${r['total']} CFA"),
              Text(
                "Encaissé : ${r['encaissé']} CFA",
                style: const TextStyle(color: Colors.green),
              ),
              if (r['enAttente'] > 0)
                Text(
                  "En attente : ${r['enAttente']} CFA",
                  style: const TextStyle(color: Colors.redAccent),
                ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RevenusMensuelsDetailsScreen(mois: r['mois']),
              ),
            );
          },
        ),
      ),
    );
  }
}
