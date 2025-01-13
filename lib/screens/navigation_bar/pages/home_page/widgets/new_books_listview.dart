import 'package:biblio/screens/navigation_bar/pages/home_page/models/book_model.dart';
import 'package:biblio/screens/navigation_bar/pages/home_page/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewBooksListview extends StatefulWidget {
  const NewBooksListview({super.key});

  @override
  State<NewBooksListview> createState() => _NewBooksListviewState();
}

class _NewBooksListviewState extends State<NewBooksListview> {
  final BookModel book = BookModel(
    page: const SizedBox(),
    bookImage: 'assets/images/book_exmp.png',
    userName: 'منى محمد',
    bookName: 'الجنرال في متاهته',
    writerName: 'غابرييل غارسيا ماركيز',
    userImage: 'assets/icons/logo.png',
  );
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return BookItem(
          book: book,
        );
      },
      itemCount: 6,
    );
  }
}
