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
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;

import '../../../../core/constants/api_urls.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final OnlineDataRepo _api;

  CategoryCubit(this._api) : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  Future<void> getCategoris({bool isHome = false}) async {
    emit(LoadingCategoryState());
    dev.log("🚀 Fetching categories... isHome: $isHome");

    try {
      final response = await _api.getData(url: ApiUrls.PERENT);

      dev.log("📥 API Response: $response");

      if (isSuccessResponse(response: response)) {
        final rawData = response['data'];

        if (rawData is List) {
          List<Category> categories =
              rawData.map((json) => Category.fromJson(json)).toList();

          if (isHome) {
            categories = categories.take(7).toList();
            categories
                .add(Category(id: -1, name: "كل الحراج", image: moreImage));
          }

          dev.log("✅ Parsed ${categories.length} categories");
          emit(SuccessCategoryState(categories: categories));
        } else {
          dev.log("⚠️ Unexpected data format: $rawData");
          emit(ErrorCategoryState(
              message: "خطأ في البيانات المستلمة من السيرفر"));
        }
      } else {
        final errorMsg = response['message'] ?? "فشل في جلب البيانات";
        dev.log("❌ API Error: $errorMsg");
        emit(ErrorCategoryState(message: errorMsg));
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      dev.log("❌ DioException: ${errorHandled.errorMessage}");
      toast(
        errorHandled.errorMessage,
        gravity: ToastGravity.BOTTOM,
        bgColor: Colors.red,
        textColor: Colors.white,
        print: true,
      );
      emit(ErrorCategoryState(message: errorHandled.errorMessage));
    } catch (e) {
      dev.log("❌ Unexpected error: $e");
      emit(ErrorCategoryState(message: "حدث خطأ غير متوقع"));
    }
  }
}
