import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  const BookItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            width: 170.sp,
            height: 250.sp,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: borderRadius(),
            ),
            child: Image.asset(
              'assets/images/كتاب.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const H(h: 6),

          /// book name
          SizedBox(
            width: 170.sp,
            child: Text(
              'مئة عام من العزلة',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// writer name
          SizedBox(
            width: 170.sp,
            child: Text(
              'غابرييل غارسيا ماركيز',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF969697),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
