import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
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
        if (state is SignOutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const OnboardScreen();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return state is SignOutLoading
            ? const AppIndicator()
            : TextButton(
                onPressed: () async {
                  try {
                    // ignore: inference_failure_on_function_invocation
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: kLightBlue,
                        content: const Text(
                          'هل تريد تسجيل الخروج؟',
                          style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        actions: [
                          ///
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'إلغاء',
                              style: TextStyle(
                                color: kMainColor,
                              ),
                            ),
                          ),

                          ///
                          ElevatedButton(
                            onPressed: () async {
                              await cubit.signOut(context);
                            },
                            child: const Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: kMainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } catch (_) {}
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
