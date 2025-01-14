import 'package:biblio/screens/navigation_bar/pages/my_lib_page/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddedLibrary extends StatelessWidget {
  const AddedLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          return const BookItem();
        },
        itemCount: 2,
      ),
    );
  }
}
