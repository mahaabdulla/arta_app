import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class DetailsBottum extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;
  String? imagePath;
  DetailsBottum(
      {super.key,
      required this.onTap,
      required this.color,
      required this.text,
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 35.h,
          width: 121.w,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyles.reguler14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (imagePath != null) SvgPicture.asset(imagePath!)
            ],
          ),
        ),
      ),
    );
  }
}
