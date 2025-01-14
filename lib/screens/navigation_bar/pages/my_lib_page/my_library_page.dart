import 'package:biblio/screens/navigation_bar/pages/my_lib_page/added_library.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
// import 'package:biblio/screens/navigation_bar/pages/my_lib_page/empty_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        /// Title
        title: Text(
          'مكتبتك',
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),

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
      body: const AddedLibrary(),
      //  const EmptyLibrary(),
    );
  }
}
