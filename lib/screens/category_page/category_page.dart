import 'package:biblio/screens/book_item/widgets/book_item.dart';
import 'package:biblio/services/update_password.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    required this.category,
    super.key,
  });

  final String category;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await supabase
          .from('books')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .eq('category', widget.category)
          .order('title', ascending: true);

      if (response != null) {
        setState(() {
          books = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(context, 'هناك خطأ! $e.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kMainColor,
            size: 22.sp,
          ),
        ),
      ),
      body: isLoading
          ? const AppIndicator()
          : books.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/Reading glasses-cuate.svg',
                        height: 100.sp,
                      ),
                      Text(
                        'هذه الفئة فارغة! لم تتم إضافة كتب بعد',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.9,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return BookItem(
                        book: book,
                      );
                    },
                    itemCount: books.length,
                  ),
                ),
    );
  }
}
