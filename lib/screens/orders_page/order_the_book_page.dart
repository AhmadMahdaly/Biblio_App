import 'dart:developer';

import 'package:biblio/cubit/messages/create_conversation_cubit/create_conversation_cubit.dart';
import 'package:biblio/cubit/messages/send_message_cubit/send_messages_cubit.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTheBookPage extends StatefulWidget {
  const OrderTheBookPage({super.key});
  static String id = 'OrderTheBookPage';

  @override
  State<OrderTheBookPage> createState() => _OrderTheBookPageState();
}

class _OrderTheBookPageState extends State<OrderTheBookPage> {
  final _messageController = TextEditingController();
  late int bookId = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
      setState(() {
        bookId = args['book_id'] as int;
        _fetchBooks(bookId);
      });
    });
  }

  String titleBook = '';
  String bookUser = '';
  String bookImage = '';
  String otherName = '';
  String uuser = '';
  Future<void> _fetchBooks(int bookId) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        ///
        return;
      }
      final response = await supabase
          .from('books')
          .select('title')
          .eq('id', bookId)
          .single();

      final responseBookImage = await supabase
          .from('books')
          .select('cover_image_url')
          .eq('id', bookId)
          .single();
      final responsed = await supabase
          .from('books')
          .select('user_id')
          .eq('id', bookId)
          .single();
      final responseee1 = await supabase
          .from('books')
          .select('user_name')
          .eq('id', bookId)
          .single();
      final senderResponse = await supabase
          .from('users')
          .select('username')
          .eq('id', user.id)
          .single();

      setState(() {
        final nameOther = responseee1['user_name'];
        final title = response['title'];
        final bookUserId = responsed['user_id'];
        final userImg = responseBookImage['cover_image_url'];
        final sender = senderResponse['username'];
        titleBook = title.toString();
        bookUser = bookUserId.toString();
        bookImage = userImg.toString();
        otherName = nameOther.toString();
        uuser = sender.toString();
      });
    } catch (e) {
      if (mounted) {
        //
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMessagesCubit, SendMessagesState>(
      listener: (context, state) {
        if (state is SendMessagesError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        final sendMsgCubit = context.read<SendMessagesCubit>();
        return BlocConsumer<CreateConversationCubit, CreateConversationState>(
          listener: (context, state) {
            if (state is CreateConversationError) {
              showSnackBar(context, state.message);
            }
            if (state is CreateConversationSeccess) {
              showSnackBar(context, 'تم ارسال الرسالة بنجاح');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationBarApp(),
                ),
              );
            }
          },
          builder: (context, state) {
            final createConCubit = context.read<CreateConversationCubit>();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'رسالة لطلب كتاب $titleBook',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.71.sp,
                  ),
                ),

                /// Leading
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context); // إزالة جميع الصفحات
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 22.sp,
                  ),
                ),
              ),
              body: state is CreateConversationLoading ||
                      state is SendMessagesLoading
                  ? const AppIndicator()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: ListView(
                        children: [
                          Text(
                            'اكتب رسالة قصيرة توضح طلبك',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.50.sp,
                            ),
                          ),
                          const H(h: 20),
                          CustomTextformfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ادخل البيانات المطلوبة';
                              }
                              return null;
                            },
                            maxLines: 100,
                            contentPadding: EdgeInsets.only(
                              bottom: 170.sp,
                              right: 12.sp,
                              left: 12.sp,
                              top: 12.sp,
                            ),
                            controller: _messageController,
                          ),
                        ],
                      ),
                    ),
              bottomNavigationBar: state is CreateConversationLoading ||
                      state is SendMessagesLoading
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: CustomButton(
                          onTap: () async {
                            try {
                              await createConCubit.createConversation(
                                sender: otherName,
                                receiver: uuser,
                                otherId: bookUser,
                                titleBook: titleBook,
                                bookImg: bookImage,
                                bookId: bookId.toString(),
                              );
                              await sendMsgCubit.sendMessage(
                                content: _messageController.text,
                                conversationId:
                                    createConCubit.conversationId.toString(),
                              );
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          text: 'إرسال',
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
