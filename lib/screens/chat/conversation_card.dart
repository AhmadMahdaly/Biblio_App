import 'package:biblio/screens/chat/conversation_room.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    required this.conversation,
    super.key,
  });

  final Map<String, dynamic> conversation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationRoom(
            conversationId: conversation['conversation_id'].toString(),
            titleBook: conversation['title_book'].toString(),
            userName: conversation['sender'].toString(),
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          right: 16.sp,
          left: 16.sp,
          top: 16.sp,
        ),
        decoration: BoxDecoration(
          color: kLightBlue,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        height: 72.sp,
        child: Row(
          spacing: 16.sp,
          children: [
            Container(
              margin: EdgeInsets.all(8.sp),
              height: 60.sp,
              width: 60.sp,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(320),
              ),
              child: CachedNetworkImage(
                imageUrl: conversation['book_image'].toString(),
                fit: BoxFit.cover,
                height: 60.sp,
                width: 60.sp,
                errorListener: (_) => Container(
                  height: 60.sp,
                  width: 60.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kLightBlue,
                    borderRadius: BorderRadius.circular(320),
                  ),
                  child: Icon(
                    Icons.archive_outlined,
                    size: 24.sp,
                    color: kMainColor,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 60.sp,
                  width: 60.sp,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kLightBlue,
                    borderRadius: BorderRadius.circular(320),
                  ),
                  child: Icon(
                    Icons.archive_outlined,
                    size: 24.sp,
                    color: kMainColor,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.sp,
              children: [
                const H(h: 6),
                SizedBox(
                  child: Text(
                    '${conversation['sender']}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  child: Text(
                    'طلب كتاب: ${conversation['title_book']}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
