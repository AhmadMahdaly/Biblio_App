import 'package:biblio/cubit/books/fetch_located_books_cubit/fetch_located_books_cubit.dart';
import 'package:biblio/screens/category_page/widgets/category_listview.dart';
import 'package:biblio/screens/category_page/widgets/see_all.dart';
import 'package:biblio/screens/home_page/widgets/home_banner.dart';
import 'package:biblio/screens/home_page/widgets/new_books_listview.dart';
import 'package:biblio/screens/home_page/widgets/search_textfield.dart';
import 'package:biblio/screens/home_page/widgets/title_header_home.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/width.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'HomePage';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            /// Search bar
            SliverAppBar(
              toolbarHeight: 80.sp,
              automaticallyImplyLeading: false,
              title: const Column(
                children: [
                  H(h: 10),
                  SearchTextfield(),
                ],
              ),
            ),

            /// Home Banner
            const SliverToBoxAdapter(
              child: HomeBanner(),
            ),

            /// Books Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Row(
                  children: [
                    const TitleHeaderHome(
                      text: 'فئات الكتب',
                    ),
                    const Spacer(),
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
                        'عرض الكل',
                        style: TextStyle(
                          color: const Color(0xFFA4CFC3),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFFA4CFC3),
                        ),
                      ),
                    ),
                    const W(w: 16),
                  ],
                ),
              ),
            ),

            /// Categories ListView
            SliverToBoxAdapter(
              child: SizedBox(
                height: 110.sp,
                width: 80.sp,
                child: const CategoryListview(),
              ),
            ),

            /// New books title
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16.sp,
                  left: 16.sp,
                  top: 16.sp,
                  bottom: 12.sp,
                ),
                child: Row(
                  spacing: 10.sp,
                  children: [
                    Text(
                      'أحدث الكتب',
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 18.5.sp,
                    ),
                  ],
                ),
              ),
            ),

            /// New Books ListView
            SliverToBoxAdapter(
              child: SizedBox(
                width: 140.sp,
                height: 280.sp,
                child: BlocProvider<FetchLocatedBooksCubit>(
                  create: (context) => FetchLocatedBooksCubit(),
                  child: const NewBooksListview(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: H(h: 16),
            ),
          ],
        ),
      ),
    );
  }
}
