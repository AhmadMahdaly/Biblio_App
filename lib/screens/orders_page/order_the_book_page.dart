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
import 'package:flutter_svg/flutter_svg.dart';

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
          .select('user_image')
          .eq('id', bookId)
          .single();
      final responsed = await supabase
          .from('books')
          .select('user_id')
          .eq('id', bookId)
          .single();

      setState(() {
        final title = response['title'];
        final bookUserId = responsed['user_id'];
        final userImg = responseBookImage['user_image'];
        titleBook = title.toString();
        bookUser = bookUserId.toString();
        bookImage = userImg.toString();
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
        if (state is SendMessagesSuccess) {
          showDialog<bool?>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kLightBlue,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const H(h: 12),
                  Text(
                    'تم إرسال طلبك',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/Messages-pana.svg',
                    height: 200,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'يمكنك متابعة الطلبات المُرسلة وانتظار الردود في الطلبات',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const H(h: 12),
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kLightBlue,
                      borderRadius: BorderRadius.circular(320.sp),
                      border: Border.all(
                        width: 3.sp,
                        color: kMainColor,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigationBarApp.id,
                        (route) => false,
                      ),
                      icon: Icon(
                        Icons.done,
                        color: kMainColor,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final sendMsgCubit = context.read<SendMessagesCubit>();
        return BlocConsumer<CreateConversationCubit, CreateConversationState>(
          listener: (context, state) {},
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
                            await createConCubit.createConversation(
                              otherId: bookUser,
                              titleBook: titleBook,
                              bookImg: bookImage,
                              context: context,
                            );
                            await sendMsgCubit.sendMessage(
                              content: _messageController.text,
                              conversationId:
                                  createConCubit.conversationId.toString(),
                            );
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
