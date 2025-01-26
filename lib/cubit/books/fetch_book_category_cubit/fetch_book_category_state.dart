part of 'fetch_book_category_cubit.dart';

@immutable
sealed class FetchBookCategoryState {}

final class FetchBookCategoryInitial extends FetchBookCategoryState {}

final class FetchBookCategoryLoading extends FetchBookCategoryState {}

final class FetchBookCategorySuccess extends FetchBookCategoryState {}

final class FetchBookCategoryError extends FetchBookCategoryState {
  FetchBookCategoryError(this.message);

  final String message;
}
