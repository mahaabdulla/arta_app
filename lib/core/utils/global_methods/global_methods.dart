

import 'dart:ui';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;

import 'package:get/get.dart';


void log(Object? value) {
  if (!kReleaseMode) print(value);
}

Color getColorFromHex(String hexColor,
    {Color defaultColor = Colors.deepOrangeAccent}) {
  if (hexColor.isEmpty) {
    return defaultColor;
  }

  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  } else {
    return defaultColor;
  }
  if (int.tryParse(hexColor, radix: 16) != null) {
    return Color(int.parse(hexColor, radix: 16));
  } else {
    return defaultColor;
  }
}


void toast(String? value,
    {ToastGravity? gravity,
    length = Toast.LENGTH_SHORT,
    Color? bgColor,
    Color? textColor,
    bool print = false}) {
  if (value!.isEmpty) {
    log(value);
  } else {
    Fluttertoast.showToast(
      msg: value.toString(),
      gravity: gravity,
      toastLength: length,
      backgroundColor: bgColor,
      textColor: textColor,
      timeInSecForIosWeb: 2,
    );
    if (print) log(value);
  }
}
//vertical spacing  between Widgets
vSpace(double height) {
  return SizedBox(
    height: height,
  );
}

//horizontal spacing between Widgets
hSpace(double width) {
  return SizedBox(
    width: width,
  );
}
bool get isArabic {
  return Get.locale?.languageCode == 'ar' ? true : false;
}

bool get isLandscape {
  Orientation currentOrientation = MediaQuery.of(Get.context!).orientation;
  return currentOrientation == Orientation.landscape ? true : false;
}

bool get isTablet {
  return (MediaQuery.of(Get.context!).size.width > 600 && !isLandscape)
      ? true
      : false;
}



