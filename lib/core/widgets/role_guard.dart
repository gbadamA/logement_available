import 'package:flutter/material.dart';

class RoleGuard extends StatelessWidget {
  final String expectedRole;
  final String userRole;
  final Widget child;

  const RoleGuard({
    required this.expectedRole,
    required this.userRole,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (userRole != expectedRole) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Accès refusé',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8),
              Text(
                'Cette page est réservée aux $expectedRole.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: Text('Retour à l’accueil'),
              ),
            ],
          ),
        ),
      );
    }

    return child;
  }
}
