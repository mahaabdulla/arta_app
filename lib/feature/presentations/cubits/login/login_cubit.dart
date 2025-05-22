import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    var data = {
      'login': email,
      'password': password
    };
    dev.log("=== Login Request ===");
    dev.log("Email: $email");
    dev.log("Request URL: ${ApiUrls.LOGIN}");
    dev.log("Request data: $data");
    
    try {
      final response = await _api.postData(data, ApiUrls.LOGIN);
      dev.log("=== Response Details ===");
      dev.log("Response: $response");
      dev.log("Success: ${response['success']}");
      dev.log("Message: ${response['message']}");

      if (isSuccessResponse(response: response)) {
        if (response['data']['token'] != null) {
          final token = response['data']['token'];
          dev.log("=== Token Details ===");
          dev.log("Token received: $token");
          await LocalStorage.saveStringToDisk(key: TOKEN, value: token);
          final savedToken = await LocalStorage.getStringFromDisk(key: TOKEN);
          dev.log("Token saved: $savedToken");
        }
        UserModel user = UserModel.fromJson(response['data']['user']);
        await saveUserData(user);
        emit(SuccessLoginState(message: response['message'] ?? "تم تسجيل الدخول بنجاح"));
      } else {
        String errorMessage = response['message'] ?? "فشل تسجيل الدخول";
        if (response['errors'] != null) {
          if (response['errors']['login'] != null) {
            errorMessage = response['errors']['login'][0];
          }
        } else if (response['error'] != null) {
          if (response['error'].toString().contains("Invalid credentials")) {
            errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          }
        }
        emit(ErrorLoginState(message: errorMessage));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      dev.log("=== Error Details ===");
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      dev.log("Dio Error Response: ${dioError.response?.data}");
      dev.log("Dio Error Status: ${dioError.response?.statusCode}");
      
      String errorMessage = errorHandled.errorMessage;
      if (dioError.response?.statusCode == 401) {
        errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
      }
      
      toast(errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      emit(ErrorLoginState(message: errorMessage));
    } catch (e) {
      dev.log("Error in login: $e");
      emit(ErrorLoginState(message: "حدث خطأ غير متوقع"));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String whatsappNumber,
  }) async {
    emit(LoadingRegisterState());

    var data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'contact_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
    };

    dev.log("Registration data: $data");

    try {
      final response = await _api.postData(data, ApiUrls.REGISTER);

      if (isSuccessResponse(response: response)) {
        var userData = response['data'];
        UserModel user = UserModel.fromJson(userData);

        // Save user data
        if (userData['id'] != null) {
          await LocalStorage.saveStringToDisk(
              key: 'USER_ID', value: userData['id'].toString());
        }
        if (userData['email'] != null) {
          await LocalStorage.saveStringToDisk(
              key: 'USER_EMAIL', value: userData['email']);
        }
        if (userData['name'] != null) {
          await LocalStorage.saveStringToDisk(
              key: 'USER_NAME', value: userData['name']);
        }
        if (userData['whatsapp_number'] != null) {
          await LocalStorage.saveStringToDisk(
              key: 'USER_WHATSAPP', value: userData['whatsapp_number']);
        }
        if (userData['contact_number'] != null) {
          await LocalStorage.saveStringToDisk(
              key: 'USER_PHONE', value: userData['contact_number']);
        }

        await saveUserData(user);
        
        // Send verification email
        try {
          await sendVerificationEmail(email);
          emit(SuccessRegisterState(message: response['message'] ?? ""));
        } catch (emailError) {
          dev.log("Error sending verification email: $emailError");
          // Still emit success state even if email fails
        emit(SuccessRegisterState(message: response['message'] ?? ""));
        }
      } else {
        emit(ErrorRegisterState(message: response['message'] ?? ""));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorRegisterState(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log(e.toString());
      emit(ErrorRegisterState(message: "Unexpected error"));
    }
  }

  Future<void> sendVerificationEmail(String email) async {
    try {
      dev.log("=== Sending Verification Email ===");
      dev.log("Email: $email");
      dev.log("Request URL: ${ApiUrls.SEND_VERIFICATION_EMAIL}");
      
      final response = await _api.postData(
        {'email': email},
        ApiUrls.SEND_VERIFICATION_EMAIL,
      );

      dev.log("=== Response Details ===");
      dev.log("Response: $response");
      dev.log("Success: ${response['success']}");
      dev.log("Message: ${response['message']}");

      if (response['success'] == true) {
        dev.log("Verification email sent successfully");
        toast(
          response['message'] ?? "تم إرسال رمز التحقق إلى بريدك الإلكتروني",
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.green,
          textColor: Colors.white,
          print: true,
        );
      } else {
        dev.log("Failed to send verification email");
        toast(
          response['message'] ?? "فشل في إرسال رمز التحقق",
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true,
        );
      }
    } catch (e) {
      dev.log("Error sending verification email: $e");
      toast(
        "حدث خطأ أثناء إرسال رمز التحقق",
        gravity: ToastGravity.BOTTOM,
        bgColor: Colors.red,
        textColor: Colors.white,
        print: true,
      );
    }
  }

  Future<void> verifyOTP({required String email, required String otp}) async {
    emit(LoadingLoginState());
    try {
      dev.log("=== OTP Verification Request ===");
      dev.log("Email: $email");
      dev.log("OTP: $otp");
      dev.log("Request URL: ${ApiUrls.VERIFY_OTP}");
      
      final response = await _api.postData(
        {
          'email': email,
          'otp': otp.trim(),
        },
        ApiUrls.VERIFY_OTP,
      );

      dev.log("=== Response Details ===");
      dev.log("Response: $response");
      dev.log("Success: ${response['success']}");
      dev.log("Message: ${response['message']}");

      if (response['success'] == true) {
        dev.log("OTP verification successful");
        try {
          // Save token if available
          if (response['data'] != null && response['data']['token'] != null) {
            final token = response['data']['token'].toString();
            await LocalStorage.saveStringToDisk(key: TOKEN, value: token);
            dev.log("Token saved successfully");
          }

          // Save user data if available
          if (response['data'] != null && response['data']['user'] != null) {
            final userData = response['data']['user'];
            if (userData is Map<String, dynamic>) {
            UserModel user = UserModel.fromJson(userData);
            await saveUserData(user);
            dev.log("User data saved successfully");
            }
          }

          emit(SuccessLoginState(message: response['message'] ?? "تم التحقق بنجاح"));
        } catch (saveError) {
          dev.log("Error saving data: $saveError");
          // Still emit success since verification was successful
          emit(SuccessLoginState(message: response['message'] ?? "تم التحقق بنجاح"));
        }
      } else {
        dev.log("OTP verification failed");
        String errorMessage = response['message'] ?? "رمز التحقق غير صحيح";
        if (response['errors'] != null) {
          if (response['errors']['otp'] != null) {
            errorMessage = response['errors']['otp'][0];
          }
        }
        emit(ErrorLoginState(message: errorMessage));
      }
    } catch (e) {
      dev.log("Error in verifyOTP: $e");
      emit(ErrorLoginState(message: "حدث خطأ غير متوقع"));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(LoadingLoginState());
    try {
      dev.log("=== Forget Password Request ===");
      dev.log("Email: $email");
      dev.log("Request URL: ${ApiUrls.FORGET_PASSWORD}");
      
      final response = await _api.postData(
        {'email': email},
        ApiUrls.FORGET_PASSWORD,
      );

      dev.log("=== Response Details ===");
      dev.log("Response: $response");
      dev.log("Success: ${response['success']}");
      dev.log("Message: ${response['message']}");

      if (response['success'] == true) {
        dev.log("Forget password request successful");
        emit(SuccessLoginState(message: response['message'] ?? "تم إرسال رمز التحقق إلى بريدك الإلكتروني"));
      } else {
        dev.log("Forget password request failed");
        String errorMessage = response['message'] ?? "فشل في إرسال رمز التحقق";
        if (errorMessage.contains("Record not found")) {
          errorMessage = "البريد الإلكتروني غير مسجل في النظام";
        }
        emit(ErrorLoginState(message: errorMessage));
      }
    } catch (e) {
      dev.log("Error in forgetPassword: $e");
      emit(ErrorLoginState(message: "حدث خطأ غير متوقع"));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    emit(LoadingLoginState());
    try {
      dev.log("=== Reset Password Request ===");
      dev.log("Email: $email");
      dev.log("OTP: $otp");
      dev.log("Request URL: ${ApiUrls.RESET_PASSWORD}");
      
      // Validate OTP format
      if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
        emit(ErrorLoginState(message: "رمز التحقق غير صالح"));
        return;
      }

      final response = await _api.postData(
        {
          'email': email,
          'otp': otp.trim(),
          'password': password,
          'password_confirmation': password,
        },
        ApiUrls.RESET_PASSWORD,
      );

      dev.log("=== Response Details ===");
      dev.log("Response: $response");
      dev.log("Success: ${response['success']}");
      dev.log("Message: ${response['message']}");

      if (response['success'] == true) {
        dev.log("Password reset successful");
        emit(SuccessLoginState(message: response['message'] ?? "تم إعادة تعيين كلمة المرور بنجاح"));
      } else {
        dev.log("Password reset failed");
        String errorMessage = response['message'] ?? "فشل في إعادة تعيين كلمة المرور";
        
        // Handle specific error cases
        if (response['errors'] != null) {
          if (response['errors']['otp'] != null) {
            errorMessage = response['errors']['otp'][0];
          } else if (response['errors']['email'] != null) {
            errorMessage = response['errors']['email'][0];
          } else if (response['errors']['password'] != null) {
            errorMessage = response['errors']['password'][0];
          }
        } else if (errorMessage.contains("expired")) {
          errorMessage = "رمز التحقق منتهي الصلاحية";
        } else if (errorMessage.contains("invalid")) {
          errorMessage = "رمز التحقق غير صحيح";
        }
        
        emit(ErrorLoginState(message: errorMessage));
      }
    } on DioException catch (dioError) {
      dev.log("Dio Error: ${dioError.message}");
      dev.log("Dio Error Response: ${dioError.response?.data}");
      dev.log("Dio Error Status: ${dioError.response?.statusCode}");
      
      String errorMessage = "حدث خطأ في الاتصال بالخادم";
      if (dioError.response?.statusCode == 404) {
        errorMessage = "عنوان الخادم غير صحيح";
      } else if (dioError.response?.statusCode == 401) {
        errorMessage = "غير مصرح لك بإجراء هذه العملية";
      }
      
      emit(ErrorLoginState(message: errorMessage));
    } catch (e) {
      dev.log("Error in resetPassword: $e");
      emit(ErrorLoginState(message: "حدث خطأ غير متوقع"));
    }
  }

  void storeCredentials(String password) {
    final storage = SecureStorage();
    String key = storage.getKeyEncryption();
    String encryptedPassword = storage.encryptPassword(password, key);
    storage.saveEncryptedPassword(encryptedPassword);
    dev.log('Secure Credentials stored successfully');
  }
}