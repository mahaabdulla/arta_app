import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SharedLoginScaffold extends StatelessWidget {
  SharedLoginScaffold({
    super.key,
    required this.cheldren,
    this.height,
  });
  final List<Widget> cheldren;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF33869C),
            Color(0xFF4E9789),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 185.h,
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: height?? 662.h,
                //  double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 55.w,
                        child: Divider(
                          color: grayBorder,
                          thickness: 4,
                        ),
                      ),
                      vSpace(24.h),
                      ...cheldren
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          child: SvgPicture.asset(
            'assets/svg_images/Intersect 2-2.svg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 64.h,
          ),
        ),
      ),
    );
  }
}
