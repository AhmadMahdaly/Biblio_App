import 'package:biblio/cubit/my_list/my_list_cubit.dart';
import 'package:biblio/screens/book_item/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesGridBooks extends StatelessWidget {
  const FavoritesGridBooks({
    required this.cubit,
    super.key,
  });

  final MyListCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.9,
        crossAxisSpacing: 10,
      ),
      itemCount: cubit.books.length,
      itemBuilder: (context, index) {
        final book = cubit.books[index];
        return BookItem(
          book: book,
        );
      },
    );
  }
}
