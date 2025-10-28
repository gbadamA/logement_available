import 'package:flutter/material.dart';

import 'badge_notification.dart';



class CustomDrawer extends StatelessWidget {
  final String role;
  final String selectedPage;
  final Function(String) onSelect;

  const CustomDrawer({
    required this.role,
    required this.selectedPage,
    required this.onSelect, required ListView child,
  });

  @override
  Widget build(BuildContext context) {
    final items = role == 'Propriétaire'
        ? {
      'Tableau de bord': Icons.dashboard,
      'Mes biens': Icons.home_work,
      'Paiements': Icons.payment,
      'Signalements': Icons.report,
      'Messagerie': Icons.chat,
      'Documents': Icons.folder,
      'Statistiques': Icons.bar_chart,
      'Paramètres': Icons.settings,
    }
        : {
      'Tableau de bord': Icons.dashboard,
      'Contrat': Icons.description,
      'Problème': Icons.report_problem,
      'Messagerie': Icons.chat,
      'Profil': Icons.person,
      'Paramètres': Icons.settings,
    };

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text('Bienvenue $role'),
              accountEmail: Text('contact@immoconnect.ci'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.teal),
              ),
            ),
            ...items.entries.map((entry) {
              final isSelected = selectedPage == entry.key;
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  trailing: buildBadge(3), // Exemple : 3 signalements

                  leading: Icon(entry.value, color: isSelected ? Colors.white : Colors.white70),
                  title: Text(entry.key, style: TextStyle(color: Colors.white)),
                  onTap: () => onSelect(entry.key),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
