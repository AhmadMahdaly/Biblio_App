part of 'create_conversation_cubit.dart';

@immutable
sealed class CreateConversationState {}

final class CreateConversationInitial extends CreateConversationState {}

final class CreateConversationLoading extends CreateConversationState {}

final class CreateConversationSeccess extends CreateConversationState {}

final class CreateConversationError extends CreateConversationState {
  CreateConversationError(this.message);

  final String message;
}
