import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatistiquesScreen extends StatelessWidget {
  const StatistiquesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistiques', style: textTheme.titleLarge),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vue d’ensemble 📊', style: textTheme.headlineLarge),
            const SizedBox(height: 16),
            Text('Suivez les performances de vos biens et revenus locatifs.',
                style: textTheme.bodyLarge),
            const SizedBox(height: 32),
            _buildStatCard('Biens loués', '12'),
            _buildStatCard('Revenus mensuels', '1 200 000 FCFA'),
            _buildStatCard('Demandes en attente', '3'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
