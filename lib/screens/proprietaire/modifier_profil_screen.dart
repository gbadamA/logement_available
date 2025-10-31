import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifierProfilScreen extends StatefulWidget {
  const ModifierProfilScreen({super.key});

  @override
  State<ModifierProfilScreen> createState() => _ModifierProfilScreenState();
}

class _ModifierProfilScreenState extends State<ModifierProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nom = '';
  String _email = 'mutiyu@example.com'; // lecture seule
  String _telephone = '';
  String _adresse = '';
  String _langue = 'Français';
  bool _notifications = true;

  final List<String> langues = ['Français', 'Anglais', 'Espagnol'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('', style: textTheme.titleLarge),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 📸 Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/avatar.png',
                ), // à remplacer
              ),
              TextButton(
                onPressed: () {
                  // logique pour changer la photo
                },
                child: Text('Changer la photo', style: GoogleFonts.manrope()),
              ),
              const SizedBox(height: 24),

              // 🧍 Nom
              _buildTextField(
                label: 'Nom complet',
                initialValue: _nom,
                onChanged: (val) => _nom = val,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
              ),

              // 📧 Email (lecture seule)
              _buildTextField(
                label: 'Adresse e-mail',
                initialValue: _email,
                enabled: false,
              ),

              // 📱 Téléphone
              _buildTextField(
                label: 'Téléphone',
                initialValue: _telephone,
                onChanged: (val) => _telephone = val,
                keyboardType: TextInputType.phone,
              ),

              // 🏠 Adresse
              _buildTextField(
                label: 'Adresse',
                initialValue: _adresse,
                onChanged: (val) => _adresse = val,
              ),

              const SizedBox(height: 16),

              // 🌐 Langue
              DropdownButtonFormField<String>(
                value: _langue,
                items: langues.map((lang) {
                  return DropdownMenuItem(value: lang, child: Text(lang));
                }).toList(),
                onChanged: (val) => setState(() => _langue = val!),
                decoration: InputDecoration(
                  labelText: 'Langue préférée',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🔔 Notifications
              SwitchListTile(
                value: _notifications,
                onChanged: (val) => setState(() => _notifications = val),
                title: Text(
                  'Notifications activées',
                  style: GoogleFonts.manrope(fontSize: 16),
                ),
                activeColor: Colors.indigo,
              ),

              const SizedBox(height: 32),

              // ✅ Bouton enregistrer
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // logique de sauvegarde
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil mis à jour ✅')),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
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

  Widget _buildTextField({
    required String label,
    required String initialValue,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        style: GoogleFonts.manrope(),
      ),
    );
  }
}
