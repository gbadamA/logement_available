import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProprietaireDashboardScreen extends StatelessWidget {
  const ProprietaireDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.orange.shade50, // 🎨 Fond doux
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Tableau de bord', style: textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👋 Accueil personnalisé
            Text('Bonjour MUTIYU 👑', style: textTheme.headlineLarge),
            const SizedBox(height: 12),
            Text(
              'Gérez vos biens, vos locataires et vos statistiques en un seul endroit.',
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // 🏠 Onglets de gestion des biens
            ..._buildSection(context, 'Gestion des biens', [
              _CardData(
                Icons.event_available, // Icône de disponibilité
                'Disponibilités', // Titre affiché
                '/disponibilites', // Route vers l’écran
                Colors.orange.shade200, // Couleur de fond
              ),

              _CardData(
                Icons.description,
                'Contrats & baux',
                '/contrats',
                Colors.orange.shade100,
              ),

              _CardData(
                Icons.photo_library,
                'Photos & documents',
                '/documents',
                Colors.orange.shade100,
              ),

              _CardData(
                Icons.history,
                'Historique des locataires',
                '/historique',
                Colors.orange.shade100,
              ),
              _CardData(
                Icons.attach_money,
                'Revenus locatifs',
                '/revenus',
                Colors.green.shade100,
              ),

              _CardData(
                Icons.receipt_long,
                'Charges & Dépenses',
                '/depenses',
                Colors.red.shade100,
              ),

              _CardData(
                Icons.calendar_today,
                'Calendrier d’entretien',
                '/calendrier',
                Colors.orange.shade200,
              ),
              _CardData(
                Icons.notifications_active,
                'Notifications & alertes',
                '/notifications',
                Colors.orange.shade100,
              ),
            ]),

            const SizedBox(height: 32),

            // ✨ Onglets dynamiques bonus
            ..._buildSection(context, 'Outils dynamiques', [
              _CardData(
                Icons.search,
                'Recherche par logement',
                '/proprietaire/recherche',
                Colors.deepOrange.shade100,
              ),
              _CardData(
                Icons.trending_up,
                'Performance du bien',
                '/proprietaire/performance',
                Colors.deepOrange.shade200,
              ),
              _CardData(
                Icons.folder_shared,
                'Documents partagés',
                '/proprietaire/partages',
                Colors.deepOrange.shade100,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // 🔁 Génère une section avec titre + cartes
  List<Widget> _buildSection(
    BuildContext context,
    String title,
    List<_CardData> cards,
  ) {
    return [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      ...cards.map((card) => _buildHoverCard(context, card)).toList(),
    ];
  }

  // 🧩 Carte avec effet de survol
  Widget _buildHoverCard(BuildContext context, _CardData data) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, data.route),
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isHovered ? data.color.withOpacity(0.95) : data.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isHovered ? Colors.black26 : Colors.black12,
                    blurRadius: isHovered ? 10 : 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(data.icon, size: 28, color: Colors.indigo),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      data.label,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// 📦 Structure de données pour chaque carte
class _CardData {
  final IconData icon;
  final String label;
  final String route;
  final Color color;

  const _CardData(this.icon, this.label, this.route, this.color);
}
