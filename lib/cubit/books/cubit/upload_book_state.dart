part of 'upload_book_cubit.dart';

@immutable
sealed class UploadBookState {}

final class UploadBookInitial extends UploadBookState {}

final class UploadBookLoading extends UploadBookState {}

final class UploadBookSuccess extends UploadBookState {}

final class UploadBookError extends UploadBookState {
  UploadBookError(this.message);

  final String message;
}

final class PickBookImagesLoading extends UploadBookState {}

final class PickBookImagesSuccess extends UploadBookState {}

final class PickBookImagesError extends UploadBookState {
  PickBookImagesError(this.message);

  final String message;
}
