import 'package:biblio/cubit/messages/create_conversation_cubit/create_conversation_cubit.dart';
import 'package:biblio/cubit/messages/fetch_messages_cubit/fetch_messages_cubit.dart';
import 'package:biblio/cubit/messages/send_message_cubit/send_messages_cubit.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationRoom extends StatefulWidget {
  const ConversationRoom({
    required this.conversationId,
    required this.titleBook,
    super.key,
  });
  final String conversationId;
  final String titleBook;
  @override
  State<ConversationRoom> createState() => _ConversationRoomState();
}

class _ConversationRoomState extends State<ConversationRoom> {
  final supabase = Supabase.instance.client;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDate();
  }

  Future<void> fetchDate() async {
    await context
        .read<FetchMessagesCubit>()
        .fetchMessages(conversationId: widget.conversationId);
    if (message['user_id'] != null) {
      await context
          .read<FetchMessagesCubit>()
          .fetchUserName(userName: message['user_id'].toString());
    }
  }

  Map<String, dynamic> message = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchMessagesCubit, FetchMessagesState>(
      listener: (context, state) {
        if (state is FetchMessagesError) showSnackBar(context, state.message);
      },
      builder: (context, state) {
        context
            .read<FetchMessagesCubit>()
            .fetchMessages(conversationId: widget.conversationId);
        final cubit = context.read<FetchMessagesCubit>();
        return BlocConsumer<SendMessagesCubit, SendMessagesState>(
          listener: (context, state) {
            if (state is SendMessagesError) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            final sendMessageCubit = context.read<SendMessagesCubit>();
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100.sp,
                backgroundColor: kMainColor,
                title: Text(
                  'طلب كتاب ${widget.titleBook}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),

                /// Leading
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(320),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20.sp,
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
              body: state is CreateConversationLoading ||
                      state is FetchMessagesLoading ||
                      state is SendMessagesLoading
                  ? const AppIndicator()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: cubit.messages.length,
                      itemBuilder: (context, index) {
                        message = cubit.messages[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const H(h: 5),
                            if (message['user_id'] ==
                                supabase.auth.currentUser!.id)
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Text(
                                      cubit.name,
                                      style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Text(
                                      cubit.name,
                                      style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (message['user_id'] ==
                                supabase.auth.currentUser!.id)
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.sp),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.sp,
                                      vertical: 2.sp,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: kMainColor,
                                    ),
                                    child: Text(
                                      message['content'].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.sp),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 16.sp,
                                      vertical: 2.sp,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                      color: kLightBlue,
                                    ),
                                    child: Text(
                                      message['content'].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: kTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: border(),
                      focusedBorder: border(),
                      enabledBorder: border(),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      hintText: 'ارسل رسالة ...',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: kMainColor,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          if (_messageController.text.isEmpty) return;
                          sendMessageCubit.sendMessage(
                            content: _messageController.text,
                            conversationId: widget.conversationId,
                          );
                          cubit.fetchMessages(
                            conversationId: widget.conversationId,
                          );
                          _messageController.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
