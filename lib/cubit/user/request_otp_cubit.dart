import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/screens/login/widgets/verification_code_screen.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestOtpCubit extends Cubit<AppStates> {
  RequestOtpCubit() : super(AppInitialState());
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> requestOtp(String email, BuildContext context) async {
    emit(AppLoadingState());

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
      emit(AppSuccessState());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message.contains(
        'Connection reset by peer',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection closed before full header was received',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message.contains(
        'Connection terminated during handshake',
      )) {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      emit(AppErrorState(e.message));
    } catch (generalError) {
      showSnackBar(context, generalError.toString());
      emit(AppErrorState(generalError.toString()));
    }
  }
}
