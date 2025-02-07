
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../enums/toast_enum.dart';

checkConnection({toast = false}) async {
  var response;
  try {
    response = await InternetAddress.lookup('www.google.com').timeout(const Duration(milliseconds: 4000));
  } catch (e) {
    if (toast == true) {
      Fluttertoast.showToast(msg: "no_internet".tr, backgroundColor: chooseToastColor(ToastStates.error));
    }
    return false;
  }
  if (response == null) {
    if (toast == true) {
      Fluttertoast.showToast(msg: "no_internet".tr, backgroundColor: chooseToastColor(ToastStates.error));
    }
    return false;
  } else {
    return true;
  }
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.redAccent;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}