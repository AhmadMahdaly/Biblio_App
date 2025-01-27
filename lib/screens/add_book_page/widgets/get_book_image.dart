import 'package:biblio/services/get_books_image.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class GetBookImage extends StatefulWidget {
  const GetBookImage({
    required this.id,
    required this.onTap,
    super.key,
  });
  final int id;

  final void Function()? onTap;
  @override
  State<GetBookImage> createState() => _GetBookImageState();
}

class _GetBookImageState extends State<GetBookImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 72,
        height: 72,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFECECEC),
          border: const DashedBorder.fromBorderSide(
            dashLength: 3,
            side: BorderSide(
              color: Color(0xFFB0BEBF),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        ),
        child: FutureBuilder<String?>(
          future: getBooksPhoto(
            context,
            widget.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: AppIndicator(
                  size: 10.sp,
                ),
              );
            }
            if (snapshot.hasError) {
              // return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }
            final photoUrl = snapshot.data;

            return Center(
              child: Container(
                width: 72,
                height: 72,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      AppIndicator(
                    size: 10.sp,
                  ),
                  imageUrl: photoUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GetBookImageI extends StatefulWidget {
  const GetBookImageI({
    required this.id,
    required this.onTap,
    super.key,
  });
  final int id;

  final void Function()? onTap;
  @override
  State<GetBookImageI> createState() => _GetBookImageIState();
}

class _GetBookImageIState extends State<GetBookImageI> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 72,
        height: 72,
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFECECEC),
          border: const DashedBorder.fromBorderSide(
            dashLength: 3,
            side: BorderSide(
              color: Color(0xFFB0BEBF),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
        ),
        child: FutureBuilder<String?>(
          future: getBooksPhotoI(
            context,
            widget.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: AppIndicator(
                  size: 10.sp,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }
            final photoUrl = snapshot.data;

            return Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      AppIndicator(
                    size: 10.sp,
                  ),
                  imageUrl: photoUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
