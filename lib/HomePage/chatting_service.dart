import 'dart:async';
import 'dart:math';

class ChatGPTService {
  final List<String> _responses = [
    "Hello! How can I assist you today?",
    "I'm here to help you with any questions you have.",
    "Can you please provide more details?",
    "That's an interesting question!",
    "Let me think about that for a moment.",
    "I'm not sure about that. Can you ask something else?",
  ];

  Future<String> generateResponse() async {
    // Simulate a delay as if it's making a network request
    await Future.delayed(Duration(seconds: 2));

    // Randomly pick a response
    final randomIndex = Random().nextInt(_responses.length);
    return _responses[randomIndex];
  }
}
