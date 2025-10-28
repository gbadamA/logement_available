import 'package:flutter/material.dart';

import 'modifier_profil_locataire_screen.dart';

class SettingsLocataireScreen extends StatelessWidget {
  const SettingsLocataireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Paramètres locataire'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSettingButton(
                icon: Icons.person,
                label: 'Modifier le profil',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifierProfilLocataireScreen()),
                  );
                },

              ),
              SizedBox(height: 16),
              _buildSettingButton(
                icon: Icons.lock,
                label: 'Changer le mot de passe',
                onTap: () {},
              ),
              SizedBox(height: 16),
              _buildSettingButton(
                icon: Icons.language,
                label: 'Langue',
                onTap: () {},
              ),
              SizedBox(height: 16),
              _buildSettingButton(
                icon: Icons.logout,
                label: 'Déconnexion',
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.indigo.shade100,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.indigo, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
