import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/screens/chat/conversation_card.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/Messages-pana.svg',
                    height: 100.sp,
                  ),
                  Text(
                    'لا توجد طلبات جديدة',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
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
