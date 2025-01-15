import 'dart:io';

import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/add_book_image.dart';
import 'package:biblio/screens/navigation_bar/pages/add_book_page/widgets/title_form_add_book.dart';
import 'package:biblio/screens/navigation_bar/pages/home_page/models/book_model.dart';
import 'package:biblio/screens/my_lib_page/my_library_page.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});
  static String id = 'AddBook';

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool isLoading = false;

  File? _coverImage;
  File? _coverImageI;
  File? _coverImageII;

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _conditionController = TextEditingController();
  final _offerTypeController = TextEditingController();

  /// Pick 1st image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
    showSnackBar(context, 'يفضل ألا يزيد حجم الصور عن 1 ميجابايت');
  }

  /// Pick 2nd image
  Future<void> _pickImageI() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImageI = File(pickedFile.path);
      });
    }
    showSnackBar(context, 'يفضل ألا يزيد حجم الصور عن 1 ميجابايت');
  }

  /// Pick 3rd image
  Future<void> _pickImageII() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverImageII = File(pickedFile.path);
      });
    }
    showSnackBar(context, 'يفضل ألا يزيد حجم الصور عن 1 ميجابايت');
  }

  /// Upload book
  Future<void> _uploadBook() async {
    if (_coverImage == null ||
        _titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _conditionController.text.isEmpty ||
        _offerTypeController.text.isEmpty) {
      showSnackBar(context, 'من فضلك أدخل البيانات المطلوبة');
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      ///
      /// رفع الصورة إلى Supabase Storage
      final fileName = 'books/${DateTime.now().toIso8601String()}';
      // ignore: unused_local_variable
      final storageResponse = await supabase.storage
          .from('book_covers')
          .upload(fileName, _coverImage!);
      final imageUrl =
          supabase.storage.from('book_covers').getPublicUrl(fileName);

      ///

      final fileNameI = 'books/${DateTime.now().toIso8601String()}';
      if (_coverImageI != null) {
        // ignore: unused_local_variable
        final storageResponseI = await supabase.storage
            .from('book_covers')
            .upload(fileNameI, _coverImageI!);
      }
      final imageUrlI =
          supabase.storage.from('book_covers').getPublicUrl(fileNameI);

      ///
      final fileNameII = 'books/${DateTime.now().toIso8601String()}';
      if (_coverImageI != null) {
        // ignore: unused_local_variable
        final storageResponseII = await supabase.storage
            .from('book_covers')
            .upload(fileNameII, _coverImageII!);
      }
      final imageUrlII =
          supabase.storage.from('book_covers').getPublicUrl(fileNameII);

      final book = BookModel(
        coverImageUrlI: imageUrlI,
        coverImageUrlII: imageUrlII,
        userId: supabase.auth.currentUser!.id,
        coverImageUrl: imageUrl,
        title: _titleController.text,
        author: _authorController.text,
        category: _categoryController.text,
        description: _descriptionController.text,
        condition: _conditionController.text,
        offerType: _offerTypeController.text,
      );

      // إضافة بيانات الكتاب إلى الجدول

      // final response =
      await supabase.from('books').insert([book.toJson()]);

      // ignore: avoid_dynamic_calls
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'تم إضافة الكتاب بنجاح!');
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const MyLibraryPage();
          },
        ),
      );
      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'يوجد خطأ: $e');
      // print('يوجد خطأ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, NavigationBarApp.id),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          'إضافة كتاب جديد',
          style: TextStyle(
            color: kMainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: ListView(
          children: [
            Text(
              'من فضلك اضف صورة أو أكثر الكتاب',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: kTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const H(h: 10),
            Row(
              spacing: 12.sp,
              children: [
                AddBookImages(
                  image: _coverImage,
                  onTap: _pickImage,
                ),
                AddBookImages(
                  image: _coverImageI,
                  onTap: _pickImageI,
                ),
                AddBookImages(
                  image: _coverImageII,
                  onTap: _pickImageII,
                ),
              ],
            ),
            const TitleFormAddBook(
              title: 'اسم الكتاب',
            ),
            CustomTextformfield(
              text: 'مثال: بين القصرين',
              controller: _titleController,
            ),
            const TitleFormAddBook(title: 'اسم الكاتب'),
            CustomTextformfield(
              text: 'مثال: نجيب محفوظ',
              controller: _authorController,
            ),
            const TitleFormAddBook(title: 'فئة الكتاب'),
            CustomTextformfield(
              text: '',
              controller: _categoryController,
            ),
            const TitleFormAddBook(title: 'نبذة عن الكتاب'),
            CustomTextformfield(
              text: '',
              contentPadding: 32,
              controller: _descriptionController,
            ),
            const TitleFormAddBook(title: 'حالة الكتاب'),
            CustomTextformfield(
              text: '',
              controller: _conditionController,
            ),
            const TitleFormAddBook(title: 'نوع العرض'),
            CustomTextformfield(
              text: '',
              controller: _offerTypeController,
            ),
            const H(h: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.sp),
        child: CustomButton(
          text: 'إضافة الكتاب',
          onTap: _uploadBook,
        ),
      ),
    );
  }
}
