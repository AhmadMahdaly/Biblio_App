import 'package:flutter/material.dart';

class SubmittedRequests extends StatefulWidget {
  const SubmittedRequests({super.key});

  @override
  State<SubmittedRequests> createState() => _SubmittedRequestsState();
}

class _SubmittedRequestsState extends State<SubmittedRequests> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return; //MessageCard(message: message);
      },
    );
  }
}
