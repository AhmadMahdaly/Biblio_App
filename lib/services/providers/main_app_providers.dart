import 'package:biblio/cubit/auth_cubit/auth_cubit.dart';
import 'package:biblio/cubit/books/fetch_located_books_cubit/fetch_located_books_cubit.dart';
import 'package:biblio/cubit/books/upload_book_cubit/upload_book_cubit.dart';
import 'package:biblio/cubit/favorite_function/favorite_button_cubit/favorite_button_cubit.dart';
import 'package:biblio/cubit/favorite_function/my_favorite_books_list/my_list_cubit.dart';
import 'package:biblio/cubit/messages/create_conversation_cubit/create_conversation_cubit.dart';
import 'package:biblio/cubit/messages/fetch_messages_cubit/fetch_messages_cubit.dart';
import 'package:biblio/cubit/messages/fetch_unread_conversation_cubit/fetch_unread_conversation_cubit.dart';
import 'package:biblio/cubit/messages/fetch_unread_message_cubit/fetch_unread_message_cubit.dart';
import 'package:biblio/cubit/messages/fetch_user_conversations_cubit/fetch_user_conversations_cubit.dart';
import 'package:biblio/cubit/messages/send_message_cubit/send_messages_cubit.dart';
import 'package:biblio/cubit/user/fetch_user_data/fetch_user_data_cubit.dart';
import 'package:biblio/cubit/user/get_user_qty_books_cubit/get_user_qty_books_cubit.dart';
import 'package:biblio/cubit/user/request_otp_cubit/request_otp_cubit.dart';
import 'package:biblio/cubit/user/update_user_favorite_location_cubit/update_user_favorite_location_cubit.dart';
import 'package:biblio/cubit/user/update_user_image_cubit/update_user_image_cubit.dart';
import 'package:biblio/cubit/user/user_favorite_location_cubit/user_favorite_location_cubit.dart';
import 'package:biblio/cubit/user/user_location_cubit/save_user_location_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> mainAppProviders() {
  return [
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
    BlocProvider<RequestOtpCubit>(
      create: (context) => RequestOtpCubit(),
    ),
    BlocProvider<FetchUnreadMessageCubit>(
      create: (context) => FetchUnreadMessageCubit(),
    ),
    BlocProvider<FetchUnreadConversationCubit>(
      create: (context) => FetchUnreadConversationCubit(),
    ),
  ];
}
