import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;
import '../../../../core/utils/online_repo/dio_handling.dart';
import '../../../../core/constants/api_urls.dart';
import '../../../../core/utils/online_repo/online_methods.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  late final OnlineDataRepo _api;

  ChangePasswordCubit(this._api) : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    var data = {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': confirmPassword,
    };

    dev.log("Sending change password request with data: $data");

    try {
      final response = await _api.postData(data, ApiUrls.CHANGEPASSOWRD);

      final Map<String, dynamic> responseData =
          response.cast<String, dynamic>();

      if (isSuccessResponse(response: responseData)) {
        emit(ChangePasswordSuccess(
            message: responseData['message'] ?? "تم تغيير كلمة المرور بنجاح"));
      } else {
        emit(ChangePasswordFailure(
            message: responseData['message'] ?? "تغيير كلمة المرور فشل"));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      emit(ChangePasswordFailure(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log("Unexpected error: ${e.toString()}");
      emit(ChangePasswordFailure(message: "Unexpected error"));
    }
  }
}
