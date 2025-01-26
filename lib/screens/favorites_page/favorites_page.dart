import 'package:biblio/animations/animate_do.dart';
import 'package:biblio/cubit/my_list/my_list_cubit.dart';
import 'package:biblio/screens/book_item/widgets/book_item.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyListCubit>().showMyFavoriteBooks();
  }

  /// دالة التحديث عند السحب
  Future<void> _refreshData() async {
    await context.read<MyListCubit>().showMyFavoriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyListCubit>();
    return BlocConsumer<MyListCubit, MyListState>(
      listener: (context, state) {
        if (state is MyListError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          strokeWidth: 0.9,
          color: kMainColor,
          onRefresh: _refreshData,
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
            body: state is MyListLoading
                ? const AppIndicator()
                : context.read<MyListCubit>().supabase.auth.currentUser == null
                    ? Center(
                        child: CustomBorderBotton(
                          padding: 24,
                          text: 'تسجيل الدخول',
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, OnboardScreen.id);
                          },
                        ),
                      )
                    : cubit.books.isEmpty
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
                            itemCount: cubit.books.length,
                            itemBuilder: (context, index) {
                              final book = cubit.books[index];
                              return BookItem(
                                book: book,
                              );
                            },
                          ),
          ),
        );
      },
    );
  }
}
