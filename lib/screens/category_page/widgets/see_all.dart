import 'package:biblio/screens/category_page/category_page.dart';
import 'package:biblio/screens/category_page/widgets/category_item.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategorySeeAll extends StatefulWidget {
  const CategorySeeAll({super.key});

  @override
  State<CategorySeeAll> createState() => _CategorySeeAllState();
}

class _CategorySeeAllState extends State<CategorySeeAll> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

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
    } catch (e) {
      showSnackBar(context, 'هناك خطأ! $e.');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const AppIndicator()
          : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.9,
                crossAxisSpacing: 10,
                // mainAxisSpacing: 0,
              ),
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
            ),
    );
  }
}
