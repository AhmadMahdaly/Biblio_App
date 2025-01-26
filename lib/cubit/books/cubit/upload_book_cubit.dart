import 'dart:developer';
import 'dart:io';

import 'package:biblio/screens/add_book_page/models/book_model.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'upload_book_state.dart';

class UploadBookCubit extends Cubit<UploadBookState> {
  UploadBookCubit() : super(UploadBookInitial());
  final SupabaseClient supabase = Supabase.instance.client;

  /// Upload book
  Future<void> uploadBook(
    BuildContext context, {
    required String title,
    required String author,
    required String desc,
    required String state,
    required String price,
    required String selectedCategory,
    required String selectedOffer,
    required File coverFirstImage,
    required File coverSecondImage,
  }) async {
    emit(UploadBookLoading());

    try {
      /// رفع الصورة إلى Supabase Storage
      final fileName = DateTime.now().toIso8601String();
      await supabase.storage
          .from('book_covers')
          .upload(fileName, coverFirstImage);
      final imageUrl =
          supabase.storage.from('book_covers').getPublicUrl(fileName);

      ///
      final fileNameI = DateTime.now().toIso8601String();
      await supabase.storage
          .from('book_covers')
          .upload(fileNameI, coverSecondImage);
      final imageUrlI =
          supabase.storage.from('book_covers').getPublicUrl(fileNameI);

      final response = await supabase
          .from('users')
          .select('username')
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      final userName = response['username'];

      final userImageResponse = await supabase
          .from('users')
          .select('image')
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      final userImage = userImageResponse['image'];

      final userCityResponse = await supabase
          .from('users')
          .select('city')
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      final userLocation = userCityResponse['city'];

      final userCountryResponse = await supabase
          .from('users')
          .select('country')
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      final userCountry = userCountryResponse['country'];

      final book = BookModel(
        coverImageUrl: imageUrl,
        coverImageUrlI: imageUrlI,
        title: title,
        author: author,
        description: desc,
        condition: state,
        category: selectedCategory,
        offerType: selectedOffer,
        price: int.tryParse(price) ?? 0,
        userId: supabase.auth.currentUser!.id,
        userName: userName.toString(),
        userImage: userImage.toString(),
        userCity: userLocation.toString(),
        userCountry: userCountry.toString(),
      );

      // إضافة بيانات الكتاب إلى الجدول
      await supabase.from('books').insert([book.toJson()]);
      emit(UploadBookSuccess());

      await Navigator.pushReplacementNamed(context, NavigationBarApp.id);
    } catch (e) {
      log(e.toString());
      emit(UploadBookError(e.toString()));
    }
  }
}
