import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arta_app/feature/presentations/cubits/change_password/change_password_cubit.dart';
import 'package:arta_app/feature/presentations/pages/user/widgets/profile_scafoold.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "تعديل كلمة المرور",
                  style: TextStyles.medium18,
                ),
                _buildPasswordField(
                    "كلمة المرور القديمة", oldPasswordController),
                _buildPasswordField(
                    "كلمة المرور الجديدة", newPasswordController),
                _buildPasswordField(
                    "تأكيد كلمة المرور", confirmPasswordController),
                SizedBox(height: 20.h),
                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordSuccess) {
                      Fluttertoast.showToast(
                        msg: state.message,
                        backgroundColor: Colors.green,
                      );

                      _formKey.currentState!.reset();
                    } else if (state is ChangePasswordFailure) {
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
                    if (state is ChangePasswordLoading) {
                      return CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ChangePasswordCubit>().changePassword(
                                  oldPassword: oldPasswordController.text,
                                  newPassword: newPasswordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          "حفظ التغيير",
                          style: TextStyles.regulerHeadline
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyles.smallReguler,
          filled: true,
          fillColor: Colors.white,
          // prefixIcon: Icon(Icons.lock, color: Colors.teal),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.teal),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: Colors.teal, width: 2.w),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "يرجى إدخال $label";
          }
          if (label == "تأكيد كلمة المرور" &&
              value != newPasswordController.text) {
            return "كلمات المرور غير متطابقة";
          }
          return null;
        },
      ),
    );
  }
}
