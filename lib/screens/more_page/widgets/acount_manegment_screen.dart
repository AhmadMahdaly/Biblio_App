import 'package:biblio/cubit/user/fetch_user_data/fetch_user_data_cubit.dart';
import 'package:biblio/screens/more_page/personal_info_settings.dart';
import 'package:biblio/screens/more_page/widgets/category_for_more.dart';
import 'package:biblio/screens/more_page/widgets/favorite_location_to_meet.dart';
import 'package:biblio/screens/select_your_location_screen.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcountManegmentScreen extends StatefulWidget {
  const AcountManegmentScreen({super.key});

  @override
  State<AcountManegmentScreen> createState() => _AcountManegmentScreenState();
}

class _AcountManegmentScreenState extends State<AcountManegmentScreen> {
  @override
  void initState() {
    super.initState();
    fetchDate();
  }

  Future<void> fetchDate() async {
    await context.read<FetchUserDataCubit>().fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          'إدارة الحساب',
          style: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.sp,
          ),
        ),
      ),
      body: Column(
        spacing: 12.sp,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryForMore(
            text: 'تعديل البيانات الشخصية',
            icon: Icons.mode_edit_outline_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const PersonalInfoSetting();
                  },
                ),
              );
            },
          ),
          CategoryForMore(
            text: 'تغيير الموقع الجغرافي للمشاركة',
            icon: Icons.location_searching_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SelectYourLocationScreen();
                  },
                ),
              );
            },
          ),
          CategoryForMore(
            text: 'أماكن اللقاء المفضلة',
            icon: Icons.location_on_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const FavoriteLocationToMeet();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
