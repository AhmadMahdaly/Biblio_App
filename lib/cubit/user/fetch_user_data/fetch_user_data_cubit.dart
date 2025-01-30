import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_user_data_state.dart';

class FetchUserDataCubit extends Cubit<FetchUserDataState> {
  FetchUserDataCubit() : super(FetchUserDataLoading());

  final supabase = Supabase.instance.client;

  String name = '';
  String email = '';
  Future<void> fetchUserData() async {
    emit(FetchUserDataLoading());
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return;
      }

      final response = await supabase
          .from('users')
          .select('username')
          .eq('id', user.id)
          .single();
      name = response['username'] as String;

      final response1 = await supabase
          .from('users')
          .select('email')
          .eq('id', user.id)
          .single();
      email = response1['email'] as String;

      emit(FetchUserDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(
        FetchUserDataError(e.toString()),
      );
    }
  }

  Future<void> updateUserData({
    required String inName,
    required String inEmail,
    required String inPassword,
  }) async {
    emit(FetchUserDataLoading());
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return;
      }
      var newName = inName;
      var newEmail = inEmail;
      final newPassword = inPassword;
      if (newName.isEmpty || newName == null) {
        final response = await supabase
            .from('users')
            .select('username')
            .eq('id', user.id)
            .single();
        newName = response['username'] as String;
      }
      if (newEmail.isEmpty || newEmail == null) {
        final response = await supabase
            .from('users')
            .select('email')
            .eq('id', user.id)
            .single();
        newEmail = response['email'] as String;
      }

      /// تحديث الاسم في قاعدة البيانات
      await supabase.from('users').update(
        {'username': newName},
      ).eq(
        'id',
        user.id,
      );
      await supabase.from('books').update({
        'user_name': newName,
      }).eq(
        'user_id',
        user.id,
      );
      if (newPassword.isEmpty || newPassword == null) {
      } else {
        await supabase.auth.updateUser(
          UserAttributes(
            email: newEmail,
          ),
        );
      }
      if (newPassword.isEmpty || newPassword == null) {
      } else {
        await supabase.auth.updateUser(
          UserAttributes(
            password: newPassword,
          ),
        );
      }
      emit(FetchUserDataSuccess());
    } catch (e) {
      log(e.toString());
      emit(
        FetchUserDataError(e.toString()),
      );
    }
  }
}
