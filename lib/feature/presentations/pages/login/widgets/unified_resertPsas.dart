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

import 'custom_login_textField.dart';

class UnifiedResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const UnifiedResetPasswordScreen({
    Key? key,
    required this.email,
    required this.otp,
  }) : super(key: key);

  @override
  State<UnifiedResetPasswordScreen> createState() => _UnifiedResetPasswordScreenState();
}

class _UnifiedResetPasswordScreenState extends State<UnifiedResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SharedLoginScaffold(
        height: 902.h,
        cheldren: [
          TitlePage(
            title: "إعادة تعيين كلمة المرور",
            supTitle: "أدخل كلمة المرور الجديدة",
          ),
          vSpace(32.h),
          CustomLoginTextField(
            controller: passwordController,
            hintText: "كلمة المرور الجديدة",
            isPassword: true,
            validator: passwordValidator,
          ),
          vSpace(16.h),
          CustomLoginTextField(
            controller: confirmPasswordController,
            hintText: "تأكيد كلمة المرور",
            isPassword: true,
            validator: (value) => confirmPasswordValidator(value, passwordController.text),
          ),
          vSpace(32.h),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is SuccessLoginState) {
                Fluttertoast.showToast(
                  msg: state.message,
                  backgroundColor: Colors.green,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LOGIN,
                  (route) => false,
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
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().resetPassword(
                                email: widget.email,
                                otp: widget.otp,
                                password: passwordController.text,
                              );
                        }
                      },
                text: 'تحديث كلمة المرور',
              );
            },
          ),
          vSpace(50.h),
        ],
      ),
    );
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'كلمة المرور مطلوبة';
  }
  if (value.length < 6) {
    return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) {
    return 'يرجى تأكيد كلمة المرور';
  }
  if (value != password) {
    return 'كلمة المرور غير متطابقة';
  }
  return null;
}
