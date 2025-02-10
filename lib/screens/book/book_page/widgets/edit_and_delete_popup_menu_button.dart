import 'dart:developer';

import 'package:biblio/screens/book/edit_book/edit_my_book.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/utils/components/show_dialog.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteBook(Map<String, dynamic> book) async {
  try {
    final response = await Supabase.instance.client
        .from('books')
        .select('cover_image_url')
        .eq('id', book['id'].toString())
        .single();
    final oldPhotoUrl = response['cover_image_url'] as String;
    final oldFileName = oldPhotoUrl.split('/').last;
    await Supabase.instance.client.storage
        .from('book_covers')
        .remove([oldFileName]);
    final responsed = await Supabase.instance.client
        .from('books')
        .select('cover_book_url2')
        .eq('id', book['id'].toString())
        .single();
    final oldPhotoUrlI = responsed['cover_book_url2'] as String;
    final oldFileNameI = oldPhotoUrlI.split('/').last;

    await Supabase.instance.client.storage
        .from('book_covers')
        .remove([oldFileNameI]);
    await Supabase.instance.client.from('conversations').delete().eq(
          'book_id',
          book['id'].toString(),
        );

    await Supabase.instance.client.from('books').delete().eq(
          'id',
          book['id'].toString(),
        );
  } catch (e) {
    log(e.toString());
  }
}

PopupMenuButton<String> editAndDeletePopupMenuButton(
  BuildContext context,
  Map<String, dynamic> book,
) {
  return PopupMenuButton<String>(
    color: kLightBlue,
    onSelected: (value) async {
      if (value == 'edit') {
        await Navigator.pushNamed(
          context,
          EditBook.id,
          arguments: {'bookId': book['id']},
        );
      } else if (value == 'delete') {
        final shouldExit = await showCustomDialog(
          context,
          'ستقوم بحذف الكتاب؟',
        );
        // return shouldExit!;
        if (shouldExit!) {
          await deleteBook(book);
          await Navigator.pushReplacementNamed(
            context,
            NavigationBarApp.id,
          );
        }
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(
                Icons.mode_edit_outline_outlined,
                size: 24.sp,
                color: kMainColor,
              ),
              const SizedBox(width: 8),
              const Text('تعديل'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_rounded,
                color: kMainColor,
                size: 22.sp,
              ),
              const SizedBox(width: 8),
              const Text('مسح'),
            ],
          ),
        ),
      ];
    },
  );
}
