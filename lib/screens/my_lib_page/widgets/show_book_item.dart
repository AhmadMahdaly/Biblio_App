import 'package:biblio/screens/home_page/widgets/title_header_home.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowBookItem extends StatelessWidget {
  const ShowBookItem({required this.book, super.key});
  final Map<String, dynamic> book;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final specificDate = book['created_at'];
    final createdAt = DateTime.parse(specificDate.toString());
    final difference = now.difference(createdAt).inDays;

    final images = <String>[
      book['cover_image_url'].toString(),
      book['cover_image_urlI']?.toString() ??
          book['cover_image_url'].toString(),
      book['cover_image_urlII']?.toString() ??
          book['cover_image_url'].toString(),
    ];
    return Scaffold(
      appBar: AppBar(
        /// Action
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mode_edit_outline_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_outline),
          ),
        ],

        /// Leading
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // إزالة جميع الصفحات
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 22.sp,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: 220.sp,
            height: 305.sp,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: borderRadius(),
            ),
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (
                BuildContext context,
                int index,
                int pageViewIndex,
              ) =>
                  Container(
                width: 220.sp,
                height: 305.sp,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: borderRadius(),
                ),
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  // width: double.infinity,
                  placeholder: (context, url) {
                    return const AppIndicator();
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(
                      Icons.error_outline,
                    );
                  },
                ),
              ),
              options: CarouselOptions(
                height: double.infinity,
                enlargeCenterPage: true,
              ),
            ),
          ),
          const H(h: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 270.sp,
                child: TitleHeaderHome(
                  text: book['title'].toString(),
                ),
              ),
              Container(
                width: 80,
                height: 26,
                margin: EdgeInsets.symmetric(horizontal: 16.sp),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF0F6FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 16.sp,
                  color: kMainColor,
                ),

                ///
                ////// Location
                Text(
                  'مصر، القاهرة',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: SizedBox(
              width: 351.sp,
              child: Text(
                book['description'].toString(),
                style: TextStyle(
                  color: const Color(0xFF686868),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.85,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: SizedBox(
              width: 351.sp,
              child: Text(
                'المؤلف: ${book['author']}',
                style: TextStyle(
                  color: const Color(0xFFA2A2A2),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: SizedBox(
              width: 351.sp,
              child: Text(
                'التصنيف: ${book['category']}',
                style: TextStyle(
                  color: const Color(0xFFA2A2A2),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const H(h: 16),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: Row(
              spacing: 5.sp,
              children: [
                CircleAvatar(
                  backgroundColor: kTextShadowColor,
                  radius: 16.sp,
                  child: book['user_image'] == null
                      ? const SizedBox()
                      : Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(320),
                          ),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => AppIndicator(
                              size: 10.sp,
                            ),
                            imageUrl: book['user_image'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                SizedBox(
                  child: Text(
                    book['user_name'].toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: kTextColor,
                      height: 0.71,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: SizedBox(
              child: Text(
                'انضم للمكتبة منذ $difference أيام.',
                style: TextStyle(
                  color: const Color(0xFFA2A2A2),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 5.sp,
            ),
            child: SizedBox(
              child: Text(
                'عدد الكتب: 2',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFFA2A2A2),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 8.sp,
        ),
        child: const CustomButton(text: 'طلب الكتاب'),
      ),
    );
  }
}
