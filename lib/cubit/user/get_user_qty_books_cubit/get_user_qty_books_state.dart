part of 'get_user_qty_books_cubit.dart';

@immutable
sealed class GetUserQtyBooksState {}

final class GetUserQtyBooksInitial extends GetUserQtyBooksState {}

final class GetUserQtyBooksLoading extends GetUserQtyBooksState {}

final class GetUserQtyBooksSuccess extends GetUserQtyBooksState {}

final class GetUserQtyBooksError extends GetUserQtyBooksState {
  GetUserQtyBooksError(this.message);

  final String message;
}
