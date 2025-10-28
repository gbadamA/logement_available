import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProprietaireDashboardScreen extends StatelessWidget {
  const ProprietaireDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Tableau de bord propriétaire', style: textTheme.titleLarge),
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bonjour MUTIYU 👑', style: textTheme.headlineLarge),
            const SizedBox(height: 16),
            Text(
              'Gérez vos biens, vos locataires et vos statistiques en un seul endroit.',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            _buildCard(context, Icons.bar_chart, 'Statistiques', '/proprietaire/statistiques'),
            _buildCard(context, Icons.group, 'Gestion des locataires', '/proprietaire/locataires'),
            _buildCard(context, Icons.settings, 'Paramètres', '/proprietaire/settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.indigo),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
