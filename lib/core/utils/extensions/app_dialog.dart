// import 'package:arta_app/core/constants/colors.dart';
// import 'package:arta_app/core/utils/global_methods/global_methods.dart';
// import 'package:flutter/material.dart';

// class TopLoader {
//   static const SizedBox _container = SizedBox(
//     width: 40,
//     height: 40,
//     child: Center(
//       //TODO: Add custom loading animation here.
//       child: CircularProgressIndicator(color: greenContainer),
//     ),
//   );

//   static void startLoading() {
//     showDialog(
//       barrierColor: Colors.black54,
//       barrierDismissible: false,
//       context: Get.context!,
//       builder: (context) => _container,
//     );
//   }

//   static void stopLoading() {
//     Navigator.of(Get.context!).pop();
//   }

//   static Future loading({required Function function}) async {
//      startLoading();
//      try {
//      await function();
//      }
//      catch (e) {
//       log("Loding error: $e");
//        stopLoading();
//        return;
//      }
//      stopLoading();
//   }
// }

import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../material_app.dart';
import '../../constants/colors.dart';

class TopLoader {
  static void startLoading() {
    if (navigatorKey.currentContext == null) {
      return;
    }

    showDialog(
      barrierColor: Colors.black54,
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: SizedBox(
              width: 70,
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballBeat,
                colors: [
                  primary,
                  secondary,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void stopLoading() {
    if (navigatorKey.currentContext != null) {
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  static Future loading({required Function function}) async {
    startLoading();
    try {
      await function();
    } catch (e) {
      log("Loding error: $e");
      stopLoading();
      return;
    }
    stopLoading();
  }
}
