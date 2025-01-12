import 'package:biblio/screens/navigation_bar/pages/home_page/models/book_model.dart';
import 'package:biblio/utils/components/width.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    required this.book,
    super.key,
  });
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(horizontal: 8.sp),
          width: 140.sp,
          height: 220.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 0.9,
              fit: BoxFit.none,

              /// Book Cover
              image: AssetImage(
                book.bookImage,
              ),
            ),
            borderRadius: BorderRadius.circular(20.sp),
            color: const Color(0xFFF7F7F7),
          ),

          /// Label of user
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                width: 100.sp,
                height: 24.sp,
                child: Row(
                  children: [
                    const W(w: 3),

                    /// User image
                    CircleAvatar(
                      backgroundColor: kMainColor,
                      radius: 10.sp,
                      child: Image.asset(
                        book.userImage,
                      ),
                    ),
                    const W(w: 3),

                    /// User Name
                    SizedBox(
                      width: 70.sp,
                      child: Text(
                        book.userName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF3A3A3A),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// Book Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: SizedBox(
            width: 140.sp,
            child: Text(
              book.bookName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        /// Writter Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: SizedBox(
            width: 140.sp,
            child: Text(
              book.writerName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF969697),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
