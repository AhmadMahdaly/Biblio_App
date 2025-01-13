// الأسئلة الشائعة (FAQ) لتطبيق Biblio

import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqList = <Map<String, String>>[
      {
        'question': 'ما هو تطبيق Biblio؟',
        'answer':
            'Biblio هو تطبيق يهدف إلى تسهيل تبادل الكتب بين المستخدمين. يمكنك عرض الكتب التي ترغب في تبادلها أو إعارتها، والبحث عن كتب تناسب اهتماماتك.',
      },
      {
        'question': 'كيف يمكنني إنشاء حساب؟',
        'answer':
            'يمكنك إنشاء حساب بسهولة باستخدام بريدك الإلكتروني وكلمة المرور، أو التسجيل باستخدام حساب Google أو Facebook الخاص بك.',
      },
      {
        'question': 'كيف أضيف كتابًا إلى قائمة التبادل الخاصة بي؟',
        'answer':
            '1. افتح التطبيق وانتقل إلى قسم "كتبي".\n2. اضغط على زر "إضافة كتاب".\n3. أدخل تفاصيل الكتاب (العنوان، المؤلف، الحالة، وصف قصير).\n4. أضف صورة غلاف الكتاب إن أمكن.\n5. اضغط على "حفظ"، وسيتم عرض الكتاب في قائمتك.',
      },
      {
        'question': 'كيف أبحث عن كتب متاحة للتبادل؟',
        'answer':
            'استخدم شريط البحث في الصفحة الرئيسية للبحث عن كتاب أو مؤلف معين، أو استعرض المكتبة العامة لتصفح الكتب حسب الفئات.',
      },
      {
        'question': 'كيف أبدأ عملية تبادل الكتب؟',
        'answer':
            '1. عند العثور على كتاب يناسبك، اضغط على الكتاب لعرض تفاصيله.\n2. اختر خيار "طلب تبادل" أو "طلب إعارة".\n3. سيتم إرسال إشعار إلى مالك الكتاب، ويمكنكما الاتفاق على شروط التبادل عبر الرسائل.',
      },
      {
        'question': 'هل التبادل يتم داخل التطبيق فقط؟',
        'answer':
            'نعم، يمكنك بدء عملية التبادل داخل التطبيق، ولكن تفاصيل الشحن أو التسليم الشخصي تعتمد على الاتفاق بينك وبين المستخدم الآخر.',
      },
      {
        'question': 'هل يوجد رسوم لاستخدام التطبيق؟',
        'answer':
            'التطبيق مجاني للاستخدام الأساسي. قد تكون هناك رسوم رمزية إذا اخترت خدمات إضافية مثل التوصيل أو الاشتراك المميز.',
      },
      {
        'question': 'كيف أضمن أمان التبادل؟',
        'answer':
            'استخدم ميزة التقييمات والمراجعات للتحقق من موثوقية المستخدم. لا تشارك بياناتك الشخصية إلا عند الضرورة، والتزم بشروط التبادل المتفق عليها داخل التطبيق.',
      },
      {
        'question': 'ماذا أفعل إذا واجهت مشكلة مع مستخدم آخر؟',
        'answer':
            'إذا واجهت أي مشكلة، يمكنك الإبلاغ عن المستخدم من خلال ملفه الشخصي، أو التواصل مع فريق الدعم الفني عبر الإعدادات > الدعم الفني.',
      },
      {
        'question': 'هل يمكنني حذف حسابي؟',
        'answer':
            'نعم، يمكنك حذف حسابك في أي وقت من خلال الإعدادات > إدارة الحساب، ثم الضغط على "حذف الحساب". سيتم حذف جميع بياناتك بعد تأكيد العملية.',
      },
      {
        'question': 'هل يمكنني تعديل بيانات كتاب قمت بإضافته؟',
        'answer':
            'نعم، يمكنك تعديل أي كتاب مضاف من خلال الانتقال إلى "كتبي"، اختيار الكتاب، ثم الضغط على "تعديل".',
      },
      {
        'question': 'كيف أتواصل مع فريق الدعم الفني؟',
        'answer':
            'يمكنك التواصل معنا من خلال البريد الإلكتروني: support@biblioapp.com، أو استخدام ميزة الدردشة داخل التطبيق في قسم "الدعم الفني".',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          'الأسئلة الشائعة',
          style: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1,
            letterSpacing: 0.14,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            collapsedIconColor: kMainColor,
            iconColor: kMainColor,
            title: Text(
              faqList[index]['question']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  faqList[index]['answer']!,
                  style: const TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
