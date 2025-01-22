import 'package:biblio/screens/book_item/edit_my_book.dart';
import 'package:biblio/screens/home_page/widgets/title_header_home.dart';
import 'package:biblio/screens/my_lib_page/widgets/favorate_button.dart';
import 'package:biblio/screens/orders_page/order_the_book_page.dart';
import 'package:biblio/services/fetch_email.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/border_radius.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ShowBookItem extends StatefulWidget {
  const ShowBookItem({required this.book, super.key});
  final Map<String, dynamic> book;

  @override
  State<ShowBookItem> createState() => _ShowBookItemState();
}

class _ShowBookItemState extends State<ShowBookItem> {
  bool? isFavorite;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchUserId();
  }

  String? _user;
  Future<void> fetchUserId() async {
    try {
      /// الحصول على المستخدم الحالي
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('المستخدم غير مسجل الدخول.');
      }

      if (mounted) {
        setState(() {
          _user = user.id;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String getTimeDifference() {
    final now = DateTime.now();

    final specificDate = widget.book['created_at'];
    final createdAt = DateTime.parse(specificDate.toString());
    final difference = now.difference(createdAt);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} يوم';
    } else {
      return DateFormat('yyyy-MM-dd').format(createdAt); // تاريخ واضح
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.book['id'];
    final images = <String>[
      widget.book['cover_image_url'].toString(),
      widget.book['cover_book_url2'].toString(),
    ];
    setState(() {
      isLoading = false;
    });
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const AppIndicator(),
      child: Scaffold(
        appBar: AppBar(
          /// Action
          actions: [
            /// Edit button
            if (_user == null)
              const SizedBox()
            else if (widget.book['user_id'] == _user)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      EditBook.id,
                      arguments: {'bookId': id},
                    );
                  },
                  icon: const Icon(Icons.mode_edit_outline_outlined),
                ),
              )
            else if (widget.book['user_id'] != _user)

              /// Favorite button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: FavoriteButton(
                  bookId: id.toString(),
                ),
              )
            else
              const SizedBox(),
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
                        Icons.broken_image_outlined,
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
                    text: widget.book['title'].toString(),
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
                  child: widget.book['offer_type'].toString() == 'للبيع'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5.sp,
                          children: [
                            Icon(
                              Icons.sell,
                              size: 12.sp,
                            ),
                            Text(
                              widget.book['offer_type'].toString(),
                              style: TextStyle(
                                color: kMainColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.30,
                              ),
                            ),
                          ],
                        )
                      : widget.book['offer_type'] == 'للتبرع'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 5.sp,
                              children: [
                                Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 12.sp,
                                ),
                                Text(
                                  widget.book['offer_type'].toString(),
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.30,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 5.sp,
                              children: [
                                Icon(
                                  Icons.sync_outlined,
                                  size: 12.sp,
                                ),
                                Text(
                                  widget.book['offer_type'].toString(),
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.30,
                                  ),
                                ),
                              ],
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
                  widget.book['description'].toString(),
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
                  'المؤلف: ${widget.book['author']}',
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
                  'التصنيف: ${widget.book['category']}',
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
                    child: widget.book['user_image'] == null ||
                            widget.book['user_image'].toString().isEmpty
                        ? Icon(
                            Icons.account_circle,
                            size: 30.sp,
                            color: kScaffoldBackgroundColor,
                          )
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
                              imageUrl: widget.book['user_image'].toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(
                    child: Text(
                      widget.book['user_name'].toString(),
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
                  'تم النشر منذ ${getTimeDifference()}',
                  style: TextStyle(
                    color: const Color(0xFFA2A2A2),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16.sp,
            //     vertical: 5.sp,
            //   ),
            //   child: SizedBox(
            //     child: Text(
            //       'انضم للمكتبة منذ  أيام.',
            //       style: TextStyle(
            //         color: const Color(0xFFA2A2A2),
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 16.sp,
            //     vertical: 5.sp,
            //   ),
            //   child: SizedBox(
            //     child: Text(
            //       'عدد الكتب: 2',
            //       textAlign: TextAlign.right,
            //       style: TextStyle(
            //         color: const Color(0xFFA2A2A2),
            //         fontSize: 14.sp,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: _user == null || widget.book['user_id'] == _user
            ? const SizedBox()
            : widget.book['user_id'] != _user
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 8.sp,
                    ),
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderTheBookPage.id,
                          arguments: {'book_id': id},
                        );
                      },
                      text: 'طلب الكتاب',
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }
}
