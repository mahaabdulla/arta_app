import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginButton extends StatelessWidget {
  LoginButton({
    super.key,
    this.state,
    required this.onTap,
    required this.text,
  });
  final LoginState? state;
  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336.w,
        height: 60.h,
        decoration: ShapeDecoration(
          color: Color(0xFF075E66),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(24),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x26FFFFFF),
              blurRadius: 0,
              offset: Offset(0, 0),
              spreadRadius: 8,
            )
          ],
        ),
        child: Center(
          child: state is LoadingLoginState
              ? SizedBox(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballBeat,
                      colors: [
                        Colors.white,
                        secondary,
                      ],
                    ),
                  ),
                )
              : Text(
                  text,
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
