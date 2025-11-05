import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_animations.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'titre': 'Loyer en retard',
      'message': 'Jean Kouassi n’a pas payé son loyer de Février.',
      'date': '28 Fév. 2024',
      'type': 'Finance',
      'lu': false,
    },
    {
      'titre': 'Entretien prévu',
      'message': 'Contrôle électricité prévu le 10 Mars pour Studio A1.',
      'date': '08 Mars 2024',
      'type': 'Entretien',
      'lu': true,
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Finance':
        return Colors.redAccent;
      case 'Entretien':
        return Colors.orange;
      case 'Document':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Notifications & Alertes",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: notifications.isEmpty
                  ? Column(
                      key: const ValueKey('empty'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emptyAnimation(height: 140),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune notification pour le moment.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : ListView.separated(
                      key: const ValueKey('list'),
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        return Ink(
                          decoration: BoxDecoration(
                            color: notif['lu']
                                ? Colors.white
                                : Colors.orange.shade100.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getTypeColor(
                                notif['type'],
                              ).withOpacity(0.2),
                              child: Icon(
                                Icons.notifications,
                                color: _getTypeColor(notif['type']),
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notif['titre'],
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (!notif['lu'])
                                  Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(notif['message']),
                            trailing: Text(
                              notif['date'],
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.notifications_active, color: Colors.white),
              label: const Text(
                "Tester une notification",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                NotificationService.showNotification(
                  id: 1,
                  title: "Test Notification",
                  body: "Ceci est une notification locale de test ✅",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
