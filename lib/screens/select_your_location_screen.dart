import 'package:biblio/cubit/user/cubit/save_user_location_cubit.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectYourLocationScreen extends StatefulWidget {
  const SelectYourLocationScreen({super.key});

  @override
  State<SelectYourLocationScreen> createState() =>
      _SelectYourLocationScreenState();
}

class _SelectYourLocationScreenState extends State<SelectYourLocationScreen> {
  bool isActive = false;

  final List<String> countries = ['مصر', 'السعودية'];
  // قائمة الدول
  final Map<String, List<String>> cities = {
    'مصر': [
      'القاهرة',
      'الأسكندرية',
      'الجيزة',
      'بورسعيد',
      'السويس',
      'المنصورة',
      'الزقازيق',
      'طنطا',
      'دمنهور',
      'الفيوم',
      'أسيوط',
      'سوهاج',
      'المنيا',
      'الأقصر',
      'أسوان',
      'قنا',
      'الإسماعيلية',
      'دمياط',
      'بني سويف',
      'مطروح',
      'الغردقة',
      'شرم الشيخ',
    ],
    'السعودية': [
      'الرياض',
      'جدة',
      'مكة المكرمة',
      'المدينة المنورة',
      'الدمام',
      'الخبر',
      'الطائف',
      'بريدة',
      'أبها',
      'خميس مشيط',
      'نجران',
      'حائل',
      'تبوك',
      'جيزان',
      'القطيف',
      'ينبع',
      'العلا',
      'عرعر',
      'سكاكا',
      'الأحساء',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveUserLocationCubit>();
    return BlocConsumer<SaveUserLocationCubit, SaveUserLocationState>(
      listener: (context, state) {
        if (state is SaveUserLocationError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: state is SaveUserLocationLoading
              ? const AppIndicator()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Column(
                    spacing: 12.sp,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 6.sp,

                        /// Header
                        children: [
                          Text(
                            'أين تود مشاركة كتبك؟',
                            style: TextStyle(
                              color: kMainColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svg/books.svg',
                            height: 24.sp,
                          ),
                        ],
                      ),
                      Text(
                        'من فضلك اختار الدولة والمدينة التي تود مشاركة الكتب بها',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const H(h: 5),

                      /// Country
                      Text(
                        'الدولة',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'اختار الدولة',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: kHeader1Color,
                          ),
                        ),
                        items: countries.map((country) {
                          return DropdownMenuItem(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        value: cubit.selectedCountry,
                        onChanged: (value) {
                          setState(() {
                            cubit
                              ..selectedCountry = value
                              ..selectedCity =
                                  null; // إعادة ضبط المدينة عند تغيير الدولة
                          });
                        },
                      ),

                      /// City
                      Text(
                        'المدينة',
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'اختار المدينة',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: kHeader1Color,
                          ),
                        ),
                        items: cubit.selectedCountry == null
                            ? []
                            : cities[cubit.selectedCountry!]!.map((city) {
                                return DropdownMenuItem(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),
                        value: cubit.selectedCity,
                        onChanged: (value) {
                          setState(() {
                            cubit.selectedCity = value;
                            isActive = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),

          /// Button
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 24.sp,
            ),
            child: isActive
                ? CustomButton(
                    text: 'ابدأ التصفح',
                    onTap: () => cubit.saveUserData(context),
                  )
                : const CustomButton(
                    text: 'ابدأ التصفح',
                    isActive: false,
                  ),
          ),
        );
      },
    );
  }
}
