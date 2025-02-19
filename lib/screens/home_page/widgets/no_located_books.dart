import 'package:biblio/screens/category_page/widgets/see_all.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoLocatedBooks extends StatelessWidget {
  const NoLocatedBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          spacing: 4.sp,
          children: [
            Text(
              'لا توجد كتب في منطقتك حاليًا.',
              style: TextStyle(
                color: kTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TryToDiscoverCategory(),
          ],
        ),
      ),
    );
  }
}

class TryToDiscoverCategory extends StatelessWidget {
  const TryToDiscoverCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'يمكنك أن تجرب استكشاف ',
          //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
          style: TextStyle(
            color: kTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CategorySeeAll();
                },
              ),
            );
          },
          child: Text(
            'الفئات المختلفة',
            //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
            style: TextStyle(
              color: kTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: kMainColor,
            ),
          ),
        ),
        Text(
          ' لتجد ما يناسبك!',
          //  'مرحبًا! 🧡\nيبدو أنه لم يتم عرض أي كتب في منطقتك بعد.\nلكن لا تقلق، لديك فرصة لتكون الأول الذي يساهم في إثراء منطقتك بالكتب! 📚✨\nأو يمكنك استكشاف الفئات المختلفة لدينا؛ قد تجد ما تبحث عنه أو حتى ما لم يخطر ببالك! 🌟\nابدأ رحلتك الآن واجعل تجربتك مليئة بالاكتشافات.',
          style: TextStyle(
            color: kTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
