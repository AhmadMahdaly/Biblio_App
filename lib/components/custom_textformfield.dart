import 'package:biblio/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({
    required this.text,
    this.keyboardType,
    this.obscureText = false,
    super.key,
    this.onChanged,
    this.icon = const SizedBox(),
    this.validator,
  });
  final String text;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final Widget icon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(20.sp),
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: kTextShadowColor,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: icon,
        border: border(),
        focusedBorder: border(),
        enabledBorder: border(),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.sp),
      borderSide: const BorderSide(
        color: kBorderColor,
      ),
    );
  }
}
