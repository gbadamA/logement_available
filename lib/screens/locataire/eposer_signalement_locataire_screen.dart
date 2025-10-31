import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeposerSignalementLocataireScreen extends StatefulWidget {
  const DeposerSignalementLocataireScreen({super.key});

  @override
  State<DeposerSignalementLocataireScreen> createState() =>
      _DeposerSignalementLocataireScreenState();
}

class _DeposerSignalementLocataireScreenState
    extends State<DeposerSignalementLocataireScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'Fuite d’eau';
  String _description = '';
  String _logement = '';
  final List<String> types = [
    'Fuite d’eau',
    'Panne électrique',
    'Nuisance sonore',
    'Autre',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nomLocataire = 'Jean Kouassi'; // à récupérer dynamiquement

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text('Déposer un signalement', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🏠 Logement concerné
              TextFormField(
                onChanged: (val) => _logement = val,
                validator: (val) =>
                    val!.isEmpty ? 'Veuillez indiquer le logement' : null,
                decoration: InputDecoration(
                  labelText: 'Logement concerné',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.manrope(),
              ),

              const SizedBox(height: 24),

              // 🧩 Type de signalement
              DropdownButtonFormField<String>(
                value: _type,
                items: types
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _type = val!),
                decoration: InputDecoration(
                  labelText: 'Type de problème',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 📝 Description
              TextFormField(
                maxLines: 5,
                onChanged: (val) => _description = val,
                validator: (val) =>
                    val!.isEmpty ? 'Veuillez décrire le problème' : null,
                decoration: InputDecoration(
                  labelText: 'Description détaillée',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: GoogleFonts.manrope(),
              ),

              const SizedBox(height: 32),

              // ✅ Bouton envoyer
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final signalement = {
                      'locataire': nomLocataire,
                      'logement': _logement,
                      'type': _type,
                      'description': _description,
                      'date': DateTime.now().toIso8601String(),
                      'statut': 'En attente',
                      'photos': [], // à intégrer plus tard
                      'historique': [
                        {
                          'statut': 'En attente',
                          'date': DateTime.now().toIso8601String(),
                          'commentaire': 'Signalement créé par le locataire',
                        },
                      ],
                    };

                    // 🔗 À connecter à Firebase ou backend
                    print('Signalement : $signalement');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signalement envoyé ✅')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Envoyer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  textStyle: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
