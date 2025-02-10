import 'dart:async';

import 'package:biblio/screens/book/book_page/book_page.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> books = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  // دالة البحث مع تأخير (Debounce) لمنع البحث مع كل حرف يكتبه المستخدم
  void searchBooks(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () async {
      if (query.isEmpty) {
        setState(() => books = []);
        return;
      }

      // ignore: avoid_redundant_argument_values
      final response = await supabase.from('books').select('*').or(
            'title.ilike.%$query%,author.ilike.%$query%',
          ); // بحث في العنوان أو المؤلف

      setState(() {
        books = response;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.sp,
        leadingWidth: 30.sp,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 22.sp,
            color: kMainColor,
          ),
        ),
        title: TextField(
          onChanged: searchBooks,
          controller: searchController,
          autofocus: true,
          cursorWidth: 0.5.sp,
          cursorColor: kMainColor,
          decoration: InputDecoration(
            hintText: 'ابحث باسم الكتاب أو المؤلف',
            hintStyle: TextStyle(
              color: const Color(0xFF969697),
              fontSize: 12.sp,
              fontWeight: FontWeight.w300,
            ),
            filled: true,
            fillColor: const Color(0xFFECECEC),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.sp),
            border: border(),
            enabledBorder: border(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.sp),
              borderSide: const BorderSide(
                color: kMainColor,
              ),
            ),
            suffixIcon: InkWell(
              onTap: () => searchBooks(searchController.text),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.sp),
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                width: 32.sp,
                height: 32.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    15.sp,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/svg/Magnifier.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF213555),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.sp),
        child: Column(
          children: [
            Expanded(
              child: books.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Reading glasses-cuate.svg',
                            height: 80.sp,
                          ),
                          Text(
                            'لا توجد نتائج',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 12.sp),
                          color: kLightBlue,
                          child: ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowBookItem(
                                  book: book,
                                ),
                              ),
                            ),
                            leading: book['cover_image_url'] != null
                                ? Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                    ),
                                    child: Image.network(
                                      book['cover_image_url'].toString(),
                                      width: 50.sp,
                                      height: 50.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(Icons.book, size: 50.sp),
                            title: Text(
                              book['title'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            subtitle: Text("✍ ${book['author']}"),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
