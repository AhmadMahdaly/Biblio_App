import 'dart:io';

import 'package:biblio/screens/add_book_page/models/book_model.dart';
import 'package:biblio/screens/add_book_page/widgets/add_book_image.dart';
import 'package:biblio/screens/add_book_page/widgets/title_form_add_book.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  bool isActive = false;

  File? _coverImage;
  File? _coverImageI;

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _conditionController = TextEditingController();
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedCategory;
  List<String> categories = [];
  String? selectedOffer;
  List<String> offerTypes = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchCategories();
    fetchOrderType();
    fetchUserId();
  }

  String? _user;
  Future<void> fetchUserId() async {
    try {
      /// الحصول على المستخدم الحالي
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('المستخدم غير مسجل الدخول.');
      }

      if (mounted) {
        setState(() {
          _user = user.id;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await supabase.from('categories').select('name');

      setState(() {
        categories = response.map((e) => e['name'] as String).toList();
      });
    } catch (e) {
      // showSnackBar(context, 'هناك خطأ $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchOrderType() async {
    try {
      final response = await supabase.from('offer_type').select('type');

      setState(() {
        offerTypes = response.map((e) => e['type'] as String).toList();
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // showSnackBar(context, 'هناك خطأ $e');
    }
  }

  /// Pick 1st image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 30,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }

  /// Pick 2nd image
  Future<void> _pickImageI() async {
    final pickedFile = await ImagePicker().pickImage(
      imageQuality: 30,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _coverImageI = File(pickedFile.path);
      });
    }
  }

  /// Upload book
  Future<void> _uploadBook() async {
    setState(() {
      isLoading = true;
    });
    try {
      /// رفع الصورة إلى Supabase Storage
      final fileName = DateTime.now().toIso8601String();
      if (_coverImage != null) {
        await supabase.storage
            .from('book_covers')
            .upload(fileName, _coverImage!);
      }
      final imageUrl =
          supabase.storage.from('book_covers').getPublicUrl(fileName);

      ///

      final fileNameI = DateTime.now().toIso8601String();
      if (_coverImageI != null) {
        await supabase.storage
            .from('book_covers')
            .upload(fileNameI, _coverImageI!);
      }

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

      final book = BookModel(
        coverImageUrlI: imageUrlI,
        userId: supabase.auth.currentUser!.id,
        coverImageUrl: imageUrl,
        title: _titleController.text,
        author: _authorController.text,
        category: selectedCategory!,
        description: _descriptionController.text,
        condition: _conditionController.text,
        offerType: selectedOffer!,
        userName: userName.toString(),
        userImage: userImage.toString(),
        price: int.tryParse(priceController.text) ?? 0,
      );

      // إضافة بيانات الكتاب إلى الجدول

      await supabase.from('books').insert([book.toJson()]);

      if (mounted) {
        isLoading = false;
        showSnackBar(context, 'تم إضافة الكتاب بنجاح!');
        await Navigator.pushReplacementNamed(context, NavigationBarApp.id);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        // showSnackBar(context, 'هناك خطأ! $e.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_coverImage == null ||
        _coverImageI == null ||
        _titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        selectedCategory == null ||
        _conditionController.text.isEmpty ||
        selectedOffer == null) {
      if (mounted) {
        setState(() {
          isActive = false;
        });
      }
    } else {
      setState(() {
        isActive = true;
      });
    }
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const AppIndicator(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, NavigationBarApp.id),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kMainColor,
              size: 22.sp,
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
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  'من فضلك اضف صورتين للكتاب',
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
                      icon: Icons.image_outlined,
                      //  Icons.camera_alt_outlined,
                      image: _coverImage,
                      onTap: _pickImage,
                    ),
                    AddBookImages(
                      icon: Icons.image_outlined,
                      //  Icons.camera_alt_outlined,
                      image: _coverImageI,
                      onTap: _pickImageI,
                    ),
                  ],
                ),
                const TitleFormAddBook(
                  title: 'اسم الكتاب',
                ),
                CustomTextformfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                  text: 'مثال: بين القصرين',
                  controller: _titleController,
                ),
                const TitleFormAddBook(title: 'اسم الكاتب'),
                CustomTextformfield(
                  text: 'مثال: نجيب محفوظ',
                  controller: _authorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                ),
                const TitleFormAddBook(title: 'فئة الكتاب'),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                  icon: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.sp,
                    ),
                  ),
                  elevation: 5,
                  dropdownColor: kLightBlue,
                  value: selectedCategory,
                  items: categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'اختر فئة الكتاب',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: kTextShadowColor,
                      fontWeight: FontWeight.w500,
                    ),
                    border: border(),
                    focusedBorder: border(),
                    enabledBorder: border(),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const TitleFormAddBook(title: 'نبذة عن الكتاب'),
                CustomTextformfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                  maxLines: 100,
                  text: '',
                  contentPadding: EdgeInsets.only(
                    bottom: 56.sp,
                    right: 12.sp,
                    left: 12.sp,
                    top: 12.sp,
                  ),
                  controller: _descriptionController,
                ),
                const TitleFormAddBook(title: 'حالة الكتاب'),
                CustomTextformfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                  text: '',
                  controller: _conditionController,
                ),
                const TitleFormAddBook(title: 'نوع العرض'),
                DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل البيانات المطلوبة';
                    }
                    return null;
                  },
                  icon: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.sp,
                    ),
                  ),
                  elevation: 5,
                  dropdownColor: kLightBlue,
                  value: selectedOffer,
                  items: offerTypes
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedOffer = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'اختر نوع العرض',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: kTextShadowColor,
                      fontWeight: FontWeight.w500,
                    ),
                    border: border(),
                    focusedBorder: border(),
                    enabledBorder: border(),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.sp),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                if (selectedOffer == 'للبيع')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TitleFormAddBook(title: 'السعر'),
                      CustomTextformfield(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ادخل البيانات المطلوبة';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        text: 'مثال: 10',
                        controller: priceController,
                      ),
                    ],
                  )
                else
                  const SizedBox(),
                const H(h: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.sp),
          child: _user == null
              ? CustomBorderBotton(
                  padding: 16,
                  text: 'تسجيل الدخول',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, OnboardScreen.id);
                  },
                )
              : isActive
                  ? CustomButton(
                      text: 'إضافة الكتاب',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await _uploadBook();
                        }
                      },
                    )
                  : const CustomButton(
                      isActive: false,
                      text: 'إضافة الكتاب',
                    ),
        ),
      ),
    );
  }
}
