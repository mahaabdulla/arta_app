import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:arta_app/feature/presentations/cubits/regetion/regetion_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../data/models/regetion/get_pernte.dart';

class RegetionCubit extends Cubit<RegetionState> {
  late final OnlineDataRepo _api;

  RegetionCubit(this._api) : super(RegetionInitial());

  static RegetionCubit get(context) => BlocProvider.of(context);
  List<RegetionParent> lastCountries = [];

// Regetion Parent  = Contreis
  Future<void> getContreis() async {
    dev.log("getContreis called");
    emit(LoadingRegetionParentState());
    try {
      final response = await _api.getData(url: ApiUrls.REGETION_PARENT);

      if (isSuccessResponse(response: response)) {
        dev.log(" response regetion is success");
        List<RegetionParent> cuntreis = [];

        cuntreis = (response['data'] as List).map((json) {
          dev.log("json item: $json");
          return RegetionParent.fromJson(json);
        }).toList();
        lastCountries = cuntreis;
        dev.log(" the contreis is $cuntreis");

        emit(SuccessRegetionParentState(cities: cuntreis));
      } else {
        emit(ErrorRegetionParentState(message: response['message'] ?? ""));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorRegetionParentState(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log(e.toString());
      emit(ErrorRegetionParentState(message: "Unexpected error"));
    }
  }

  //------------------Regetion Child (Cities)------------------
  Future<void> getCities(int countryId) async {
    emit(LoadingRegetionChildState());
    try {
      final response = await _api.getData(url: ApiUrls.cities(countryId));

      if (isSuccessResponse(response: response)) {
        List<RegetionParent> cities = [];

        cities = (response['data'] as List).map((json) {
          return RegetionParent.fromJson(json);
        }).toList();

        dev.log(" the contreis is $cities");

        emit(SuccessRegetionChildState(regetions: cities));
      } else {
        emit(ErrorRegetionChildState(message: response['message'] ?? ""));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorRegetionChildState(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log(e.toString());
      emit(ErrorRegetionChildState(message: "Unexpected error"));
    }
  }
}
