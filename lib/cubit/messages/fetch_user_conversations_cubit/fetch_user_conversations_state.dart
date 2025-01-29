part of 'fetch_user_conversations_cubit.dart';

@immutable
sealed class FetchUserConversationsState {}

final class FetchUserConversationsInitial extends FetchUserConversationsState {}

final class FetchUserConversationsLoading extends FetchUserConversationsState {}

final class FetchUserConversationsSuccess extends FetchUserConversationsState {}

final class FetchUserConversationsError extends FetchUserConversationsState {
  FetchUserConversationsError(this.message);

  final String message;
}
