import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({
    super.key,
    this.size = 50,
  });
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        size: size.sp,
        color: kMainColor.withAlpha(25),
      ),
    );
  }
}
