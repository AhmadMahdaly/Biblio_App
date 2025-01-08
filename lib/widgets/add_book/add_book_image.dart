import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class AddBookImages extends StatelessWidget {
  const AddBookImages({
    this.image,
    super.key,
  });
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
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
      child: image == null
          ? const Icon(
              Icons.image_outlined,
              color: Color(0xff849090),
            )
          : Image.asset(
              image!,
              fit: BoxFit.cover,
            ),
    );
  }
}
