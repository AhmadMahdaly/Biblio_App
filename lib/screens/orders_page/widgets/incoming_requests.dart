import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/screens/chat/conversation_card.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomingRequests extends StatelessWidget {
  const IncomingRequests({required this.conversation, super.key});
  final List<Map<String, dynamic>> conversation;

  @override
  Widget build(BuildContext context) {
    return conversation.isEmpty
        ? CustomFadeInUp(
            duration: 300,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                spacing: 10.sp,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 46.sp,
                    color: kBorderColor,
                  ),
                  Text(
                    'لا توجد طلبات جديدة',
                    style: TextStyle(
                      color: kTextShadowColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
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
