import 'dart:ui';

import 'package:arta_app/core/utils/myblocobserver.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/helper/shared_preference_helper.dart';
import 'material_app.dart';
import 'package:flutter/foundation.dart'; // ضروري عشان نستخدم kDebugMode

void checkAppMode() {
  if (kDebugMode) {
    print("🛠️ التطبيق يعمل في Debug Mode");
  } else if (kReleaseMode) {
    print("🚀 التطبيق يعمل في Release Mode");
  } else if (kProfileMode) {
    print("📈 التطبيق يعمل في Profile Mode");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefsHelper.init();
  Bloc.observer = MyBlocObserver();

  // sync errors Crashlytics  -  main thread errors
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // async errors Crashlytics - outside main thread  - platform specific errors - api request
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  checkAppMode(); // 👈 تستدعيها هنا قبل تشغيل التطبيق

  runApp(
    ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}
