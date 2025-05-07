import 'dart:developer' as dev;

import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegionCubit extends Cubit<RegionState> {
  late final OnlineDataRepo _api;

  RegionCubit(this._api) : super(RegionInitial());

  static RegionCubit get(context) => BlocProvider.of(context);

  // دالة جلب المناطق الرئيسية
  Future<void> getParentRegions() async {
    emit(ParentRegionsLoading());
    dev.log("Fetching parent regions..."); // تتبع بداية جلب البيانات
    try {
      final response = await _api.getData(url: ApiUrls.PARENTS_REGIONS);
      dev.log(
          "Response from parent regions API: ${response.toString()}"); // تتبع الاستجابة من السيرفر

      if (isSuccessResponse(response: response)) {
        final regions = (response['data'] as List)
            .map((json) => RegionModel.fromJson(json))
            .toList();

        emit(ParentRegionsLoaded(regions));
        dev.log(
            "Successfully loaded parent regions: ${regions.length} regions"); // تتبع النجاح
      } else {
        emit(ParentRegionsError(response['message'] ?? "حدث خطأ"));
        dev.log(
            "Error loading parent regions: ${response['message'] ?? 'Unknown error'}"); // تتبع الأخطاء
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log(
          "Dio Error: ${errorHandled.errorMessage}"); // تتبع الخطأ في الاتصال
      emit(ParentRegionsError(errorHandled.errorMessage));
    } catch (e) {
      dev.log("Unexpected error: ${e.toString()}"); // تتبع الخطأ غير المتوقع
      emit(ParentRegionsError("خطأ غير متوقع"));
    }
  }

  // دالة جلب المناطق الفرعية
  Future<void> getChildRegions(int parentId) async {
    emit(ChildRegionsLoading());
    dev.log(
        "Fetching child regions for parentId: $parentId..."); // تتبع بداية جلب البيانات
    try {
      final response = await _api.getData(
          url: ApiUrls.getRegionChildUrl(
              parentId)); // استخدام الدالة الخاصة بعنوان URL
      dev.log(
          "Response from child regions API: ${response.toString()}"); // تتبع الاستجابة من السيرفر

      if (isSuccessResponse(response: response)) {
        final children = (response['data'] as List)
            .map((json) => RegionModel.fromJson(json))
            .toList();

        emit(ChildRegionsLoaded(children));
        dev.log(
            "Successfully loaded child regions: ${children.length} regions"); // تتبع النجاح
      } else {
        emit(ChildRegionsError(response['message'] ?? "حدث خطأ"));
        dev.log(
            "Error loading child regions: ${response['message'] ?? 'Unknown error'}"); // تتبع الأخطاء
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log(
          "Dio Error: ${errorHandled.errorMessage}"); // تتبع الخطأ في الاتصال
      emit(ChildRegionsError(errorHandled.errorMessage));
    } catch (e) {
      dev.log("Unexpected error: ${e.toString()}"); // تتبع الخطأ غير المتوقع
      emit(ChildRegionsError("خطأ غير متوقع"));
    }
  }
}
