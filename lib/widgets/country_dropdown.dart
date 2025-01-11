import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryDropdown extends StatefulWidget {
  const CountryDropdown({super.key});

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String? _selectedCountry; // لتخزين الدولة المختارة

  // قائمة الدول
  final List<String> _countries = [
    'مصر',
    'السعودية',
    'الإمارات',
    'الأردن',
    'الكويت',
    'لبنان',
    'العراق',
    'فلسطين',
    'سوريا',
    'الجزائر',
    'المغرب',
    'تونس',
    'الولايات المتحدة',
    'المملكة المتحدة',
    'ألمانيا',
    'فرنسا',
    'إيطاليا',
    'إسبانيا',
    'البرازيل',
    'الهند',
    'اليابان',
    'أستراليا',
    'جنوب أفريقيا',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: kBorderColor,
          ),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: DropdownButton<String>(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          borderRadius: BorderRadius.circular(12.sp),
          icon: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 16.sp,
            ),
          ),
          underline: const SizedBox(),
          isExpanded: true,
          hint: Text(
            'اختر دولة',
            style: TextStyle(
              fontSize: 14.sp,
              color: kHeader1Color,
            ),
          ), // نص يظهر عندما لا يتم اختيار دولة
          value: _selectedCountry,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCountry = newValue; // تحديث الدولة المختارة
            });
          },
          items: _countries.map<DropdownMenuItem<String>>((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(
                country,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: kHeader1Color,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
