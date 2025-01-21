import 'package:biblio/screens/book_item/widgets/book_item.dart';
import 'package:biblio/services/update_password.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: AppBar(),
      body: isLoading
          ? const AppIndicator()
          : books.isEmpty
              ? const Center(child: Text('No books found for this category'))
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
                        books: book.length,
                        book: book,
                      );
                    },
                    itemCount: books.length,
                  ),
                ),
    );
  }
}
