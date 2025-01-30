import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/screens/orders_page/widgets/incoming_requests.dart';
import 'package:biblio/screens/orders_page/widgets/submitted_requests.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPageWorking extends StatefulWidget {
  const OrderPageWorking({super.key});

  @override
  State<OrderPageWorking> createState() => _OrderPageWorkingState();
}

class _OrderPageWorkingState extends State<OrderPageWorking>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<FetchUserConversationsCubit>().fetchUserConversations();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchUserConversationsCubit,
        FetchUserConversationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final fetchUserConCubit = context.read<FetchUserConversationsCubit>();
        return state is FetchUserConversationsLoading
            ? const AppIndicator()
            : DefaultTabController(
                animationDuration: const Duration(milliseconds: 300),
                length: 2, // عدد العلامات التبويب
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 90.sp,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.all(16.sp),
                      title: TabBar(
                        automaticIndicatorColorAdjustment: false,
                        dividerHeight: 0,
                        indicatorColor: kTextColor,
                        labelColor: Colors.white,
                        unselectedLabelColor: kTextColor,
                        labelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Avenir Arabic',
                          fontWeight: FontWeight.w700,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Avenir Arabic',
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorAnimation: TabIndicatorAnimation.elastic,
                        onTap: (index) {
                          setState(() {});
                        },
                        indicator: BoxDecoration(
                          color: kMainColor,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabAlignment: TabAlignment.fill,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            child: Text(
                              'الطلبات الواردة',
                            ),
                          ),
                          Tab(
                            child: Text(
                              'الطلبات المرسلة',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      IncomingRequests(
                        conversation: fetchUserConCubit.conversations,
                      ),
                      const SubmittedRequests(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
