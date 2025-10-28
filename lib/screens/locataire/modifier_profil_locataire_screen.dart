import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifierProfilLocataireScreen extends StatefulWidget {
  const ModifierProfilLocataireScreen({super.key});

  @override
  State<ModifierProfilLocataireScreen> createState() => _ModifierProfilLocataireScreenState();
}

class _ModifierProfilLocataireScreenState extends State<ModifierProfilLocataireScreen> {
  final _formKey = GlobalKey<FormState>();

  // Champs du locataire
  String _nom = '';
  String _email = 'locataire@example.com'; // lecture seule
  String _telephone = '';
  String _adresse = '';
  String _contrat = '';
  String _langue = 'Français';
  bool _notifications = true;

  final List<String> langues = ['Français', 'Anglais', 'Espagnol'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le profil locataire', style: textTheme.titleLarge),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 📸 Avatar
              CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/avatar.png')),
              TextButton(onPressed: () {}, child: Text('Changer la photo', style: GoogleFonts.manrope())),
              const SizedBox(height: 24),

              // 🧍 Nom
              _buildTextField('Nom complet', _nom, (val) => _nom = val, true),

              // 📧 Email (lecture seule)
              _buildTextField('Adresse e-mail', _email, null, false),

              // 📱 Téléphone
              _buildTextField('Téléphone', _telephone, (val) => _telephone = val, true, TextInputType.phone),

              // 🏠 Adresse
              _buildTextField('Adresse', _adresse, (val) => _adresse = val, true),

              // 📄 Contrat locatif
              _buildTextField('Numéro de contrat', _contrat, (val) => _contrat = val, true),

              const SizedBox(height: 16),

              // 🌐 Langue
              DropdownButtonFormField<String>(
                value: _langue,
                items: langues.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
                onChanged: (val) => setState(() => _langue = val!),
                decoration: InputDecoration(
                  labelText: 'Langue préférée',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 16),

              // 🔔 Notifications
              SwitchListTile(
                value: _notifications,
                onChanged: (val) => setState(() => _notifications = val),
                title: Text('Notifications activées', style: GoogleFonts.manrope(fontSize: 16)),
                activeColor: Colors.indigo,
              ),

              const SizedBox(height: 32),

              // ✅ Bouton enregistrer
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil locataire mis à jour ✅')),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer'),
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

  Widget _buildTextField(
      String label,
      String initialValue,
      void Function(String)? onChanged,
      bool enabled, [
        TextInputType keyboardType = TextInputType.text,
      ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: enabled ? (val) => val!.isEmpty ? 'Champ requis' : null : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        style: GoogleFonts.manrope(),
      ),
    );
  }
}
