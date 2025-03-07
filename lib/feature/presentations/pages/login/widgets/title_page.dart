import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({
    super.key,
    required this.title,
    required this.supTitle,
  });

  final String title;
  final String supTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: Color(0xFF0F5E51),
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        vSpace(8.h),
        Text(
          supTitle,
          style: GoogleFonts.cairo(
            textStyle: TextStyle(
              color: Color(0xFF015249),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        // vSpace(18.h),
      ],
    );
  }
}
