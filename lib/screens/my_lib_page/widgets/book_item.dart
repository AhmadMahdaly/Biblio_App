import 'package:biblio/screens/my_lib_page/widgets/show_book_item.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  const BookItem({required this.book, required this.books, super.key});

  final Map<String, dynamic> book;
  final int books;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowBookItem(
                    book: book,
                  ),
                ),
              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 170.sp,
              height: 250.sp,
              decoration: BoxDecoration(
                color: kDisableButtonColor,
                borderRadius: borderRadius(),
              ),
              child: Image.network(
                book['cover_image_url'].toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const H(h: 6),

          /// book name
          SizedBox(
            width: 170.sp,
            child: Text(
              book['title'].toString(),
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
              book['author'].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF969697),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
