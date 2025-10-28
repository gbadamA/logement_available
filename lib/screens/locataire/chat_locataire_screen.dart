import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatLocataireScreen extends StatefulWidget {
  final String destinataire;

  const ChatLocataireScreen({super.key, required this.destinataire});

  @override
  State<ChatLocataireScreen> createState() => _ChatLocataireScreenState();
}

class _ChatLocataireScreenState extends State<ChatLocataireScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {'from': 'locataire', 'text': 'Bonjour, tu es gentil.'},
    {'from': 'proprietaire', 'text': 'je sais.'},
  ];

  void _envoyerMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'from': 'locataire', 'text': text});
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
                final isMe = msg['from'] == 'locataire';
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
