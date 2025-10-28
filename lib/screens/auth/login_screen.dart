import 'package:flutter/material.dart';

class  LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State< LoginSignupScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _formController;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Locataire';

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _logoAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _formController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(3, (i) {
      return Tween<Offset>(
        begin: Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _formController,
        curve: Interval(0.2 * i, 0.8, curve: Curves.easeOut),
      ));
    });

    _fadeAnimations = List.generate(3, (i) {
      return Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _formController,
        curve: Interval(0.2 * i, 1.0, curve: Curves.easeIn),
      ));
    });

    _formController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _formController.dispose();
    super.dispose();
  }

  void _login() {
    print('Email: ${_emailController.text}');
    print('Mot de passe: ${_passwordController.text}');
    print('Rôle: $_selectedRole');

    // Navigation conditionnelle selon le rôle
    if (_selectedRole == 'Propriétaire') {
      Navigator.pushReplacementNamed(context, '/home_proprietaire');
    } else {
      Navigator.pushReplacementNamed(context, '/home_locataire');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(24),
          shrinkWrap: true,
          children: [
            RotationTransition(
              turns: _logoAnimation,
              child: Icon(Icons.home_work, size: 80, color: Colors.teal),
            ),
            SizedBox(height: 20),
            Center(
              child: Text('Connexion', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 30),
            SlideTransition(
              position: _slideAnimations[0],
              child: FadeTransition(
                opacity: _fadeAnimations[0],
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[1],
              child: FadeTransition(
                opacity: _fadeAnimations[1],
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[2],
              child: FadeTransition(
                opacity: _fadeAnimations[2],
                child: DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(labelText: 'Je suis'),
                  items: ['Locataire', 'Propriétaire'].map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimations.last,
              child: ElevatedButton(
                onPressed: _login,
                child: Text('Se connecter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
