import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_animations.dart'; // 🎬 Animations Lottie

class CalendrierEntretienScreen extends StatefulWidget {
  const CalendrierEntretienScreen({super.key});

  @override
  State<CalendrierEntretienScreen> createState() =>
      _CalendrierEntretienScreenState();
}

class _CalendrierEntretienScreenState extends State<CalendrierEntretienScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, String>>> _events = {
    DateTime.utc(2024, 1, 10): [
      {
        'titre': 'Réparation plomberie',
        'logement': 'Appartement B2',
        'statut': 'Prévu',
      },
    ],
    DateTime.utc(2024, 1, 15): [
      {
        'titre': 'Nettoyage escalier',
        'logement': 'Immeuble A',
        'statut': 'Réalisé',
      },
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'Réalisé':
        return Colors.green;
      case 'Reporté':
        return Colors.blue;
      default:
        return Colors.redAccent;
    }
  }

  void _ajouterEntretien(BuildContext context) {
    final _titreController = TextEditingController();
    final _logementController = TextEditingController();
    String statut = "Prévu";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nouvel entretien"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titreController,
              decoration: const InputDecoration(labelText: "Titre"),
            ),
            TextField(
              controller: _logementController,
              decoration: const InputDecoration(labelText: "Logement"),
            ),
            DropdownButtonFormField<String>(
              value: statut,
              items: const [
                DropdownMenuItem(value: "Prévu", child: Text("Prévu")),
                DropdownMenuItem(value: "Réalisé", child: Text("Réalisé")),
                DropdownMenuItem(value: "Reporté", child: Text("Reporté")),
              ],
              onChanged: (val) => statut = val!,
              decoration: const InputDecoration(labelText: "Statut"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedDay == null ||
                  _titreController.text.trim().isEmpty ||
                  _logementController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez remplir tous les champs"),
                  ),
                );
                return;
              }

              final dateKey = DateTime.utc(
                _selectedDay!.year,
                _selectedDay!.month,
                _selectedDay!.day,
              );
              setState(() {
                _events.putIfAbsent(dateKey, () => []);
                _events[dateKey]!.add({
                  'titre': _titreController.text.trim(),
                  'logement': _logementController.text.trim(),
                  'statut': statut,
                });
              });

              Navigator.pop(context);
            },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsDuJour = _getEventsForDay(_selectedDay ?? _focusedDay);
    final dateKey = DateTime.utc(
      (_selectedDay ?? _focusedDay).year,
      (_selectedDay ?? _focusedDay).month,
      (_selectedDay ?? _focusedDay).day,
    );

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Calendrier d’entretien",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: eventsDuJour.isEmpty
                  ? Column(
                      key: const ValueKey('empty'),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        emptyAnimation(height: 140),
                        const SizedBox(height: 16),
                        Text(
                          "Aucun entretien prévu pour cette date.",
                          style: GoogleFonts.manrope(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : ListView(
                      key: const ValueKey('list'),
                      padding: const EdgeInsets.all(16),
                      children: eventsDuJour.map((event) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.build,
                              color: Colors.orange,
                            ),
                            title: Text(
                              event['titre']!,
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text("Logement : ${event['logement']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  event['statut']!,
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    color: _getStatutColor(event['statut']!),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _events[dateKey]?.remove(event);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () => _ajouterEntretien(context),
      ),
    );
  }
}
