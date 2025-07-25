import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HemoAssist', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings or perform an action
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Chatbot functionality is under development.',
          
        ),
      ),
    );
  }
}