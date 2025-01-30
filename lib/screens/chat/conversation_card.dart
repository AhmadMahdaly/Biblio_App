import 'package:biblio/screens/chat/conversation_room.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    required this.conversation,
    super.key,
  });

  final Map<String, dynamic> conversation;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationRoom(
            conversationId: widget.conversation['conversation_id'].toString(),
            titleBook: widget.conversation['title_book'].toString(),
          ),
        ),
      ),
      child: Container(
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
            Container(
              height: 60.sp,
              width: 60.sp,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(320),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.conversation['book_image'].toString(),
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
              spacing: 10.sp,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const H(h: 6),
                SizedBox(
                  width: 200.sp,
                  child: Text(
                    'طلب كتاب: ${widget.conversation['title_book']}',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
