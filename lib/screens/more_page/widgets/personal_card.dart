import 'package:biblio/screens/more_page/widgets/get_user_image.dart';
import 'package:biblio/screens/more_page/widgets/show_user_name.dart';
import 'package:biblio/screens/my_lib_page/my_library_page.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/width.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalCard extends StatelessWidget {
  const PersonalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(16.sp),
      width: MediaQuery.of(context).size.width,
      height: 170.sp,
      decoration: BoxDecoration(
        color: const Color(0xFFe8eaee),
        borderRadius: borderRadius(),
      ),
      child: Column(
        spacing: 10.sp,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          Row(
            children: [
              const W(w: 12),
              const SizedBox(
                child: Center(child: GetUserImage()),
              ),
              const W(w: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.sp),
                  Text(
                    'أهلـًا',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),

                  /// User name
                  const ShowUserName(),

                  // /// Email
                  // const ShowEmail(),
                ],
              ),
            ],
          ),

          Divider(
            thickness: 0.5.sp,
            height: 4.sp,
            indent: 12.sp,
            endIndent: 12.sp,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MyLibraryPage();
                  },
                ),
              );
            },
            child: Row(
              children: [
                /// Qty of Books
                Container(
                  width: 180.sp,
                  height: 35.sp,
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
                        'رف الكتب الخاص بك',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
