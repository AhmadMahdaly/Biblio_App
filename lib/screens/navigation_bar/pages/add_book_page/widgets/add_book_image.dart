import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class AddBookImages extends StatefulWidget {
  const AddBookImages({
    this.image,
    super.key,
    this.onTap,
  });
  final File? image;
  final void Function()? onTap;

  @override
  State<AddBookImages> createState() => _AddBookImagesState();
}

class _AddBookImagesState extends State<AddBookImages> {
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
        child: widget.image == null
            ? const Icon(
                Icons.image_outlined,
                color: Color(0xff849090),
              )
            : Image.file(
                widget.image!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
