import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String _selectedRole = 'Locataire';

  late AnimationController _formController;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _formController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimations = List.generate(4, (i) {
      return Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _formController,
          curve: Interval(0.2 * i, 0.8, curve: Curves.easeOut),
        ),
      );
    });

    _fadeAnimations = List.generate(4, (i) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _formController,
          curve: Interval(0.2 * i, 1.0, curve: Curves.easeIn),
        ),
      );
    });

    _formController.forward();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      print('Nom: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Mot de passe: ${_passwordController.text}');
      print('Rôle: $_selectedRole');

      Navigator.pushReplacementNamed(
        context,
        _selectedRole == 'Propriétaire'
            ? '/home_proprietaire'
            : '/home_locataire',
      );
    }
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              Icon(Icons.person_add, size: 80, color: Colors.teal),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Espace d’inscription',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              SlideTransition(
                position: _slideAnimations[0],
                child: FadeTransition(
                  opacity: _fadeAnimations[0],
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nom complet'),
                    validator: (value) =>
                        value!.isEmpty ? 'Veuillez entrer votre nom' : null,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _slideAnimations[1],
                child: FadeTransition(
                  opacity: _fadeAnimations[1],
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Veuillez entrer un email' : null,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _slideAnimations[2],
                child: FadeTransition(
                  opacity: _fadeAnimations[2],
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? 'Minimum 6 caractères' : null,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SlideTransition(
                position: _slideAnimations[3],
                child: FadeTransition(
                  opacity: _fadeAnimations[3],
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
                  onPressed: _register,
                  child: Text('Créer mon compte'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Home_login');
                },
                child: Text('Déjà inscrit ? Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
