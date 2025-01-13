import 'package:biblio/screens/navigation_bar/pages/more_page/personal_info_setting.dart';
import 'package:biblio/screens/navigation_bar/pages/more_page/widgets/get_user_image.dart';
import 'package:biblio/screens/navigation_bar/pages/more_page/widgets/show_email.dart';
import 'package:biblio/screens/navigation_bar/pages/more_page/widgets/show_user_name.dart';
import 'package:biblio/screens/navigation_bar/pages/more_page/widgets/sign_out_button.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreWithLogin extends StatelessWidget {
  const MoreWithLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Personal card

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16.sp),
            width: MediaQuery.of(context).size.width,
            height: 98,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: borderRadius(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.sp),

                      /// User Image
                      child: const GetUserImage(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.sp),

                        /// User name
                        const ShowUserName(),

                        /// Email
                        const ShowEmail(),
                      ],
                    ),
                    const Spacer(),

                    /// Setting
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PersonalInfoSetting();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        size: 16.sp,
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.5.sp,
                  height: 0,
                  indent: 12.sp,
                  endIndent: 12.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Qty of Books
                    Container(
                      width: 91,
                      height: 24,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        right: 12.sp,
                        left: 12.sp,
                      ),
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: borderRadius(),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5.sp,
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          Text(
                            '2 كتاب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 16.sp,
                          color: kMainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SignOutButton(),
        ],
      ),
    );
  }
}
