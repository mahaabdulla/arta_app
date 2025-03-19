import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginByWidget extends StatelessWidget {
  const LoginByWidget({
    super.key,
    required this.mainText,
    required this.secondaryText,
    required this.navigatorPage,
  });
  final String mainText;
  final String secondaryText;
  final String navigatorPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vSpace(32.h),
        Row(children: [
          Expanded(child: Divider(color: Colors.black)),
          Expanded(
            flex: 2,
            child: Text(
              "أو سجل الدخول عبر",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.62.h,
                ),
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.black)),
        ]),
        vSpace(24.h),
        GestureDetector(
          onTap: () {
            // TODO: implement login by google here
          },
          child: SvgPicture.asset(googleLogo),
        ),
        vSpace(24.h),
        RichText(
          text: TextSpan(
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                color: Color(0xFF474747),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            children: <TextSpan>[
              TextSpan(text: mainText),
              TextSpan(
                text: secondaryText,
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                    color: Color(0xFF1A5249),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //
                    Navigator.pushNamed(context, navigatorPage);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('انتقلت إلى صفحة إنشاء حساب!')),
                    // );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
