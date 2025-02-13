import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/screens/chat/conversation_card.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomingRequests extends StatelessWidget {
  const IncomingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> fetchDate() async {
      await context.read<FetchUserConversationsCubit>().fetchUserConversations(
            context,
          );
    }

    return BlocConsumer<FetchUserConversationsCubit,
        FetchUserConversationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final fetchUserConCubit = context.read<FetchUserConversationsCubit>();
        return state is FetchUserConversationsLoading
            ? const AppIndicator()
            : fetchUserConCubit.conversations.isEmpty
                ? RefreshIndicator(
                    strokeWidth: 0.9,
                    color: kMainColor,
                    onRefresh: fetchDate,
                    child: CustomFadeInUp(
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
                    ),
                  )
                : state is FetchUserConversationsLoading
                    ? const AppIndicator()
                    : RefreshIndicator(
                        strokeWidth: 0.9,
                        color: kMainColor,
                        onRefresh: fetchDate,
                        child: ListView.builder(
                          itemCount: fetchUserConCubit.conversations.length,
                          itemBuilder: (context, index) {
                            final conversations =
                                fetchUserConCubit.conversations[index];

                            return MessageCard(
                              conversation: conversations,
                            );
                          },
                        ),
                      );
      },
    );
  }
}
