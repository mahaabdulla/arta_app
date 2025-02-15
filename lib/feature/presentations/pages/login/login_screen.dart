import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/login/login_state.dart';
import 'package:arta_app/feature/presentations/pages/login/test_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:developer' as dev;
import '../../../../core/utils/extensions/app_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            TextFormField(
              controller: _usernameController,
              // focusNode: passFocus,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              // focusNode: passFocus,
              controller: _passwordController,
              onChanged: (value) {
                // TODO: Handle password change
              },
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoadingLoginState) {
                  // TopLoader.startLoading();
                } else if (state is SuccessLoginState) {
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
                  TopLoader.stopLoading();
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
                return SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: state is LoadingLoginState
                          ? null
                          : () async {
                              await LoginCubit.get(context).login(
                                email: _usernameController.text,
                                password: _passwordController.text,
                              );
                            },
                      child: state is LoadingLoginState
                          ? SizedBox(
                              width: 200, // عرض ثابت
                              height: 50, // ارتفاع ثابت
                              child: Center(
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballBeat,
                                  colors: [
                                    primary,
                                    secondary,
                                  ],
                                ),
                              ),
                            )
                          : Text('Login')),
                );
              },
            ),
            Text('Don\'t have an account? Sign Up'),
          ],
        ),
      ),
    );
  }
}
