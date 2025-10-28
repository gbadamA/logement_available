import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatProprietaireScreen extends StatefulWidget {
  final String destinataire;

  const ChatProprietaireScreen({super.key, required this.destinataire});

  @override
  State<ChatProprietaireScreen> createState() => _ChatProprietaireScreenState();
}

class _ChatProprietaireScreenState extends State<ChatProprietaireScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {'from': 'proprietaire', 'text': 'Bonjour ${DateTime.now().year}, reçu la quittance ?'},
    {'from': 'locataire', 'text': 'Oui merci, tout est en ordre.'},
  ];

  void _envoyerMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'from': 'proprietaire', 'text': text});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Discussion avec ${widget.destinataire}', style: textTheme.titleLarge),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['from'] == 'proprietaire';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.indigo.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Text(
                      msg['text'],
                      style: GoogleFonts.manrope(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Écrire un message...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    style: GoogleFonts.manrope(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigo),
                  onPressed: _envoyerMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
