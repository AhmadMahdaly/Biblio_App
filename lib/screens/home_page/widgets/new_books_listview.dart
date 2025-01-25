import 'package:biblio/screens/book_item/book_page.dart';
import 'package:biblio/screens/home_page/widgets/show_book.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewBooksListview extends StatefulWidget {
  const NewBooksListview({super.key});
  @override
  State<NewBooksListview> createState() => _NewBooksListviewState();
}

class _NewBooksListviewState extends State<NewBooksListview> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {
      final response = await supabase
          .from('books')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .order('created_at', ascending: false);
      if (mounted) {
        setState(() {
          books = List<Map<String, dynamic>>.from(response);
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        // showSnackBar(context, ' $e هناك خطأ! حاول مرة أخرى.');

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return books == null || books.isEmpty
        ? const AppIndicator()
        : ModalProgressHUD(
            color: kScaffoldBackgroundColor,
            progressIndicator: const AppIndicator(),
            inAsyncCall: isLoading,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final book = books[index];
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
              itemCount: books.length,
            ),
          );
  }
}
