import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'send_messages_state.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit() : super(SendMessagesInitial());
  final supabase = Supabase.instance.client;

  /// Send Message
  Future<void> sendMessage(
    BuildContext context, {
    required String conversationId,
    required String content,
  }) async {
    emit(SendMessagesLoading());
    try {
      final userId = supabase.auth.currentUser?.id;
      final otherIdResponse = await supabase
          .from('conversation_participants')
          .select('receiver_id')
          .eq('conversation_id', conversationId)
          .single();
      final otherId = otherIdResponse['receiver_id'].toString();

      await supabase.from('messages').insert({
        'conversation_id': conversationId,
        'user_id': userId,
        'content': content,
        'other_id': otherId,
      });
      emit(SendMessagesSuccess());
    } on PostgrestException catch (e) {
      log(e.toString());
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
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
      emit(SendMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SendMessagesError(e.toString()));
    }
  }
}
