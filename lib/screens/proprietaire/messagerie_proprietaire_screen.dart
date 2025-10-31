import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_proprietaire_screen.dart';

class MessagerieProprietaireScreen extends StatelessWidget {
  const MessagerieProprietaireScreen({super.key});

  final List<Map<String, dynamic>> conversations = const [
    {
      'nom': 'Koffi Jean',
      'dernierMessage': 'Bonjour, j’ai une question sur le contrat...',
      'date': '21 oct.',
      'avatar': Icons.person,
    },
    {
      'nom': 'Traoré Mariam',
      'dernierMessage': 'Merci pour la quittance reçue.',
      'date': '20 oct.',
      'avatar': Icons.person,
    },
    {
      'nom': 'Gestionnaire ImmoPlus',
      'dernierMessage': 'Le rapport mensuel est prêt.',
      'date': '18 oct.',
      'avatar': Icons.business,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('', style: textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final convo = conversations[index];
          return _buildConversationCard(
            context: context,
            nom: convo['nom'],
            message: convo['dernierMessage'],
            date: convo['date'],
            avatar: convo['avatar'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatProprietaireScreen(destinataire: convo['nom']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildConversationCard({
    required BuildContext context,
    required String nom,
    required String message,
    required String date,
    required IconData avatar,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.indigo.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo.shade100,
                  child: Icon(avatar, color: Colors.indigo),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nom,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
