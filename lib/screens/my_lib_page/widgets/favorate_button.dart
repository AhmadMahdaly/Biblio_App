import 'package:biblio/cubit/favorite_button_cubit/favorite_button_cubit.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<FavoriteButtonCubit>().loadFavoriteState(
          bookId: widget.bookId,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteButtonCubit>();
    return BlocConsumer<FavoriteButtonCubit, FavoriteButtonState>(
      listener: (context, state) {
        if (state is FavoriteButtonError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () => cubit.toggleFavorite(bookId: widget.bookId),
          child: state is FavoriteButtonLoading
              ? const AppIndicator(
                  size: 10,
                )
              : AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300), // مدة الانتقال
                  crossFadeState: cubit.isFavorite
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
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
      },
    );
  }
}
