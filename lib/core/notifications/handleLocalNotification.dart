// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:arta_app/feature/presentations/pages/login/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../constants/global_constants.dart';
import '../utils/local_repo/local_storage.dart';
// import 'package:salis_seller/core/utils/remote/dio/dio_helper.dart';

// import '../app_router/app_router.dart';
// import '../utils/local_storage.dart';
// import '../utils/remote/endpoints.dart';

class HandleLocalNotification {
  static var buildContext;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initializeFlutterNotification(context) {
    buildContext = context;

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        onSelectNotification(details);
      },
    );
    backgroundClick();
  }

  void backgroundClick() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      if (notificationAppLaunchDetails!.notificationResponse != null) {

        await Future.delayed(const Duration(seconds: 1));
        onSelectNotification(
            notificationAppLaunchDetails.notificationResponse!);
      }
    } else {
      if (notificationAppLaunchDetails!.notificationResponse != null) {
        await Future.delayed(const Duration(seconds: 1));
        onSelectNotification(
            notificationAppLaunchDetails.notificationResponse!);
      }
    }
  }

  static Future<void> onSelectNotification(NotificationResponse details) async {
    try {
      if (details.payload != null) {
        Map notificationModelMap = jsonDecode(details.payload ?? '');
        if (notificationModelMap.isNotEmpty) {
          if (LocalStorage.getStringFromDisk(key: TOKEN).isEmpty) {
            Get.offAll(
              LoginScreen(),
              // AppRouter.loginScreenRoute,
              arguments: 'fromNotification');
          }
          else {
            if (Get.currentRoute == notificationModelMap['route_name']) {
              Get.back();
              Get.toNamed(notificationModelMap['route_name'],
                  arguments: [notificationModelMap['id']]);
            } else {
              Get.toNamed(notificationModelMap['route_name'],
                  arguments: [notificationModelMap['id']]);
            }
          }

          // var api = DioHelper();
          // await api.getData(
          //   url:
          //       '${EndPoints.extention}${EndPoints.notificationsList}/${notificationModelMap['notification_id']}/mark-as-read',
          //   isAuthorized: true,
          // );
        }
      }
    } catch (e) {
    }

  }

  static Future<void> showNotification(
      String title, String body, Map<String, dynamic> data) async {
    log("===================show notification==============");
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: jsonEncode(data));
  }
}
