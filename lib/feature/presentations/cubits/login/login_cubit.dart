import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:arta_app/feature/presentations/pages/login/test_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import '../../../../core/utils/local_repo/secure_storage.dart';
import '../../../data/models/user/user_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late final OnlineDataRepo _api;

  LoginCubit(this._api) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({required String email, required String password}) async {
    emit(LoadingLoginState());
    var data = {'login': email, 'password': password};
    dev.log("the form data is ${data}");
    try {
      final response = await _api.postData(data, ApiUrls.LOGIN);

      if (isSuccessResponse(response: response)) {
        if (response['data']['token'] != null) {
          LocalStorage.saveStringToDisk(
              key: TOKEN, value: response['data']['token']);
        }
        UserModel user = UserModel.fromJson(response['data']['user']);

        await saveUserData(user);
        //TODO: thers a problem here try to fix this
        storeCredentials(password);
        emit(SuccessLoginState(message: response['message'] ?? ""));
      } else {
        emit(ErrorLoginState(message: response['message'] ?? ""));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
    } catch (e) {
      dev.log(e.toString());
      emit(ErrorLoginState(message: "Unexpected error"));
    }
  }
}

void storeCredentials(String password) async {
  final storage = SecureStorage();
  String key = storage.getKeyEncryption();
  String encryptedPassword = storage.encryptPassword(password, key);
  await storage.saveEncryptedPassword(encryptedPassword);
  dev.log('Secure Credentials stored successfully');
}
