import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fetch_messages_state.dart';

class FetchMessagesCubit extends Cubit<FetchMessagesState> {
  FetchMessagesCubit() : super(FetchMessagesInitial());
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> messages = [];
  String name = '';

  Future<void> fetchUserName(BuildContext context,
      {required String userId}) async {
    emit(FetchMessagesLoading());
    try {
      final response1 =
          await supabase.from('users').select('username').eq('id', userId);
      name = response1.toString();
      emit(FetchMessagesSuccess());
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
      emit(FetchMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.toString()));
    }
  }

  /// fetch Messages
  Future<void> fetchMessages({required String conversationId}) async {
    emit(FetchMessagesLoading());
    try {
      final response = await supabase
          .from('messages')
          .select('content, created_at, user_id')
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: false);
      messages = List<Map<String, dynamic>>.from(response);

      emit(FetchMessagesSuccess());
    } on PostgrestException catch (e) {
      log(e.toString());
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
      emit(FetchMessagesLoading());
    } on AuthException catch (e) {
      log(e.toString());
      if (e.message == 'Connection closed before full header was received') {}
      emit(FetchMessagesLoading());
      emit(FetchMessagesError(e.message));
    } catch (e) {
      log(e.toString());
      emit(FetchMessagesError(e.toString()));
    }
  }
}

//   Future<void> updateMessage({
//     required String conversationId,
//     required String messageId,
//   }) async {
//     emit(UpdateMessageLoading());
//     try {
//       await supabase
//           .from('messages')
//           .update({'is_read': true})
//           .eq('conversation_id', conversationId)
//           .eq('id', messageId);
//       emit(UpdateMessageSuccess());
//     } on PostgrestException catch (e) {
//       log(e.toString());
//       if (e.message ==
//           'JSON object requested, multiple (or no) rows returned') {}
//     } on AuthException catch (e) {
//       log(e.toString());
//       emit(UpdateMessageError(e.message));
//     } catch (e) {
//       log(e.toString());
//       emit(UpdateMessageError(e.toString()));
//     }
//   }
// }

// Future<void> deleteMessage({required String messageId}) async {
//   emit(DeleteMessageLoading());
//   try {
//     await supabase.from('messages').delete().eq('id', messageId);
//     emit(DeleteMessageSuccess());
//   } on AuthException catch (e) {
//     log(e.toString());
//     emit(DeleteMessageError(e.message));
//   } catch (e) {
//     log(e.toString());
//     emit(DeleteMessageError(e.toString()));
//   }
// }

// Future<void> deleteConversation({required String conversationId}) async {
//   emit(DeleteConversationLoading());
//   try {
//     await supabase.from('conversations').delete().eq('id', conversationId);
//     emit(DeleteConversationSuccess());
//   } on AuthException catch (e) {
//     log(e.toString());
//     emit(DeleteConversationError(e.message));
//   } catch (e) {
//     log(e.toString());
//     emit(DeleteConversationError(e.toString()));
//   }
// }

// Future<void> deleteConversationParticipant({required String conversationId}) async {
//   emit(DeleteConversationParticipantLoading());
//   try {
//     await supabase
//         .from('conversation_participants')
//         .delete()
//         .eq('conversation_id', conversationId);
//     emit(DeleteConversationParticipantSuccess());
//   } on AuthException catch (e) {
//     log(e.toString());
//     emit(DeleteConversationParticipantError(e.message));
//   } catch (e) {
//     log(e.toString());
//     emit(DeleteConversationParticipantError(e.toString()));
//   }
// }

// Future<void> deleteConversationMessages({required String conversationId}) async {
//   emit(DeleteConversationMessagesLoading());
//   try {
//     await supabase.from('messages').delete().eq('conversation_id', conversationId);
//     emit(DeleteConversationMessagesSuccess());
//   } on AuthException catch (e) {
//     log(e.toString());
//     emit(DeleteConversationMessagesError(e.message));
//   } catch (e) {
//     log(e.toString());
//     emit(DeleteConversationMessagesError(e.toString()));
//   }
// }
