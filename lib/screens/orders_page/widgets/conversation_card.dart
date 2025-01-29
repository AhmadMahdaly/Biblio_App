import 'package:biblio/cubit/messages/fetch_messages_cubit/fetch_messages_cubit.dart';
import 'package:biblio/screens/orders_page/widgets/conversation_room.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    required this.conversation,
    required this.conversationId,
    super.key,
  });

  final Map<String, dynamic> conversation;
  final String conversationId;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  void initState() {
    super.initState();
    context
        .read<FetchMessagesCubit>()
        .fetchMessages(conversationId: widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchMessagesCubit, FetchMessagesState>(
      listener: (context, state) {
        if (state is FetchMessagesError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        final fetchMessageCubit = context.read<FetchMessagesCubit>();
        return state is FetchMessagesLoading
            ? const AppIndicator()
            : InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationRoom(
                      conversationId: widget.conversationId,
                      titleBook: fetchMessageCubit.titleBook.toString(),
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
                        child: Image.network(
                          fetchMessageCubit.bookImg.toString(),
                          //   ['book_image'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        spacing: 10.sp,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200.sp,
                            child: Text(
                              'طلب كتاب: ${fetchMessageCubit.titleBook}',
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
                          // SizedBox(
                          //   width: 240.sp,
                          //   child: Text(
                          //     '${fetchMessageCubit.messages[''].toString()} ',
                          //     overflow: TextOverflow.ellipsis,
                          //     maxLines: 2,
                          //     style: TextStyle(
                          //       color: kTextColor,
                          //       fontSize: 12.sp,
                          //       fontWeight: FontWeight.w500,
                          //       height: 1.35,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // SizedBox(
                      //   child: Text(
                      //     message['created_at'].toString(),
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //       color: kTextColor,
                      //       fontSize: 12.sp,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
