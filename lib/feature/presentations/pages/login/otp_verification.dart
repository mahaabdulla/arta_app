import 'package:arta_app/core/routes/routes_name.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_state.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/login_button.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/shred_login_scaffold.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'dart:developer' as dev;

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SharedLoginScaffold(
      height: 902.h,
      cheldren: [
        TitlePage(
          title: "التحقق من البريد الإلكتروني",
          supTitle: "تم إرسال رمز التحقق إلى ${widget.email}",
        ),
        vSpace(32.h),
        Pinput(
          controller: otpController,
          length: 6,
          mainAxisAlignment: MainAxisAlignment.start,
          onCompleted: (pin) {
            dev.log("OTP entered: $pin");
            if (pin.length == 6) {
              context.read<LoginCubit>().verifyOTP(
                    email: widget.email,
                    otp: pin,
                  );
            }
          },
          defaultPinTheme: PinTheme(
            width: 56.w,
            height: 56.h,
            textStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        vSpace(32.h),
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is SuccessLoginState) {
              Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: Colors.green,
              );
              Navigator.pushNamed(
                context,
                HOME,
                //RESET_PASSWORD,
                arguments: {
                  'email': widget.email,
                  'otp': otpController.text,
                },
              );
            } else if (state is ErrorLoginState) {
              toast(
                state.message,
                bgColor: Colors.red,
                print: true,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
              );
            }
          },
          builder: (context, state) {
            return LoginButton(
              state: state,
              onTap: state is LoadingLoginState
                  ? null
                  : () {
                      if (otpController.text.length == 6) {
                        context.read<LoginCubit>().verifyOTP(
                              email: widget.email,
                              otp: otpController.text,
                            );
                      } else {
                        toast(
                          'الرجاء إدخال رمز التحقق كاملاً',
                          bgColor: Colors.red,
                          print: true,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white,
                        );
                      }
                    },
              text: 'تأكيد',
            );
          },
        ),
        vSpace(16.h),
        Center(
          child: TextButton(
            onPressed: () async {
              try {
                await context.read<LoginCubit>().sendVerificationEmail(widget.email);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم إرسال رمز التحقق إلى بريدك الإلكتروني'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('حدث خطأ أثناء إرسال رمز التحقق'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              'إعادة إرسال رمز التحقق',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        vSpace(50.h),
      ],
    );
  }
}
