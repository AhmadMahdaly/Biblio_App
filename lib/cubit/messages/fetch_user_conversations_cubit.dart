import 'dart:developer';

import 'package:biblio/cubit/app_states.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchUserConversationsCubit extends Cubit<AppStates> {
  FetchUserConversationsCubit() : super(AppInitialState());

  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> sendConversations = [];
  List<Map<String, dynamic>> receiverConversations = [];
  Future<void> fetchSendConversations(
    BuildContext context,
  ) async {
    emit(AppLoadingState());
    try {
      if (Supabase.instance.client.auth.currentUser?.id == null) {
      } else {
        final user = Supabase.instance.client.auth.currentUser!.id;

        final response = await supabase
            .from('conversation_participants')
            .select(
              'conversation_id,receiver_id, user_id, book_image, title_book, receiver, sender,is_read_in, is_read_out, conversations(created_at)',
            )
            .eq('user_id', user)
            .order('conversation_id', ascending: false);
        sendConversations = List<Map<String, dynamic>>.from(response);
      }
      emit(AppSuccessState());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message ==
          'ClientException: Connection closed before full header was received') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      if (e.message ==
          'HandshakeException: Connection terminated during handshake') {
        showSnackBar(context, 'قد تكون هناك مشكلة في اتصال الإنترنت');
      }
      emit(AppErrorState(e.message));
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }

  Future<void> fetchReceiverConversations(
    BuildContext context,
  ) async {
    emit(AppLoadingState());
    try {
      if (Supabase.instance.client.auth.currentUser?.id == null) {
      } else {
        final user = Supabase.instance.client.auth.currentUser!.id;

        final response = await supabase
            .from('conversation_participants')
            .select(
              'conversation_id, user_id, receiver_id, is_read_in, is_read_out, book_image, title_book, receiver, sender, conversations(created_at)',
            )
            .eq('receiver_id', user)
            .order('conversation_id', ascending: false);
        receiverConversations = List<Map<String, dynamic>>.from(response);
      }
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
    } catch (e) {
      log(e.toString());
      emit(AppErrorState(e.toString()));
    }
  }
}
