import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsProprietaireScreen extends StatelessWidget {
  const SettingsProprietaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres propriétaire', style: textTheme.titleLarge),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Paramètres du compte ⚙️', style: textTheme.headlineLarge),
              const SizedBox(height: 32),
              _buildSettingButton(context, Icons.person, 'Modifier profil', () {
                Navigator.pushNamed(context, '/modifier_profil');
              }),

              _buildSettingButton(context, Icons.lock, 'Changer mot de passe', () {
                // À connecter à ton écran de sécurité
              }),
              _buildSettingButton(context, Icons.language, 'Langue', () {
                // À connecter à ton sélecteur de langue
              }),
              _buildSettingButton(context, Icons.logout, 'Déconnexion', () {
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.indigo.withOpacity(0.2),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.indigo, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
