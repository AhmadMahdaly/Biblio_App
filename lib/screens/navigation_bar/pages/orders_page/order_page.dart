import 'package:biblio/screens/navigation_bar/pages/orders_page/incoming_requests.dart';
import 'package:biblio/screens/navigation_bar/pages/orders_page/submitted_requests.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _tabs = [
    const IncomingRequests(),
    const SubmittedRequests(),
  ];
  @override
  void initState() {
    super.initState();
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
    return DefaultTabController(
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
          children: _tabs,
        ),
      ),
    );
  }
}
