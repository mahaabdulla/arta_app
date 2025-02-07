

import 'dart:ui';

import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;

import 'package:intl/intl.dart';

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


