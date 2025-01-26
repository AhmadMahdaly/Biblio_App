import 'package:biblio/services/fetch_user_name.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OrderTheBookPage extends StatefulWidget {
  const OrderTheBookPage({super.key});
  static String id = 'OrderTheBookPage';

  @override
  State<OrderTheBookPage> createState() => _OrderTheBookPageState();
}

class _OrderTheBookPageState extends State<OrderTheBookPage> {
  final _messageController = TextEditingController();

  bool isLoading = false;
  late int bookId = 0;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(Duration.zero, () {
      final args =
          ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;

      setState(() {
        bookId = args['book_id'] as int;
        _fetchBooks(bookId);
      });
    });
  }

  String book = '';

  Future<void> _fetchBooks(int bookId) async {
    // await Future.delayed(
    //   const Duration(seconds: 2),
    // );
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        ///
        return;
      }
      final response = await supabase
          .from('books')
          .select('title')
          .eq('id', bookId)
          .single();

      setState(() {
        final title = response['title'];
        book = title.toString();
        isLoading = false;
      });

      /// لإظهار الداتا
    } catch (e) {
      if (mounted) {
        // showSnackBar(context, ' $e هناك خطأ! حاول مرة أخرى.');

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: book == null || book.isEmpty,
      progressIndicator: const AppIndicator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'رسالة لطلب كتاب $book',
            style: TextStyle(
              color: kMainColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              height: 1.71.sp,
            ),
          ),

          /// Leading
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // إزالة جميع الصفحات
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 22.sp,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: ListView(
            children: [
              Text(
                'اكتب رسالة قصيرة توضح طلبك',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.50.sp,
                ),
              ),
              const H(h: 20),
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
                  bottom: 170.sp,
                  right: 12.sp,
                  left: 12.sp,
                  top: 12.sp,
                ),
                controller: _messageController,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.sp),
          child: const CustomButton(
            text: 'إرسال',
          ),
        ),
      ),
    );
  }
}
