import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'pick_book_images_state.dart';

class PickBookImagesCubit extends Cubit<PickBookImagesState> {
  PickBookImagesCubit() : super(PickBookImagesInitial());
  File? coverFirstImage;
  File? coverSocendImage;

  /// Pick 1st image
  Future<void> pickFirstImage() async {
    emit(PickBookImagesLoading());
    try {
      final pickedFile = await ImagePicker().pickImage(
        imageQuality: 30,
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        coverFirstImage = File(pickedFile.path);
      }
      emit(PickBookImagesSuccess());
    } catch (e) {
      log(e.toString());
      emit(PickBookImagesError(e.toString()));
    }
  }

  /// Pick 2nd image
  Future<void> pickSocendImage() async {
    emit(PickBookImagesLoading());
    try {
      final pickedFile = await ImagePicker().pickImage(
        imageQuality: 30,
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        coverSocendImage = File(pickedFile.path);
        emit(PickBookImagesSuccess());
      }
    } catch (e) {
      log(e.toString());
      emit(PickBookImagesError(e.toString()));
    }
  }
}
