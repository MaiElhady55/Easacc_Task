import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easacc_task/core/di/di.dart';
import 'package:easacc_task/core/framework/bloc_observer.dart';
import 'package:easacc_task/easacc_task.dart';
import 'package:easacc_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easacc_task/core/framework/device_info.dart' as di;
import 'package:easacc_task/core/util/routing/app_router.dart';

/// Easy Localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations

/// Di (InjectableInit)
///
/// dart run build_runner build --delete-conflicting-outputs
/// Key Store Google Play
/// keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  await configureDependencies();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    di.DeviceInfo.init(),
    EasyLocalization.ensureInitialized(),
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: EasaccTask(appRouter: AppRouter()),
    ),
  );
}
