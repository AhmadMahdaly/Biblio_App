import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/screens/book_item/widgets/book_item.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = false;
  List<Map<String, dynamic>> books = [];
  @override
  void initState() {
    isLoading = true;
    fetchFavorites();
    fetchUserId();
    super.initState();
  }

  Map<String, dynamic>? bok;

  /// Fetch favorite books
  Future<void> fetchFavorites() async {
    final user = supabase.auth.currentUser!.id;
    if (user == null) {
      ///
      return;
    }
    try {
      /// جلب قائمة book_id من favorites
      final favoritesResponse = await supabase
          .from('favorites')
          .select('book_id')
          .eq('user_id', user);

      if (favoritesResponse != null) {
        final bookIds =
            List<int>.from(favoritesResponse.map((item) => item['book_id']));

        /// جلب تفاصيل الكتب بناءً على book_id
        final booksResponse = await supabase
            .from('books')
            // ignore: avoid_redundant_argument_values
            .select('*')
            .filter(
              'id',

              /// استخدام in لتحديد الكتب المطلوبة
              'in',
              bookIds,
            );
        setState(() {
          books = booksResponse;
        });
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Fetch User Id
  String? _user;
  Future<void> fetchUserId() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('المستخدم غير مسجل الدخول.');
      }
      if (mounted) {
        setState(() {
          _user = user.id;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// دالة التحديث عند السحب
  Future<void> _refreshData() async {
    await fetchFavorites();
    await fetchUserId();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      strokeWidth: 0.9,
      color: kMainColor,
      onRefresh: _refreshData,
      child: ModalProgressHUD(
        progressIndicator: const AppIndicator(),
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
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
          body: _user == null
              ? Center(
                  child: CustomBorderBotton(
                    padding: 24,
                    text: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, OnboardScreen.id);
                    },
                  ),
                )
              : books.isEmpty
                  ? CustomFadeInRight(
                      duration: 600,
                      child: Container(
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
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.9,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return BookItem(
                          book: book,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
