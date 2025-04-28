import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/utils/online_repo/dio_handling.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:arta_app/feature/data/models/category.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/constants/api_urls.dart';

class CategoryCubit extends Cubit<CategoryState> {
  late final OnlineDataRepo _api;

  CategoryCubit(this._api) : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  Future<void> getCategoris({bool isHome = false}) async {
    emit(LoadingCategoryState());
    try {
      final response = await _api.getData(url: ApiUrls.PERENT);

      if (isSuccessResponse(response: response)) {
        List<Category> categories = [];
        // UserModel user = UserModel.fromJson(response['data']['user']);
        if (isHome) {
          categories = (response['data'] as List)
              .take(7)
              .map((json) => Category.fromJson(json))
              .toList();

          categories.add(Category(id: -1, name: "كل الحراج", image: moreImage));
        } else {
          categories = (response['data'] as List)
              .map((json) => Category.fromJson(json))
              .toList();
        }

        // List<Category> categories = data.take(7).map((e) => Category.fromJson(e)).toList();
        emit(SuccessCategoryState(categories: categories));
      } else {
        emit(ErrorCategoryState(message: response['message'] ?? ""));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorCategoryState(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log(e.toString());
      emit(ErrorCategoryState(message: "Unexpected error"));
    }
  }

  Future<void> getChildren(int parentId) async {
    emit(LoadingCategoryState());

    try {
      final url = ApiUrls.getChildrenUrl(parentId);
      dev.log('Requesting URL: $url');

      final response = await _api.getData(url: url);
      dev.log('Raw Response: $response');

      if (response != null && response['success'] == true) {
        final List<dynamic> data = response['data'] ?? [];

        List<Children> children =
            data.map((json) => Children.fromJson(json)).toList();

        dev.log('Parsed Children: ${children.length} items');

        emit(SuccessChildrenState(children: children));
      } else {
        final errorMessage =
            response?['message'] ?? "حدث خطأ أثناء تحميل الأطفال.";
        dev.log('API Error: $errorMessage');
        emit(ErrorCategoryState(message: errorMessage));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);

      toast(
        errorHandled.errorMessage,
        gravity: ToastGravity.BOTTOM,
        bgColor: Colors.red,
        textColor: Colors.white,
        print: true,
      );

      dev.log("Dio Error: ${errorHandled.errorMessage}");
      emit(ErrorCategoryState(message: errorHandled.errorMessage));
    } catch (e, stackTrace) {
      dev.log('Unexpected Error: $e', stackTrace: stackTrace);
      emit(ErrorCategoryState(message: "حدث خطأ غير متوقع."));
    }
  }
}
