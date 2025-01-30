import 'package:biblio/screens/login/widgets/new_password_page.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class CustomVerificationCode extends StatefulWidget {
  const CustomVerificationCode({super.key});

  @override
  State<CustomVerificationCode> createState() => _CustomVerificationCodeState();
}

class _CustomVerificationCodeState extends State<CustomVerificationCode> {
  bool _onEditing = true;
  String? code;
  @override
  Widget build(BuildContext context) {
    return VerificationCode(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      textStyle: TextStyle(fontSize: 20.sp, color: kMainColor),
      underlineColor: kBorderColor,
      cursorColor: kMainColor,
      onCompleted: (String value) {
        setState(() {
          code = value;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const NewPasswordPage();
            },
          ),
        );
      },
      onEditing: (bool value) {
        setState(() {
          _onEditing = value;
        });
        if (!_onEditing) FocusScope.of(context).unfocus();
      },
    );
  }
}
