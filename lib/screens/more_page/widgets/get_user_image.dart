import 'package:biblio/services/fetch_user_image.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetUserImage extends StatelessWidget {
  const GetUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 80;
    const indicatorSize = 10;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.sp,
          height: size.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(320),
          ),
          child: FutureBuilder<String?>(
            future: getUserPhoto(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppIndicator(
                  size: indicatorSize.sp,
                );
              }
              if (snapshot.hasError) {
                return Text('حدث خطأ: ${snapshot.error}');
              }
              final photoUrl = snapshot.data;
              if (photoUrl == null || photoUrl.isEmpty) {
                return Icon(
                  Icons.account_circle,
                  size: 80.sp,
                  color: kMainColor,
                );
              }
              return CachedNetworkImage(
                errorWidget: (context, url, error) => AppIndicator(
                  size: 10.sp,
                ),
                progressIndicatorBuilder: (context, url, progress) =>
                    AppIndicator(
                  size: indicatorSize.sp,
                ),
                imageUrl: photoUrl,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ],
    );
  }
}
