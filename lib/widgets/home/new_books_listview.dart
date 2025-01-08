import 'package:biblio/components/width.dart';
import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewBooksListview extends StatelessWidget {
  const NewBooksListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
          spacing: 4.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.symmetric(horizontal: 8.sp),
              width: 140.sp,
              height: 200.sp,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.none,

                  /// Book Cover
                  image: AssetImage(
                    'assets/images/book_exmp.png',
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
                        ),
                        const W(w: 3),

                        /// User Name
                        SizedBox(
                          width: 70.sp,
                          child: Text(
                            'منى محمد',
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
                  'الجنرال في متاهته',
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
                  'غابرييل غارسيا ماركيز',
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
      },
      itemCount: 6,
    );
  }
}
