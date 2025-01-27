import 'package:biblio/cubit/books/fetch_located_books_cubit/fetch_located_books_cubit.dart';
import 'package:biblio/screens/book_item/book_page.dart';
import 'package:biblio/screens/home_page/widgets/no_located_books.dart';
import 'package:biblio/screens/home_page/widgets/show_book.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewBooksListview extends StatefulWidget {
  const NewBooksListview({super.key});

  @override
  State<NewBooksListview> createState() => _NewBooksListviewState();
}

class _NewBooksListviewState extends State<NewBooksListview> {
  @override
  void initState() {
    super.initState();
    context.read<FetchLocatedBooksCubit>().fetchLocatedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchLocatedBooksCubit, FetchLocatedBooksState>(
      listener: (context, state) {
        if (state is FetchLocatedBooksError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<FetchLocatedBooksCubit>();
        return state is FetchLocatedBooksLoading
            ? const AppIndicator()
            : cubit.books.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final book = cubit.books[index];
                      return InkWell(
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
                        child: ShowBook(
                          book: book,
                        ),
                      );
                    },
                    itemCount: cubit.books.length,
                  )
                : const NoLocatedBooks();
      },
    );
  }
}
