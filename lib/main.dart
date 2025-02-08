import 'package:biblio/booklink.dart';
import 'package:biblio/utils/controller/connectivity_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// تحقق من الإتصال بالشبكة
  await ConnectivityController.instance.init();
  await EasyLocalization.ensureInitialized();
  // load env
  await dotenv.load();
// initialize supabase
  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) {
      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('ar'),
          startLocale: const Locale('ar'),
          child: const Booklink(),
        ),
      );
    },
  );
}

/// shorebird patch --platforms=android --release-version=1.0.1+2
