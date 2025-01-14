import 'package:biblio/services/fetch_user_image.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetUserImage extends StatefulWidget {
  const GetUserImage({super.key});

  @override
  State<GetUserImage> createState() => _GetUserImageState();
}

class _GetUserImageState extends State<GetUserImage> {
  final int size = 32;
  final int indicatorSize = 10;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: kDisableButtonColor,
            radius: size / 2.sp,
            child: FutureBuilder<String?>(
              future: getUserPhoto(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: AppIndicator(
                      size: indicatorSize.sp,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                }
                final photoUrl = snapshot.data;
                if (photoUrl == null || photoUrl.isEmpty) {
                  return Icon(
                    Icons.account_circle,
                    size: size.sp,
                    color: kScaffoldBackgroundColor,
                  );
                }

                return Center(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(320),
                    ),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          AppIndicator(
                        size: indicatorSize.sp,
                      ),
                      imageUrl: photoUrl,
                      fit: BoxFit.cover,
                      width: size.sp,
                      height: size.sp,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
