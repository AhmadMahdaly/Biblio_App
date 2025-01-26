part of 'pick_book_images_cubit.dart';

@immutable
sealed class PickBookImagesState {}

final class PickBookImagesInitial extends PickBookImagesState {}

final class PickBookImagesLoading extends PickBookImagesState {}

final class PickBookImagesSuccess extends PickBookImagesState {}

final class PickBookImagesError extends PickBookImagesState {
  PickBookImagesError(this.message);

  final String message;
}
