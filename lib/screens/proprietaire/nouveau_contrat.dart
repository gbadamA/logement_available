import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NouveauContratScreen extends StatefulWidget {
  const NouveauContratScreen({super.key});

  @override
  State<NouveauContratScreen> createState() => _NouveauContratScreenState();
}

class _NouveauContratScreenState extends State<NouveauContratScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _locataireCtrl = TextEditingController();
  final TextEditingController _logementCtrl = TextEditingController();
  final TextEditingController _dateDebutCtrl = TextEditingController();
  final TextEditingController _dateFinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          "Nouveau contrat",
          style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Nom du locataire", _locataireCtrl),
              _buildTextField("Logement", _logementCtrl),
              _buildTextField("Date de début", _dateDebutCtrl),
              _buildTextField("Date de fin", _dateFinCtrl),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 👉 Ici tu enregistres le contrat (Firebase ou local)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Contrat ajouté avec succès ✅"),
                      ),
                    );
                    Navigator.pop(context); // retour à la liste
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Enregistrer"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Champ requis" : null,
      ),
    );
  }
}
