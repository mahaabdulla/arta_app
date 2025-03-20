import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/routes/routes_name.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../test_screen.dart';
import 'custom_login_textField.dart';
import 'login_button.dart';
import 'login_by_widget.dart';
import 'title_page.dart';

import 'dart:developer' as dev;

class LoginBody extends StatelessWidget {
  LoginBody({
    super.key,
    required this.title,
    required this.supTitle,
  });
  final String title;
  final String supTitle;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(
      text: kDebugMode
          ? 'admin@hotmail.com'
          : LocalStorage.getStringFromDisk(key: USERE_EMAIL));
  final TextEditingController _passwordController =
      TextEditingController(text: kDebugMode ? '123456789' : null);
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TitlePage(title: title, supTitle: supTitle),
          vSpace(39.h),
          CustomLoginTextField(
            controller: _usernameController,
            hintText: "اسم المستخدم او البريد الإلكتروني",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "هذا الحقل مطلوب";
              }
              //  else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$')
              //     .hasMatch(value)) {
              //   return "الرجاء إدخال بريد إلكتروني صحيح";
              // }
              return null;
            },
          ),
          vSpace(24.h),
          CustomLoginTextField(
            controller: _passwordController,
            hintText: "كلمة السر",
            isPassword: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return "يجب أن تكون كلمة السر 6 أحرف على الأقل";
              }
              return null;
            },
          ),
          vSpace( 39.h),
          BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
            if (state is SuccessLoginState) {
              Fluttertoast.showToast(
                msg: state.message,
                backgroundColor: Colors.green,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestScreen()),
              );
              // Get.to(TestScreen);
              // .then((_) {
              //   TopLoader.stopLoading();
              // });
            } else if (state is ErrorLoginState) {
              // TopLoader.stopLoading();
              toast(
                state.message,
                bgColor: Colors.red,
                print: true,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
              );
            }
          }, builder: (context, state) {
            return LoginButton(
              text: 'تسجيل الدخول',
              state: state,
              onTap: state is LoadingLoginState
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        dev.log("tapped");
                        await LoginCubit.get(context).login(
                          email: _usernameController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
            );
          }),
          LoginByWidget(
            mainText: 'ليس لديك حساب؟',
            secondaryText: 'انشاء حساب',
            navigatorPage: SIGNUP,
          ),
        ],
      ),
    );
  }
}
