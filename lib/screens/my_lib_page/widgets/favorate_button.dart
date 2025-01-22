import 'package:biblio/services/fetch_email.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    required this.bookId,
    super.key,
  });

  final String bookId; // معرّف فريد للكتاب

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول.');
    }
    final userId = user.id;
    try {
      await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('book_id', widget.bookId)
          .single();
      setState(() {
        isFavorite = true;
      });
    } catch (e) {
      // print(e);
    }
  }

  Future<void> _toggleFavorite() async {
    final userId = supabase.auth.currentUser!.id;
    if (isFavorite) {
      // إزالة من المفضلة
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('book_id', widget.bookId);
    } else {
      // إضافة إلى المفضلة
      await supabase.from('favorites').insert({
        'user_id': userId,
        'book_id': widget.bookId,
      });
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorite,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300), // مدة الانتقال
        crossFadeState:
            isFavorite ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: Icon(
          Icons.bookmark,
          size: 24.sp,
          color: kMainColor,
        ), // أيقونة المفضلة
        secondChild: Icon(
          Icons.bookmark_outline,
          size: 24.sp,
          color: kMainColor,
        ), // أيقونة غير مفضلة
      ),
    );
  }
}
