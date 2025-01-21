import 'package:biblio/screens/category_page/category_page.dart';
import 'package:biblio/screens/category_page/widgets/category_item.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryListview extends StatefulWidget {
  const CategoryListview({super.key});

  @override
  State<CategoryListview> createState() => _CategoryListviewState();
}

class _CategoryListviewState extends State<CategoryListview> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    try {
      final response = await supabase
          .from('categories')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .order('created_at', ascending: true);
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
        // $e

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const AppIndicator()
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final book = books[index];
              return CategoryItem(
                title: book['name'].toString(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryPage(category: book['name'].toString()),
                    ),
                  );
                },
                icon: book['icon'].toString(),
              );
            },
            itemCount: books.length,
          );
  }
}
