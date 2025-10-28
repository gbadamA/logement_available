// 📦 Import des packages nécessaires
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart'; // Pour sélectionner un fichier reçu
import 'package:http/http.dart' as http; // Pour simuler un appel API
import 'package:url_launcher/url_launcher.dart'; // Pour ouvrir des liens (optionnel ici)

class EffectuerPaiementLocataireScreen extends StatefulWidget {
  const EffectuerPaiementLocataireScreen({super.key});

  @override
  State<EffectuerPaiementLocataireScreen> createState() => _EffectuerPaiementLocataireScreenState();
}

class _EffectuerPaiementLocataireScreenState extends State<EffectuerPaiementLocataireScreen> {
  // 🔐 Clé du formulaire
  final _formKey = GlobalKey<FormState>();

  // 🧾 Champs du formulaire
  String _montant = '';
  String _moyen = 'Mobile Money';
  String _periode = 'Novembre 2025';

  // 📎 Fichier reçu sélectionné
  PlatformFile? _recuFichier;

  // ⏳ Indicateur de chargement pendant l’appel API
  bool _isUploading = false;

  // 📋 Listes de choix
  final List<String> moyens = ['Mobile Money', 'Virement bancaire', 'Espèces'];
  final List<String> periodes = ['Octobre 2025', 'Novembre 2025', 'Décembre 2025'];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Effectuer un paiement', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 💰 Champ montant
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (val) => _montant = val,
                validator: (val) => val!.isEmpty ? 'Veuillez entrer un montant' : null,
                decoration: InputDecoration(
                  labelText: 'Montant à payer',
                  prefixText: 'FCFA ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                style: GoogleFonts.manrope(),
              ),

              const SizedBox(height: 24),

              // 📅 Sélection de la période
              DropdownButtonFormField<String>(
                value: _periode,
                items: periodes.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setState(() => _periode = val!),
                decoration: InputDecoration(
                  labelText: 'Période concernée',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 24),

              // 💳 Sélection du moyen de paiement
              DropdownButtonFormField<String>(
                value: _moyen,
                items: moyens.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (val) => setState(() {
                  _moyen = val!;
                  _recuFichier = null; // 🔄 Réinitialise le reçu si le moyen change
                }),
                decoration: InputDecoration(
                  labelText: 'Moyen de paiement',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              // 📎 Upload du reçu si moyen ≠ Mobile Money
              if (_moyen == 'Virement bancaire' || _moyen == 'Espèces') ...[
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _recuFichier != null
                            ? 'Reçu sélectionné : ${_recuFichier!.name}'
                            : 'Aucun reçu sélectionné',
                        style: GoogleFonts.manrope(fontSize: 14),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'pdf'],
                        );
                        if (result != null && result.files.isNotEmpty) {
                          setState(() {
                            _recuFichier = result.files.first;
                          });
                        }
                      },
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Joindre reçu'),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 32),

              // ✅ Bouton de validation
              _isUploading
                  ? const CircularProgressIndicator() // ⏳ Affiche un loader pendant l’appel API
                  : ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // 🔗 Cas Mobile Money : appel API
                    if (_moyen == 'Mobile Money') {
                      setState(() => _isUploading = true);

                      final response = await http.post(
                        Uri.parse('https://api.immoconnect.ci/paiement/mobilemoney'),
                        body: {
                          'montant': _montant,
                          'periode': _periode,
                          'locataire': 'MUTIYU',
                        },
                      );

                      setState(() => _isUploading = false);

                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Paiement Mobile Money effectué ✅')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Échec du paiement Mobile Money ❌')),
                        );
                      }
                    } else {
                      // 📎 Cas Virement ou Espèces : reçu obligatoire
                      if (_recuFichier == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Veuillez joindre un reçu 📎')),
                        );
                        return;
                      }

                      // 🔁 Logique d’enregistrement à connecter plus tard
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Paiement enregistré avec reçu ✅')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Valider le paiement'),
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
}
