import 'package:arta_app/core/routes/routes_name.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_state.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/login_button.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/shred_login_scaffold.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/title_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/custom_login_textField.dart';
import 'widgets/login_by_widget.dart';

class SginupScreen extends StatelessWidget {
  SginupScreen({super.key}) {
    fields = [
      {"hint_text": "الاسم", "isPassword": false, "validator": nameValidator},
      {"hint_text": "الايميل", "isPassword": false, "validator": emailValidator},
      {
        "hint_text": "كلمة المرور",
        "isPassword": true,
        "validator": passwordValidator
      },
      {
        "hint_text": "تأكيد كلمة المرور",
        "isPassword": true,
        "validator": (value) => confirmPasswordValidator(value, controllers[2].text)
      },
      {"hint_text": "رقم الجوال", "isPassword": false, "validator": phoneValidator},
      {"hint_text": "رقم الواتساب", "isPassword": false, "validator": phoneValidator},
    ];

    controllers = List.generate(
      6,
      (index) => TextEditingController(
          text: kDebugMode ? controllersText[index] : null),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> controllersText = [
    'UserName',
    'userEmail@gmail.com',
    '1234567890',
    '1234567890',
    '777777777',
    '777777777',
  ];

  late final List<TextEditingController> controllers;
  late final List<Map<String, dynamic>> fields;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SharedLoginScaffold(
        height: 902.h,
        cheldren: [
          TitlePage(
              title: "انشاء حساب",
              supTitle: "نرحب بوجودك معنا استمتع بخدماتنا المميزة"),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controllers.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomLoginTextField(
                    controller: controllers[index],
                    hintText: fields[index]['hint_text'],
                    isPassword: fields[index]['isPassword'],
                    validator: fields[index]['validator'],
                  ),
                );
              },
            ),
          ),
BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is SuccessRegisterState) {
      Fluttertoast.showToast(
        msg: state.message,
        backgroundColor: Colors.green,
      );

      if (context.mounted) {
        Future.microtask(() {
          Navigator.pushReplacementNamed(
            context,
            EMAILOTP,
            arguments: controllers[1].text,
          );
        });
      }
    } else if (state is ErrorRegisterState) {
      toast(
        state.message,
        bgColor: Colors.red,
        print: true,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    } else if (state is SuccessLoginState) {
      Fluttertoast.showToast(
        msg: state.message,
        backgroundColor: Colors.green,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        HOME,
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
      onTap: state is LoadingRegisterState
          ? null
          : () async {
              if (formKey.currentState!.validate()) {
                await LoginCubit.get(context).register(
                  name: controllers[0].text,
                  email: controllers[1].text,
                  password: controllers[2].text,
                  confirmPassword: controllers[3].text,
                  phoneNumber: controllers[4].text,
                  whatsappNumber: controllers[5].text,
                );
              }
            },
      text: 'إنشاء حساب',
    );
  },
),

          LoginByWidget(
            mainText: 'لديك حساب بالفعل؟',
            secondaryText: 'سجل الدخول',
            navigatorPage: LOGIN,
          ),
          vSpace(50.h),
        ],
      ),
    );
  }
}

//==============VALIDATORS =======================
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

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'رقم الجوال مطلوب';
  }
  final phoneRegex = RegExp(r'^[0-9]{9}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'رقم الجوال غير صالح، يجب أن يكون مكونًا من 9 أرقام';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'الاسم مطلوب';
  }
  if (value.length < 3) {
    return 'الاسم يجب أن يكون 3 أحرف على الأقل';
  }
  return null;
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
