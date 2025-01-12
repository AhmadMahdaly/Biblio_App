import 'package:biblio/screens/navigation_bar/pages/orders_page/models/message_model.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    required this.message,
    super.key,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 5.sp,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10.sp),
      ),
      height: 72.sp,
      child: Row(
        spacing: 16.sp,
        children: [
          CircleAvatar(
            radius: 30,
            child: Image.asset(
              message.image,
            ),
          ),
          Column(
            spacing: 10.sp,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.sp,
                child: Text(
                  'طلب كتاب: ${message.title}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.70,
                    letterSpacing: 0.10,
                  ),
                ),
              ),
              SizedBox(
                width: 250.sp,
                child: Text(
                  message.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
