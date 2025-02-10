part of 'fetch_unread_conversation_cubit.dart';

@immutable
sealed class FetchUnreadConversationState {}

final class FetchUnreadConversationInitial
    extends FetchUnreadConversationState {}

final class FetchUnreadConversationError extends FetchUnreadConversationState {}

final class FetchUnreadConversationLoading
    extends FetchUnreadConversationState {}

final class FetchUnreadConversationSuccess
    extends FetchUnreadConversationState {}
