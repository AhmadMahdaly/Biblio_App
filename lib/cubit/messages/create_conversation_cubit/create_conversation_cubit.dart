import 'dart:developer';

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
  Future<void> createConversation({
    required String otherId,
    required String titleBook,
    required String bookImg,
    required String bookId,
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
      await supabase.from('conversation_participants').insert([
        {
          'conversation_id': conversationId,
          'user_id': userId,
          'book_image': bookImg,
          'title_book': titleBook,
          'book_id': bookId,
        },
        {
          'conversation_id': conversationId,
          'user_id': otherId,
          'book_image': bookImg,
          'title_book': titleBook,
          'book_id': bookId,
        },
      ]);

      emit(CreateConversationSeccess());
    } on PostgrestException catch (e) {
      log(e.toString());
      if (e.message ==
          'JSON object requested, multiple (or no) rows returned') {}
    } on AuthException catch (e) {
      log(e.toString());
      emit(CreateConversationError(e.message));
    } catch (e) {
      log(e.toString());
      emit(CreateConversationError(e.toString()));
    }
  }
}
