import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/screens/orders_page/widgets/incoming_requests.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchUserConversationsCubit,
            FetchUserConversationsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final fetchUserConCubit = context.read<FetchUserConversationsCubit>();
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80.sp,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: kMainColor,
              title: Text(
                'طلبات الكتب',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.sp,
                ),
              ),
            ),
            body: state is FetchUserConversationsLoading
                ? const AppIndicator()
                : IncomingRequests(
                    conversation: fetchUserConCubit.conversations,
                  ),
          );
        });
  }
}
