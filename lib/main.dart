import 'dart:io';

import 'package:biblio/biblio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyC9i6RaQ2wVSLEIrN4qv4tEGPcQXsFV03Y',
            appId: '1:157744080685:android:d69e8f360d472dac6c55a4',
            messagingSenderId: '157744080685',
            projectId: 'biblio-5960c',
          ),
        )
      : await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const Biblio(),
    ),
  );
}
