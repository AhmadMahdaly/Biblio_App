import 'dart:developer';

import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_conversation_state.dart';

class CreateConversationCubit extends Cubit<CreateConversationState> {
  CreateConversationCubit() : super(CreateConversationInitial());
  final supabase = Supabase.instance.client;
  int? conversationId;
  String? otherUserId;

  /// Create Conversation
  Future<void> createConversation(
    BuildContext context, {
    required String otherId,
    required String titleBook,
    required String bookImg,
    required String bookId,
    required String sender,
    required String receiver,
  }) async {
    emit(CreateConversationLoading());
    try {
      final userId = supabase.auth.currentUser!.id;
      otherUserId = otherId;

      final response = await supabase
          .from('conversations')
          .insert({'book_id': bookId})
          .select('id')
          .single();
      conversationId = response['id'] as int;

      // إضافة المستخدمين إلى المحادثة
      await supabase.from('conversation_participants').insert(
        {
          'receiver_id': otherId,
          'conversation_id': conversationId,
          'user_id': userId,
          'book_image': bookImg,
          'title_book': titleBook,
          'book_id': bookId,
          'receiver': receiver,
          'sender': sender,
        },
      );

      emit(CreateConversationSeccess());
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
      emit(CreateConversationError(e.message));
    } catch (e) {
      log(e.toString());
      emit(CreateConversationError(e.toString()));
    }
  }
}
