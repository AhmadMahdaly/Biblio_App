import 'package:biblio/screens/orders_page/models/message_model.dart';
import 'package:biblio/screens/orders_page/widgets/message_card.dart';
import 'package:flutter/material.dart';

class SubmittedRequests extends StatefulWidget {
  const SubmittedRequests({super.key});

  @override
  State<SubmittedRequests> createState() => _SubmittedRequestsState();
}

class _SubmittedRequestsState extends State<SubmittedRequests> {
  final MessageModel message = MessageModel(
    image: 'assets/icons/logo w text.png',
    title: 'كتاب الروح',
    message:
        'صباح الخير، أريد أن اتواصل بخصوص ثلاثة كتب كنت قد رأيتها مطولا لدى',
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return MessageCard(message: message);
      },
    );
  }
}
