import 'package:biblio/cubit/user/update_user_favorite_location_cubit/update_user_favorite_location_cubit.dart';
import 'package:biblio/cubit/user/user_favorite_location_cubit/user_favorite_location_cubit.dart';
import 'package:biblio/utils/components/app_indicator.dart';
import 'package:biblio/utils/components/custom_button.dart';
import 'package:biblio/utils/components/custom_textformfield.dart';
import 'package:biblio/utils/components/height.dart';
import 'package:biblio/utils/components/show_snackbar.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteLocationToMeet extends StatefulWidget {
  const FavoriteLocationToMeet({super.key});

  @override
  State<FavoriteLocationToMeet> createState() => _FavoriteLocationToMeetState();
}

class _FavoriteLocationToMeetState extends State<FavoriteLocationToMeet> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  Future<void> getData() async {
    final favoriteLocation =
        context.read<UserFavoriteLocationCubit>().favoriteLocation ?? '';
    final urlLocation =
        context.read<UserFavoriteLocationCubit>().urlLocation ?? '';
    setState(() {
      _controller.text = favoriteLocation;
      _linkController.text = urlLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserFavoriteLocationCubit,
        UpdateUserFavoriteLocationState>(
      listener: (context, state) {
        if (state is UpdateUserFavoriteLocationSuccess) {
          showSnackBar(context, 'تم الحفظ');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final updateCubit = context.read<UpdateUserFavoriteLocationCubit>();
        return BlocConsumer<UserFavoriteLocationCubit,
            UserFavoriteLocationState>(
          listener: (context, state) {
            if (state is UserFavoriteLocationError) {
              showSnackBar(context, state.message);
            }
            if (state is UserFavoriteLocationSuccess) {
              Navigator.pop(context);
              // await Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   NavigationBarApp.id,
              //   (route) => false,
              // );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kScaffoldBackgroundColor,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ),
              body: state is UserFavoriteLocationLoading
                  ? const AppIndicator()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Column(
                        spacing: 12.sp,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 6.sp,

                            /// Header
                            children: [
                              Text(
                                'حدد أماكن اللقاء المفضلة إليك',
                                style: TextStyle(
                                  color: kMainColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/books.svg',
                                height: 20.sp,
                              ),
                            ],
                          ),
                          const H(h: 5),
                          Text(
                            'لا تشارك معلومات خاصة، فقط الأماكن العامة للقاء',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextformfield(
                            maxLines: 3,
                            controller: _controller,
                          ),
                          const H(h: 5),
                          Text(
                            'أضف لينك للموقع الجغرافي -إن أمكن-',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CustomTextformfield(
                            controller: _linkController,
                          ),
                        ],
                      ),
                    ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.sp),
                child: CustomButton(
                  padding: 16,
                  text: 'حفظ',
                  onTap: () async {
                    await updateCubit.updateUserFavoriteLocation(
                      userId: Supabase.instance.client.auth.currentUser!.id,
                      _controller.text,
                      _linkController.text,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
