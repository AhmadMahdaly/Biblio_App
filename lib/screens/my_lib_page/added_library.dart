import 'package:biblio/screens/my_lib_page/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddedLibrary extends StatelessWidget {
  const AddedLibrary({required this.books, super.key});
  final List<Map<String, dynamic>> books;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.9,
          crossAxisSpacing: 10,
          // mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookItem(
            books: books.length,
            book: book,
          );
        },
        itemCount: books.length,
      ),
    );
  }
}
