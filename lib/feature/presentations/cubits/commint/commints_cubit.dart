import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:arta_app/feature/data/models/commint/commint.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;
part 'commints_state.dart';

class CommintsCubit extends Cubit<CommintsState> {
  late final OnlineDataRepo _api;

  CommintsCubit(this._api) : super(CommintsInitial());

  static CommintsCubit get(context) => BlocProvider.of(context);

  // post commint
  Future<void> sendCommint(String content, String listing_id) async {
    emit(LoadingCommintState());

    var data = {'content': content, 'listing_id': listing_id};
    dev.log("the form data is $data");
    final token = await LocalStorage.getStringFromDisk(key: TOKEN);

    if (token == null || token.isEmpty) {
      emit(ErrorCommintState(message: 'اسم المتسخدم غير موجود'));
      return;
    }

    try {
      final response = await _api.postData(
        data,
        ApiUrls.COMMINT,
      );

      if (isSuccessResponse(response: response)) {
        final commintData = CommintModel.fromJson(response['data']);
        emit(SuccessCommintState(commint: commintData));
      } else {
        emit(ErrorCommintState(message: response['message'] ?? "حدث خطأ"));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorCommintState(message: errorHandled.errorMessage));
    } catch (e, stackTrace) {
      dev.log("Error sending commint: $e", stackTrace: stackTrace);
      emit(ErrorCommintState(message: "حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }

  // delete commint
}
