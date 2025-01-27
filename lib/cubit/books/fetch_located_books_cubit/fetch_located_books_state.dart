part of 'fetch_located_books_cubit.dart';

@immutable
sealed class FetchLocatedBooksState {}

final class FetchLocatedBooksInitial extends FetchLocatedBooksState {}

final class FetchLocatedBooksLoading extends FetchLocatedBooksState {}

final class FetchLocatedBooksSuccess extends FetchLocatedBooksState {}

final class FetchLocatedBooksError extends FetchLocatedBooksState {
  FetchLocatedBooksError(this.message);

  final String message;
}
