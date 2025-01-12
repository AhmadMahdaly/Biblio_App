import 'package:biblio/screens/navigation_bar/pages/orders_page/models/message_model.dart';
import 'package:biblio/screens/navigation_bar/pages/orders_page/widgets/message_card.dart';
import 'package:flutter/material.dart';

class IncomingRequests extends StatefulWidget {
  const IncomingRequests({super.key});

  @override
  State<IncomingRequests> createState() => _IncomingRequestsState();
}

class _IncomingRequestsState extends State<IncomingRequests> {
  final MessageModel message = MessageModel(
    image: 'assets/icons/logo w text.png',
    title: 'كتاب الروح',
    message:
        'صباح الخير، أريد أن اتواصل بخصوص ثلاثة كتب كنت قد رأيتها مطولا لدى',
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return MessageCard(message: message);
      },
    );
  }
}
