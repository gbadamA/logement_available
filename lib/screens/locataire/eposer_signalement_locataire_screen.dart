import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeposerSignalementLocataireScreen extends StatefulWidget {
  const DeposerSignalementLocataireScreen({super.key});

  @override
  State<DeposerSignalementLocataireScreen> createState() => _DeposerSignalementLocataireScreenState();
}

class _DeposerSignalementLocataireScreenState extends State<DeposerSignalementLocataireScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'Fuite d’eau';
  String _description = '';
  final List<String> types = ['Fuite d’eau', 'Panne électrique', 'Nuisance sonore', 'Autre'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Déposer un signalement', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🧩 Type de signalement
              DropdownButtonFormField<String>(
                value: _type,
                items: types.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (val) => setState(() => _type = val!),
                decoration: InputDecoration(
                  labelText: 'Type de problème',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 24),

              // 📝 Description
              TextFormField(
                maxLines: 5,
                onChanged: (val) => _description = val,
                validator: (val) => val!.isEmpty ? 'Veuillez décrire le problème' : null,
                decoration: InputDecoration(
                  labelText: 'Description détaillée',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                style: GoogleFonts.manrope(),
              ),

              const SizedBox(height: 32),

              // ✅ Bouton envoyer
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // logique d’envoi à connecter plus tard
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signalement envoyé ✅')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Envoyer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
