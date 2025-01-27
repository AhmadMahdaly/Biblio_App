import 'package:biblio/cubit/books/fetch_located_books_cubit/fetch_located_books_cubit.dart';
import 'package:biblio/screens/book_item/book_page.dart';
import 'package:biblio/screens/category_page/widgets/see_all.dart';
import 'package:biblio/screens/home_page/widgets/show_book.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
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

class NoLocatedBooks extends StatelessWidget {
  const NoLocatedBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          spacing: 2.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحبًا! 🧡',
              //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
              style: TextStyle(
                color: kTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'لا توجد كتب في منطقتك حاليًا.',
              style: TextStyle(
                color: kTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  'جرب استكشاف ',
                  //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CategorySeeAll();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'الفئات المختلفة',
                    //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: kMainColor,
                    ),
                  ),
                ),
                Text(
                  ' لتجد ما يناسبك! 📚✨',
                  //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
