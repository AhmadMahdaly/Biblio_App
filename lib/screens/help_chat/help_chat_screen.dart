import 'package:biblio/cubit/messages/create_conversation_cubit/create_conversation_cubit.dart';
import 'package:biblio/cubit/messages/send_message_cubit/send_messages_cubit.dart';
import 'package:biblio/screens/help_chat/widgets/help_chat.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HelpChatScreen extends StatefulWidget {
  const HelpChatScreen({super.key});

  @override
  State<HelpChatScreen> createState() => _HelpChatScreenState();
}

class _HelpChatScreenState extends State<HelpChatScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  String name = '';
  String image = '';
  String email = '';
  String country = '';
  String city = '';
  Future<void> _fetchBooks() async {
    final supabase = Supabase.instance.client;

    final user = supabase.auth.currentUser;

    if (user != null) {
      final response = await supabase
          .from('users')
          .select('username, image, email, country, city')
          .eq('id', user.id)
          .maybeSingle();

      if (response != null) {
        setState(() {
          name = response['username'].toString();
          final userImage = response['image'];
          final useremail = response['email'];
          final userCountry = response['country'];
          final userCity = response['city'];
          // name = username.toString();
          image = userImage.toString();
          email = useremail.toString();
          country = userCountry.toString();
          city = userCity.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateConversationCubit, CreateConversationState>(
      listener: (context, state) {},
      builder: (context, state) {
        final createConCubit = context.read<CreateConversationCubit>();
        return BlocConsumer<SendMessagesCubit, SendMessagesState>(
          listener: (context, state) {},
          builder: (context, state) {
            final sendMsgCubit = context.read<SendMessagesCubit>();
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: kMainColor,
                toolbarHeight: 80.sp,
                title: Text(
                  'الدعم الفني',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 22.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              body: state is SendMessagesLoading ||
                      state is CreateConversationLoading
                  ? const AppIndicator()
                  : Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: ListView(
                        children: [
                          CustomTextformfield(
                            contentPadding: EdgeInsets.only(
                              bottom: 200.sp,
                              top: 8.sp,
                              left: 8.sp,
                              right: 8.sp,
                            ),
                            maxLines: 10,
                            controller: _messageController,
                            text: 'اكتب استفسارك أو مقترحاتك هنا ...',
                          ),
                          const H(h: 24),
                          CustomButton(
                            text: 'ابدأ استفسار',
                            onTap: () async {
                              try {
                                if (_messageController.text.isEmpty) return;
                                await createConCubit.createConversation(
                                  sender: 'الدعم الفني',
                                  receiver: name,
                                  otherId: dotenv.env['ADMIN'] ?? '',
                                  titleBook: 'شكوى',
                                  bookImg: image,
                                  bookId: 1.toString(),
                                );
                                await sendMsgCubit.sendMessage(
                                  content: _messageController.text,
                                  conversationId:
                                      createConCubit.conversationId.toString(),
                                );
                                _messageController.clear();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HelpChat(
                                      conversationId: createConCubit
                                          .conversationId
                                          .toString(),
                                    ),
                                  ),
                                );
                              } catch (e) {
                                showSnackBar(context, e.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
