
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Biblio extends StatelessWidget {
  const Biblio({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(
        390,
        844,
      ),
      minTextAdapt: true,
      child: MaterialApp(
      
        home: Scaffold(),
      ),
    );
  }
}
