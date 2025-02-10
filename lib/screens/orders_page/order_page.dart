import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/screens/orders_page/widgets/incoming_requests.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/login_user_not_found.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    context.read<FetchUserConversationsCubit>().fetchUserConversations();
  }

  Future<void> fetchDate() async {
    await context.read<FetchUserConversationsCubit>().fetchUserConversations();
  }

  @override
  Widget build(BuildContext context) {
    String? user;
    if (Supabase.instance.client.auth.currentUser?.id == null) {
      user = null;
    } else {
      user = Supabase.instance.client.auth.currentUser?.id;
    }
    return user == null
        ? const LoginUserNotFound()
        : BlocConsumer<FetchUserConversationsCubit,
            FetchUserConversationsState>(
            listener: (context, state) {},
            builder: (context, state) {
              final fetchUserConCubit =
                  context.read<FetchUserConversationsCubit>();
              return RefreshIndicator(
                strokeWidth: 0.9,
                color: kMainColor,
                onRefresh: fetchDate,
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 80.sp,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: kMainColor,
                    title: Text(
                      'طلبات الكتب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  body: state is FetchUserConversationsLoading
                      ? const AppIndicator()
                      : IncomingRequests(
                          conversation: fetchUserConCubit.conversations,
                        ),
                ),
              );
            },
          );
  }
}
