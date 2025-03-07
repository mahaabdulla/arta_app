import 'package:arta_app/core/routes/routes_name.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/login_button.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/shred_login_scaffold.dart';
import 'package:arta_app/feature/presentations/pages/login/widgets/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/custom_login_textField.dart';
import 'widgets/login_by_widget.dart';

class SginupScreen extends StatelessWidget {
  SginupScreen({super.key}) {
    fields = [
      {"hint_text": "الاسم", "isPassword": false, "validator": nameValidator},
      {
        "hint_text": "الايميل",
        "isPassword": false,
        "validator": emailValidator
      },
      {
        "hint_text": "كلمة المرور",
        "isPassword": true,
        "validator": passwordValidator
      },
      {
        "hint_text": "تأكيد كلمة المرور",
        "isPassword": true,
        "validator": (value) =>
            confirmPasswordValidator(value, controllers[2].text)
      },
      {
        "hint_text": "رقم الجوال",
        "isPassword": false,
        "validator": phoneValidator
      },
      {
        "hint_text": "رقم الواتساب",
        "isPassword": false,
        "validator": phoneValidator
      },
    ];
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

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
            // height: 1500,
            // width: double.infinity,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                }),
          ),
          LoginButton(
              onTap: () {
                if (formKey.currentState!.validate()) {}
              },
              text: 'إنشاء حساب'),
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
  // تحقق من صحة البريد باستخدام regex
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'البريد الإلكتروني غير صالح';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'رقم الجوال مطلوب';
  }
  // تحقق من صحة رقم الجوال (يجب أن يكون 10 أرقام مثلاً)
  final phoneRegex = RegExp(r'^[0-9]{10}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'رقم الجوال غير صالح، يجب أن يكون مكونًا من 10 أرقام';
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
