import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

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
              if (_selectedDay != null && _titreController.text.isNotEmpty) {
                final dateKey = DateTime.utc(
                  _selectedDay!.year,
                  _selectedDay!.month,
                  _selectedDay!.day,
                );
                setState(() {
                  _events.putIfAbsent(dateKey, () => []);
                  _events[dateKey]!.add({
                    'titre': _titreController.text,
                    'logement': _logementController.text,
                    'statut': statut,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          // 🔹 Calendrier
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
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 Liste des entretiens du jour sélectionné
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_selectedDay == null)
                  Text(
                    "Sélectionnez une date pour voir ou ajouter des entretiens",
                    style: GoogleFonts.manrope(color: Colors.grey),
                  ),
                ..._getEventsForDay(_selectedDay ?? _focusedDay).map((event) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.build, color: Colors.orange),
                      title: Text(
                        event['titre']!,
                        style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("Logement : ${event['logement']}"),
                      trailing: Text(
                        event['statut']!,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          color: event['statut'] == 'Réalisé'
                              ? Colors.green
                              : event['statut'] == 'Reporté'
                              ? Colors.blue
                              : Colors.redAccent,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),

      // 🔹 Bouton d’ajout
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () => _ajouterEntretien(context),
      ),
    );
  }
}
