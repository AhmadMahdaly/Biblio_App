import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:biblio/cubit/books/fetch_located_books_cubit/fetch_located_books_cubit.dart';
import 'package:biblio/cubit/books/upload_book_cubit/upload_book_cubit.dart';
import 'package:biblio/cubit/favorite_function/favorite_button_cubit/favorite_button_cubit.dart';
import 'package:biblio/cubit/favorite_function/my_favorite_books_list/my_list_cubit.dart';
import 'package:biblio/cubit/messages/create_conversation_cubit/create_conversation_cubit.dart';
import 'package:biblio/cubit/messages/fetch_messages_cubit/fetch_messages_cubit.dart';
import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/cubit/messages/send_message_cubit/send_messages_cubit.dart';
import 'package:biblio/cubit/user/fetch_user_data/fetch_user_data_cubit.dart';
import 'package:biblio/cubit/user/get_user_qty_books_cubit/get_user_qty_books_cubit.dart';
import 'package:biblio/cubit/user/update_user_favorite_location_cubit/update_user_favorite_location_cubit.dart';
import 'package:biblio/cubit/user/update_user_image_cubit/update_user_image_cubit.dart';
import 'package:biblio/cubit/user/user_favorite_location_cubit/user_favorite_location_cubit.dart';
import 'package:biblio/cubit/user/user_location_cubit/save_user_location_cubit.dart';
import 'package:biblio/screens/add_book_page/add_book.dart';
import 'package:biblio/screens/book_item/edit_my_book.dart';
import 'package:biblio/screens/login/login_screen.dart';
import 'package:biblio/screens/login/register_page.dart';
import 'package:biblio/screens/navigation_bar/navigation_bar.dart';
import 'package:biblio/screens/onboard/onboard_screen.dart';
import 'package:biblio/screens/orders_page/order_the_book_page.dart';
import 'package:biblio/screens/splash_screen.dart';
import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Booklink extends StatelessWidget {
  const Booklink({super.key});

  @override
  Widget build(BuildContext context) {
    /// ScreenUtils
    return ScreenUtilInit(
      designSize: const Size(
        390,
        844,
      ),
      minTextAdapt: true,
      child:

          /// Remove focus from any input element
          GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            /// Auth Cubit
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(),
            ),
            BlocProvider<MyListCubit>(
              create: (context) => MyListCubit(),
            ),
            BlocProvider<FavoriteButtonCubit>(
              create: (context) => FavoriteButtonCubit(),
            ),
            BlocProvider<SaveUserLocationCubit>(
              create: (context) => SaveUserLocationCubit(),
            ),
            BlocProvider<UploadBookCubit>(
              create: (context) => UploadBookCubit(),
            ),
            BlocProvider<GetUserQtyBooksCubit>(
              create: (context) => GetUserQtyBooksCubit(),
            ),
            BlocProvider<CreateConversationCubit>(
              create: (context) => CreateConversationCubit(),
            ),
            BlocProvider<FetchMessagesCubit>(
              create: (context) => FetchMessagesCubit(),
            ),
            BlocProvider<FetchUserConversationsCubit>(
              create: (context) => FetchUserConversationsCubit(),
            ),
            BlocProvider<FetchLocatedBooksCubit>(
              create: (context) => FetchLocatedBooksCubit(),
            ),
            BlocProvider<SendMessagesCubit>(
              create: (context) => SendMessagesCubit(),
            ),
            BlocProvider<FetchUserDataCubit>(
              create: (context) => FetchUserDataCubit(),
            ),
            BlocProvider<UpdateUserImageCubit>(
              create: (context) => UpdateUserImageCubit(),
            ),
            BlocProvider<UserFavoriteLocationCubit>(
              create: (context) => UserFavoriteLocationCubit(),
            ),
            BlocProvider<UpdateUserFavoriteLocationCubit>(
              create: (context) => UpdateUserFavoriteLocationCubit(),
            ),
          ],

          /// MaterialApp
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Booklink',

            /// Localizations
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            /// Theme
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: kScaffoldBackgroundColor,
                iconTheme: IconThemeData(
                  color: kMainColor,
                ),
              ),
              scaffoldBackgroundColor: kScaffoldBackgroundColor,
              textTheme: Theme.of(
                context,
              ).textTheme.apply(
                    fontFamily: 'Avenir Arabic',
                  ),
            ),

            /// Routes
            routes: {
              SplashScreen.id: (context) => const SplashScreen(),
              OnboardScreen.id: (context) => const OnboardScreen(),
              LoginScreen.id: (context) => const LoginScreen(),
              RegisterScreen.id: (context) => const RegisterScreen(),
              NavigationBarApp.id: (context) => const NavigationBarApp(),
              AddBook.id: (context) => const AddBook(),
              EditBook.id: (context) => const EditBook(),
              OrderTheBookPage.id: (context) => const OrderTheBookPage(),
            },
            initialRoute: SplashScreen.id,
          ),
        ),
      ),
    );
  }
}
