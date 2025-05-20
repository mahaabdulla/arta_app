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

import 'widgets/custom_login_textField.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SharedLoginScaffold(
        height: 902.h,
        cheldren: [
          TitlePage(
            title: "نسيت كلمة المرور",
            supTitle: "أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور",
          ),
          vSpace(32.h),
          CustomLoginTextField(
            controller: emailController,
            hintText: "البريد الإلكتروني",
            isPassword: false,
            validator: emailValidator,
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
                  EMAILOTP,
                  arguments: emailController.text,
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
                          context.read<LoginCubit>().forgetPassword(
                                email: emailController.text,
                              );
                        }
                      },
                text: 'إرسال رمز التحقق',
              );
            },
          ),
          vSpace(50.h),
        ],
      ),
    );
  }
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'البريد الإلكتروني مطلوب';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'البريد الإلكتروني غير صالح';
  }
  return null;
}