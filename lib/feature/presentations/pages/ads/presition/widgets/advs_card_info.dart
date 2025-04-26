import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AdvsCardInfo extends StatelessWidget {
  final String title;
  final String location;
  final String userName;
  final String time;
  final String price;

  const AdvsCardInfo({
    required this.title,
    required this.location,
    required this.userName,
    required this.time,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.smallReguler,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SvgPicture.asset(userImage),
            SizedBox(width: 1.w),
            Text(
              userName,
              style: TextStyles.reguler14.copyWith(color: Colors.black),
            ),
            SizedBox(width: 60.w),
            SvgPicture.asset(locationImage),
            SizedBox(width: 1.w),
            Text(
              location,
              style: TextStyles.reguler14.copyWith(color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SvgPicture.asset(clockImage),
            SizedBox(width: 1.w),
            Text(
              time,
              style: TextStyles.reguler14.copyWith(color: Colors.black),
            ),
            SizedBox(width: 15.w),
            SvgPicture.asset(dollerImage),
            SizedBox(width: 1.w),
            Text(
              price,
              style: TextStyles.reguler14.copyWith(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
