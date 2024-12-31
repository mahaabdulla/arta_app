import 'package:arta_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

const String appFont = 'appFont';

abstract class TextStyles {
  static const TextStyle largeHeadLine = TextStyle(
    fontFamily: appFont,
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headLine1 = TextStyle(
    fontFamily: appFont,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle regulerHeadline = TextStyle(
    fontFamily: appFont,
    fontSize: 20,
    color: darkText,
  );

  static const TextStyle medium24 = TextStyle(
    fontFamily: appFont,
    fontSize: 20,
    color: Color(0xff1A5C63),
  );
  static const TextStyle medium22 = TextStyle(
    fontFamily: appFont,
    fontSize: 20,
    color: Colors.black,
  );

  static const TextStyle mediumHeadline = TextStyle(
    fontFamily: appFont,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: darkText,
  );

  static const TextStyle medium18 = TextStyle(
    fontFamily: appFont,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkText,
  );
  static const TextStyle smallReguler = TextStyle(
    fontFamily: appFont,
    fontSize: 16,
    color: darkText,
  );

  static const TextStyle reguler14 = TextStyle(
    fontFamily: appFont,
    fontSize: 14,
    color: greyText,
  );

  static const TextStyle reguler12 = TextStyle(
    fontFamily: appFont,
    fontSize: 12,
    color: Color(0xff0B2729),
  );
}
