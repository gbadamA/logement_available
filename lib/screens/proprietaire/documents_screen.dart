import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  final List<Map<String, dynamic>> documents = const [
    {
      'title': 'Contrat de location',
      'subtitle': 'Signé le 12 août 2025',
      'icon': Icons.description,
    },
    {
      'title': 'Quittance de loyer - Octobre',
      'subtitle': 'Payée le 5 octobre 2025',
      'icon': Icons.receipt_long,
    },
    {
      'title': 'Pièce d’identité',
      'subtitle': 'Carte nationale - Recto/Verso',
      'icon': Icons.badge,
    },
    {
      'title': 'Attestation de résidence',
      'subtitle': 'Demandée le 20 septembre 2025',
      'icon': Icons.home_work,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Mes documents', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
          return _buildDocumentCard(
            icon: doc['icon'],
            title: doc['title'],
            subtitle: doc['subtitle'],
            onTap: () {
              // logique pour ouvrir ou télécharger
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ouverture de "${doc['title']}"')),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.indigo.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, size: 28, color: Colors.indigo),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: GoogleFonts.manrope(fontSize: 14, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
