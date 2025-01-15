import 'package:biblio/services/fetch_user_image.dart';
import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/width.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeBookItem extends StatefulWidget {
  const HomeBookItem({
    required this.book,
    super.key,
  });

  final Map<String, dynamic> book;

  @override
  State<HomeBookItem> createState() => _HomeBookItemState();
}

class _HomeBookItemState extends State<HomeBookItem> {
  final userImage = Supabase.instance.client
      .from('users')
      .select('image')
      .eq('id', Supabase.instance.client.auth.currentUser!.id)
      .toString();

  final userName = Supabase.instance.client
      .from('users')
      .select('username')
      .eq('id', Supabase.instance.client.auth.currentUser!.id)
      .toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(horizontal: 8.sp),
          width: 140.sp,
          height: 220.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 0.9.sp,
              fit: BoxFit.none,

              /// Book Cover
              image: NetworkImage(
                widget.book['cover_image_url'].toString(),
              ),
            ),
            borderRadius: BorderRadius.circular(20.sp),
            color: const Color(0xFFF7F7F7),
          ),

          /// Label of user
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                width: 100.sp,
                height: 24.sp,
                child: Row(
                  children: [
                    const W(w: 3),

                    /// User image
                    CircleAvatar(
                      backgroundColor: kTextShadowColor,
                      radius: 10.sp,
                      child: FutureBuilder<String?>(
                        future: getUserPhoto(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: AppIndicator(
                                size: 10.sp,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Icon(
                              Icons.account_circle,
                              size: 10.sp,
                              color: kScaffoldBackgroundColor,
                            );
                          }
                          final photoUrl = snapshot.data;
                          if (photoUrl == null || photoUrl.isEmpty) {
                            return Icon(
                              Icons.account_circle,
                              size: 10.sp,
                              color: kScaffoldBackgroundColor,
                            );
                          }
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(320),
                            ),
                            child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, progress) => AppIndicator(
                                size: 10.sp,
                              ),
                              imageUrl: photoUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    const W(w: 3),

                    /// User Name
                    SizedBox(
                      width: 70.sp,
                      child: FutureBuilder<dynamic>(
                        future: fetchUserName(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const AppIndicator(
                              size: 10,
                            );
                          } else if (snapshot.hasError) {
                            return const Text('');
                            // خطأ: ${snapshot.error}
                          } else {
                            final userName = snapshot.data;
                            return Text(
                              userName.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFF3A3A3A),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// Book Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: SizedBox(
            width: 140.sp,
            child: Text(
              widget.book['title'].toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        /// Writter Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: SizedBox(
            width: 140.sp,
            child: Text(
              widget.book['author'].toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF969697),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
