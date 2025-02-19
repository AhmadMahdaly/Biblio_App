// صفحة الشروط والأحكام لتطبيق Biblio

import 'package:biblio/utils/components/leading_icon.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final terms = <String>[
      '1. **قبول الشروط:** باستخدام تطبيق Booklink، فإنك توافق على الالتزام بجميع الشروط والأحكام المذكورة هنا.',
      '2. **استخدام التطبيق:** يجب استخدام التطبيق فقط للأغراض القانونية المتعلقة بتبادل الكتب وإعارتها.',
      '3. **حساب المستخدم:** المستخدم مسؤول عن الحفاظ على سرية بيانات تسجيل الدخول الخاصة به، ويجب الإبلاغ عن أي نشاط غير مصرح به.',
      '4. **محتوى المستخدم:** جميع المعلومات والصور المرفوعة بواسطة المستخدمين هي مسؤوليتهم الشخصية، ويجب ألا تنتهك حقوق الملكية الفكرية أو القوانين.',
      '5. **التبادل والإعارة:** التطبيق يسهل التفاعل بين المستخدمين ولكنه لا يتحمل أي مسؤولية قانونية عن التبادلات أو الإعارات.',
      '6. **الرسوم والخدمات الإضافية:** لا يحتوي التطبيق على خدمات مدفوعة، وسيتم توضيح الرسوم بوضوح قبل فرضها.',
      '7. **إنهاء الحساب:** يحتفظ التطبيق بالحق في تعليق أو إنهاء حساب أي مستخدم ينتهك هذه الشروط.',
      '8. **التحديثات:** قد يتم تعديل هذه الشروط من وقت لآخر، ويعتبر استمرار استخدامك للتطبيق موافقة على التعديلات.',
      '9. **الدعم الفني:** يتوفر فريق الدعم لمساعدتك في حال واجهت أي مشاكل في استخدام التطبيق.',
      '10. **إخلاء المسؤولية:** التطبيق غير مسؤول عن أي خسائر أو أضرار تنشأ عن استخدامه.',
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const LeadingIcon(),
        title: Text(
          'الشروط والأحكام',
          style: TextStyle(
            color: kTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 1.sp,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: terms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 8.sp,
            ),
            child: Card(
              color: const Color(0xFFFCFCFC),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Text(
                  terms[index],
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
