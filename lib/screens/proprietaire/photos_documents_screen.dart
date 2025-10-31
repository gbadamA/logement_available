import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class PhotosDocumentsScreen extends StatefulWidget {
  const PhotosDocumentsScreen({super.key});

  @override
  State<PhotosDocumentsScreen> createState() => _PhotosDocumentsScreenState();
}

class _PhotosDocumentsScreenState extends State<PhotosDocumentsScreen> {
  List<Map<String, dynamic>> fichiers = [
    {
      'type': 'image',
      'nom': 'Appartement_B2_photo1.jpg',
      'logement': 'Appartement B2',
    },
    {'type': 'pdf', 'nom': 'Contrat_B2.pdf', 'logement': 'Appartement B2'},
  ];

  IconData _getIcon(String type) {
    switch (type) {
      case 'image':
        return Icons.image;
      case 'pdf':
        return Icons.picture_as_pdf;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'image':
        return Colors.indigo;
      case 'pdf':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  Future<void> _ajouterFichier() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final fichier = result.files.first;

      setState(() {
        fichiers.add({
          'type': fichier.extension == 'pdf' ? 'pdf' : 'image',
          'nom': fichier.name,
          'logement': 'Non assigné', // 👉 tu pourras l’associer à un logement
        });
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${fichier.name} ajouté ✅")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text('Photos & Documents', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: fichiers.length,
        itemBuilder: (context, index) {
          final fichier = fichiers[index];
          return _buildFileCard(
            fichier['type'],
            fichier['nom'],
            fichier['logement'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _ajouterFichier,
        icon: const Icon(Icons.add),
        label: const Text("Ajouter"),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildFileCard(String type, String nom, String logement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: ListTile(
          leading: Icon(_getIcon(type), color: _getColor(type), size: 32),
          title: Text(
            nom,
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            logement,
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility, color: Colors.indigo),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.download, color: Colors.green),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  setState(() => fichiers.removeWhere((f) => f['nom'] == nom));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("$nom supprimé ❌")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
