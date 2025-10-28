import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemandeLocationScreen extends StatefulWidget {
  const DemandeLocationScreen({super.key});

  @override
  State<DemandeLocationScreen> createState() => _DemandeLocationScreenState();
}

class _DemandeLocationScreenState extends State<DemandeLocationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? typeDemande;
  String? bienSelectionne;
  String message = '';

  final List<String> types = ['Renouvellement', 'Résiliation', 'Modification'];
  final List<String> biens = [
    'Résidence Cocody Riviera',
    'Studio Angré 8e Tranche',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Faire une demande'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🔘 Type de demande
              DropdownButtonFormField<String>(
                value: typeDemande,
                items: types.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) => setState(() => typeDemande = val),
                decoration: InputDecoration(
                  labelText: 'Type de demande',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null ? 'Sélectionnez un type' : null,
              ),
              const SizedBox(height: 16),

              // 🏠 Bien concerné
              DropdownButtonFormField<String>(
                value: bienSelectionne,
                items: biens.map((bien) {
                  return DropdownMenuItem(value: bien, child: Text(bien));
                }).toList(),
                onChanged: (val) => setState(() => bienSelectionne = val),
                decoration: InputDecoration(
                  labelText: 'Bien concerné',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null ? 'Sélectionnez un bien' : null,
              ),
              const SizedBox(height: 16),

              // ✍️ Message
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  hintText: 'Expliquez votre demande ici...',
                ),
                onChanged: (val) => message = val,
                validator: (val) => val == null || val.isEmpty ? 'Message requis' : null,
              ),
              const SizedBox(height: 24),

              // 📤 Bouton envoyer
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 🔁 Traitement de la demande
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Demande envoyée ✅')),
                      );
                      setState(() {
                        typeDemande = null;
                        bienSelectionne = null;
                        message = '';
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Envoyer la demande'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
