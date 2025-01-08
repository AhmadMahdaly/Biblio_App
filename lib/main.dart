import 'dart:io';

import 'package:biblio/api_key.dart';
import 'package:biblio/biblio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: apiKey(),
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
