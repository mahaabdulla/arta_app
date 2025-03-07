import 'package:flutter/material.dart';


import 'widgets/login_body.dart';
import 'widgets/shred_login_scaffold.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedLoginScaffold(
      cheldren: [
        LoginBody(
          title: "تسجيل الدخول",
          supTitle: "اهلا بعودتك مجددا استمتع معنا بتجربة مميزة!",
        ),
      ],
    );
  }
}




/*
Center(
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

*/