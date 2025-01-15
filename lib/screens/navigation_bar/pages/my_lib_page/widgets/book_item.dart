import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  const BookItem({required this.book, super.key});

  final Map<String, dynamic> book;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _showBookDetails(context, book);
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

  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book['title'].toString()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              book['cover_image_url'].toString(),
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text('Author: ${book['author']}'),
            Text('Category: ${book['category']}'),
            Text('Condition: ${book['condition']}'),
            Text('Offer Type: ${book['offer_type']}'),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(book['description'].toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
