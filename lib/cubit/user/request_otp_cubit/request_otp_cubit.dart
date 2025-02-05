import 'package:biblio/screens/login/widgets/verification_code_screen.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'request_otp_state.dart';

class RequestOtpCubit extends Cubit<RequestOtpState> {
  RequestOtpCubit() : super(RequestOtpInitial());
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> requestOtp(String email, BuildContext context) async {
    emit(RequestOtpLoading());

    try {
      if (email.isEmpty) {
        showSnackBar(context, 'يرجى إدخال البريد الإلكتروني');
        return;
      }
      await supabase.auth.signInWithOtp(email: email);
      showSnackBar(
        context,
        'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني',
      );
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodePage(
            email: email,
          ),
        ),
      );
      emit(RequestOtpSuccess());
    } on AuthException catch (authError) {
      showSnackBar(context, authError.message);
      emit(RequestOtpError(authError.message));
    } catch (generalError) {
      showSnackBar(context, generalError.toString());
      emit(RequestOtpError(generalError.toString()));
    }
  }
}
