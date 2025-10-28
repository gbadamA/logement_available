import 'package:flutter/material.dart';

class LocataireDrawer extends StatelessWidget {
  final String selectedPage;
  final Function(String) onSelect;

  const LocataireDrawer({
    required this.selectedPage,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = {
      'Mes locations': Icons.home,
      'Paiement du loyer': Icons.payment,
      'Demande de maintenance': Icons.build,
      'Messages': Icons.chat,
      'Profil': Icons.person,
      'Paramètres': Icons.settings,
    };

    final Map<String, int> notificationCounts = {
      'Mes locations': 0,
      'Paiement du loyer': 1,
      'Demande de maintenance': 2,
      'Messages': 3,
      'Profil': 0,
      'Paramètres': 0,
    };

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade700, Colors.indigo.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Nom du locataire'),
              accountEmail: Text('locataire@immoconnect.ci'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.indigo),
              ),
              decoration: BoxDecoration(color: Colors.transparent),
            ),
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: items.entries.map((entry) {
                    final isSelected = selectedPage == entry.key;
                    final count = notificationCounts[entry.key] ?? 0;

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Icon(entry.value, color: Colors.white),
                            if (count > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$count',
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(entry.key, style: TextStyle(color: Colors.white)),
                        onTap: () => onSelect(entry.key),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
