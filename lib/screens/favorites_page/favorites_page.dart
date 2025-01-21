import 'package:biblio/screens/my_lib_page/widgets/book_item.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    isLoading = true;
    _fetchBooks();
    fetchFavorites();

    super.initState();
  }

  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> books = [];
  bool isLoading = true;
  List<Map<String, dynamic>> favoriteBooks = [];
  Future<void> fetchFavorites() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        ///
        return;
      }

      final response = await supabase
          .from('favorites')
          .select('book_id')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      if (response != null) {
        setState(() {
          favoriteBooks = List<Map<String, dynamic>>.from(response);
          isLoading = false;
        });
      }
    } catch (e) {
      /// print('Error fetching favorites: $e');
    }
  }

  Future<void> _fetchBooks() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    setState(() {
      isLoading = true;
    });

    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        ///
        return;
      }
      final response = await supabase
          .from('books')
          // ignore: avoid_redundant_argument_values
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);
      if (mounted) {
        setState(() {
          books = List<Map<String, dynamic>>.from(response);
        });
      }
      setState(() {
        books = List<Map<String, dynamic>>.from(response);

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
    return books.isEmpty
        ? const AppIndicator()
        : ModalProgressHUD(
            progressIndicator: const AppIndicator(),
            inAsyncCall: isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'قائمة الكتب المفضلة',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.sp,
                  ),
                ),
              ),
              body:
                  //  favoriteBooks.isEmpty
                  // ? const Center(child: Text('No favorites added yet!')):
                  GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.9,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 0,
                ),
                itemCount: favoriteBooks.length,
                itemBuilder: (context, index) {
                  final favorite = favoriteBooks[index];
                  final book = books[index];
                  if (book['id'] == favorite['book_id']) {
                    return BookItem(
                      books: book.length,
                      book: book,
                    );
                  }
                  return null;
                },
              ),
            ),
          );
  }
}
