import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return state is SignOutLoading
            ? const AppIndicator()
            : TextButton(
                onPressed: () async {
                  await cubit.signOut(context);
                },
                child: Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: const Color(0xFFEA1C25),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
      },
    );
  }
}
