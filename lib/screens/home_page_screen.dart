import 'package:biblio/components/height.dart';
import 'package:biblio/components/width.dart';
import 'package:biblio/screens/home/category_listview.dart';
import 'package:biblio/screens/home/home_banner.dart';
import 'package:biblio/screens/home/new_books_listview.dart';
import 'package:biblio/screens/home/search_textfield.dart';
import 'package:biblio/screens/home/title_header_home.dart';
import 'package:flutter/material.dart';
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
              child: Row(
                children: [
                  const TitleHeaderHome(
                    text: 'فئات الكتب',
                  ),
                  const Spacer(),
                  Text(
                    'عرض الكل',
                    style: TextStyle(
                      color: const Color(0xFFA4CFC3),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFA4CFC3),
                    ),
                  ),
                  const W(w: 16),
                ],
              ),
            ),

            /// Categories ListView
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.sp,
                width: 80.sp,
                child: const CategoryListview(),
              ),
            ),

            /// New books title
            SliverToBoxAdapter(
              child: Row(
                children: [
                  const TitleHeaderHome(
                    text: 'أحدث الكتب',
                  ),
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 18.5.sp,
                  ),
                ],
              ),
            ),

            /// New Books ListView
            SliverToBoxAdapter(
              child: SizedBox(
                width: 140.sp,
                height: 275.sp,
                child: const NewBooksListview(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
