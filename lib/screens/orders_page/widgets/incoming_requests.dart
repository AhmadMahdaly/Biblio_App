import 'package:biblio/screens/chat/conversation_card.dart';
import 'package:flutter/material.dart';

class IncomingRequests extends StatelessWidget {
  const IncomingRequests({required this.conversation, super.key});
  final List<Map<String, dynamic>> conversation;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversation.length,
      itemBuilder: (context, index) {
        final conversations = conversation[index];

        return MessageCard(
          conversation: conversations,
        );
      },
    );
  }
}
