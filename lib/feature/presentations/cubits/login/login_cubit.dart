import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var data = FormData.fromMap({'email': email, 'password': password});
    try {
      final response = await _api.postForm(
        url: ApiUrls.LOGIN,
         data: data,
         );
         dev.log(response.toString());
           
        if (isSuccessResponse(response: response)) {
          if (response.data['token']!= null) {
            dev.log(response.data['token'], name: 'token');
            LocalStorage.saveStringToDisk(key: TOKEN, value: response.data['token']);
          }
          UserModel user = UserModel.fromJson(response.data['user']);

          await saveUserData(user);
          await LocalStorage.saveStringToDisk(
          key: LOGINEMAIL,
          value: email,
        );
          storeCredentials(password); 
          emit( SuccessLoginState(message: response.data['message'] ?? ""));
        }else {
          emit(ErrorLoginState(message: response.data['message'] ?? ""));
        }

    } catch (e) {
      dev.log(e.toString());
      emit(const ErrorLoginState(message: "Unexpected error"));
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


