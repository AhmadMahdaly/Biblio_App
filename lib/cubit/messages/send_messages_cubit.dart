import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SendMessagesCubit extends Cubit<AppStates> {
  SendMessagesCubit() : super(AppInitialState());
  final supabase = Supabase.instance.client;

  /// Send Message
  Future<void> sendIncomeMessage(
    BuildContext context, {
    required String conversationId,
    required String content,
  }) async {
    emit(AppLoadingState());
    try {
      final userId = supabase.auth.currentUser?.id;
      final otherIdResponse = await supabase
          .from('conversation_participants')
          .select('receiver_id, user_id')
          .eq('conversation_id', conversationId)
          .single();
      final otherId = otherIdResponse['receiver_id'].toString() == userId
          ? otherIdResponse['user_id'].toString()
          : otherIdResponse['receiver_id'].toString();

      await supabase.from('messages').insert({
        'conversation_id': conversationId,
        'user_id': userId,
        'content': content,
        'other_id': otherId,
      });
      await supabase
          .from('conversation_participants')
          .update({'is_read_out': false})
          .eq('conversation_id', conversationId)
          .eq('user_id', userId!);
      await supabase
          .from('conversation_participants')
          .update({'is_read_in': false})
          .eq('conversation_id', conversationId)
          .eq('receiver_id', userId);
      emit(AppSuccessState());
    } on PostgrestException catch (e) {
      log(e.toString());

      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message
          .contains('Connection closed before full header was received')) {
        showSnackBar(
          context,
          'تعذر الاتصال بالخادم، يرجى التحقق من الإنترنت والمحاولة مرة أخرى.',
        );
      }
      if (e.message.contains(
        'Connection terminated during handshake',
      )) {
        showSnackBar(
          context,
          'تعذر الاتصال بالخادم، يرجى التحقق من الإنترنت والمحاولة مرة أخرى.',
        );
      }
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> sendOutgoingMessage(
    BuildContext context, {
    required String conversationId,
    required String content,
  }) async {
    emit(AppLoadingState());
    try {
      final userId = supabase.auth.currentUser?.id;
      final otherIdResponse = await supabase
          .from('conversation_participants')
          .select('receiver_id, user_id')
          .eq('conversation_id', conversationId)
          .single();
      final otherId = otherIdResponse['receiver_id'].toString() == userId
          ? otherIdResponse['user_id'].toString()
          : otherIdResponse['receiver_id'].toString();
      await supabase.from('messages').insert({
        'conversation_id': conversationId,
        'user_id': userId,
        'content': content,
        'other_id': otherId,
      });
      await supabase
          .from('conversation_participants')
          .update({'is_read_out': false})
          .eq('conversation_id', conversationId)
          .eq('user_id', userId!);
      await supabase
          .from('conversation_participants')
          .update({'is_read_in': false})
          .eq('conversation_id', conversationId)
          .eq('receiver_id', userId);
      emit(AppSuccessState());
    } on PostgrestException catch (e) {
      log(e.toString());
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
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
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }
}
// widget.conversation['user_id'] == user &&
// widget.conversation['is_read_in'] == false ||

// widget.conversation['receiver_id'] == user &&
// widget.conversation['is_read_out'] == false
