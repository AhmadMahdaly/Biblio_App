part of 'fetch_order_type_book_cubit.dart';

@immutable
sealed class FetchOrderTypeBookState {}

final class FetchOrderTypeBookInitial extends FetchOrderTypeBookState {}

final class FetchOrderTypeBookLoading extends FetchOrderTypeBookState {}

final class FetchOrderTypeBookSuccess extends FetchOrderTypeBookState {}

final class FetchOrderTypeBookError extends FetchOrderTypeBookState {
  FetchOrderTypeBookError(this.message);

  final String message;
}
