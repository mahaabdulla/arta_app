// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// import 'handleLocalNotification.dart';

class HandleFirebaseNotification {
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  }

  static handleNotifications(context) async {
    await FirebaseMessaging.instance.subscribeToTopic(
        "all"); // subscribed user to all group, so user will be received notification when admin send to all group

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true,
        alert: true,
        sound:
            true); //presentation options for Apple notifications when received in the foreground.

    FirebaseMessaging.onMessage.listen((message) async {
      log(message.toString());
      return;
    }).onData((data) {
      log("SALIS Notification Van Sales::: ${data.data}");
      if (data.data['app_id'] == 'salis_van_sales') {
        // HandleLocalNotification.showNotification(data.notification?.title ?? '',
        //     data.notification?.body ?? '', data.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      return;
    }).onData((details) {
      log(details.data.toString(), name: 'notification');

      try {
        if (details.data.isNotEmpty) {
          if (Get.currentRoute == details.data['route_name']) {
            Get.back();
            Get.toNamed(details.data['route_name'],
                arguments: [details.data['id']]);
          } else {
            Get.toNamed(details.data['route_name'],
                arguments: [details.data['id']]);
          }
        }
      } catch (e) {
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then(
        (value) => value != null ? _firebaseMessagingBackgroundHandler : false);
    return;
  }

  static String constructFCMPayload(
    String token,
    String title,
    String body,
  ) {
    return jsonEncode({
      "to": token,
      "notification": {
        "sound": "default",
        "body": body,
        "title": title,
        "content_available": true,
        "priority": "high"
      },
      "data": {
        "sound": "default",
        "body": body,
        "title": title,
        "content_available": true,
        "priority": "high"
      }
    });
  }
}
