import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterApplyButton extends StatelessWidget {
  final VoidCallback onTap;

  const FilterApplyButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 355.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 145, 190, 194),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "تطبيق",
            style: TextStyles.mediumHeadline.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
