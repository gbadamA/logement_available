import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilLocataireScreen extends StatefulWidget {
  const ProfilLocataireScreen({super.key});

  @override
  State<ProfilLocataireScreen> createState() => _ProfilLocataireScreenState();
}

class _ProfilLocataireScreenState extends State<ProfilLocataireScreen> {
  // 🧑‍💼 Données simulées
  String nom = 'Koffi Jean';
  String email = 'jean.koffi@email.com';
  String telephone = '+225 07 07 07 07';
  String adresse = 'Cocody Riviera 3, Abidjan';
  final contratUrl = 'https://example.com/contrat_koffi.pdf';

  final bien = 'Résidence Cocody Riviera';
  final typeBien = 'Appartement';
  final statutBien = 'Occupé';

  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Mon profil'),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 🖼️ Avatar + nom
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                nom[0],
                style: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
            ),
            const SizedBox(height: 12),
            Text(nom, style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w700)),

            const SizedBox(height: 24),

            // 🖊️ Formulaire modifiable
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildEditableCard(
                    icon: Icons.email,
                    label: 'Email',
                    value: email,
                    onChanged: (val) => setState(() => email = val),
                    enabled: isEditing,
                    validator: (val) => val != null && val.contains('@') ? null : 'Email invalide',
                  ),
                  _buildEditableCard(
                    icon: Icons.phone,
                    label: 'Téléphone',
                    value: telephone,
                    onChanged: (val) => setState(() => telephone = val),
                    enabled: isEditing,
                    validator: (val) => val != null && val.length >= 10 ? null : 'Téléphone invalide',
                  ),
                  _buildEditableCard(
                    icon: Icons.location_on,
                    label: 'Adresse',
                    value: adresse,
                    onChanged: (val) => setState(() => adresse = val),
                    enabled: isEditing,
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Adresse requise',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🏠 Bien loué
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bien loué', style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Text('$bien ($typeBien)', style: GoogleFonts.manrope(fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statutBien,
                      style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📎 Contrat
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Documents', style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse(contratUrl));
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Télécharger le contrat de location'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ⚙️ Boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    if (isEditing && _formKey.currentState!.validate()) {
                      setState(() => isEditing = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profil mis à jour ✅')),
                      );
                    } else {
                      setState(() => isEditing = !isEditing);
                    }
                  },
                  icon: Icon(isEditing ? Icons.save : Icons.edit),
                  label: Text(isEditing ? 'Enregistrer' : 'Modifier'),
                  style: OutlinedButton.styleFrom(
                    textStyle: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // 🔁 Déconnexion
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Déconnexion'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Carte modifiable
  Widget _buildEditableCard({
    required IconData icon,
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required bool enabled,
    required String? Function(String?) validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                enabled
                    ? TextFormField(
                  initialValue: value,
                  onChanged: onChanged,
                  validator: validator,
                  style: GoogleFonts.manrope(fontSize: 14),
                  decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
                )
                    : Text(value, style: GoogleFonts.manrope(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
