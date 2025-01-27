import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// actions
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message_rounded,
                size: 28.sp,
                color: kMainColor,
              ),
            ),
          ),
        ],

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.sp,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                CircleAvatar(
                  radius: 80.sp,
                  backgroundColor: kLightBlue,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Text(
                    textAlign: TextAlign.center,
                    'الصورة\nالشخصية',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const H(h: 28),
            SizedBox(
              child: Text(
                'Ahmad Hazombol El-manfaloty',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 16.sp,
                    color: kMainColor,
                  ),

                  /// Location
                  Text(
                    ' مصر - القاهرة ',
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Text(
                'انضم للمكتبة منذ 9 أشهر',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(
              child: Text(
                'عدد الكتب: 3',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(
              child: Text(
                'أماكن اللقاء المفضلة: محطات المترو/مراكز التسوق',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
