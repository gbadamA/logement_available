import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_manager.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Choisissez votre rôle')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => themeManager.setRole(UserRole.locataire),
            child: const Text('Locataire'),
          ),
          ElevatedButton(
            onPressed: () => themeManager.setRole(UserRole.proprietaire),
            child: const Text('Propriétaire'),
          ),
        ],
      ),
    );
  }
}
