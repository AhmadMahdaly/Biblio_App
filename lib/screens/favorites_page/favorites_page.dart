import 'package:biblio/cubit/my_list/my_list_cubit.dart';
import 'package:biblio/screens/favorites_page/widgets/empty_favorite_books.dart';
import 'package:biblio/screens/favorites_page/widgets/favorite_grid_books.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:biblio/widgets/login_user_not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyListCubit>().showMyFavoriteBooks();
  }

  /// دالة التحديث عند السحب
  Future<void> _refreshData() async {
    await context.read<MyListCubit>().showMyFavoriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyListCubit>();
    return BlocConsumer<MyListCubit, MyListState>(
      listener: (context, state) {
        if (state is MyListError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          strokeWidth: 0.9,
          color: kMainColor,
          onRefresh: _refreshData,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                'قائمة الكتب المفضلة',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.sp,
                ),
              ),
            ),
            body: state is MyListLoading
                ? const AppIndicator()
                : context.read<MyListCubit>().supabase.auth.currentUser == null
                    ? const LoginUserNotFound()
                    : cubit.books.isEmpty
                        ? const EmptyFavoriteBooks()
                        : FavoritesGridBooks(cubit: cubit),
          ),
        );
      },
    );
  }
}
