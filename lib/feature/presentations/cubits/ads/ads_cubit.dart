import 'dart:convert';

import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/repositoris/online_repo.dart';
import '../../../../core/utils/global_methods/global_methods.dart';
import '../../../../core/utils/online_repo/dio_handling.dart';
import '../../../data/models/ads/ads_model.dart';
import 'ads_state.dart';
import 'dart:developer' as dev;

class AdsCubit extends Cubit<AdsState> {
  late final OnlineDataRepo _api;

  AdsCubit(this._api) : super(AdsInitial());

  static AdsCubit get(context) => BlocProvider.of(context);

  int currentPage = 1;
  bool hasMore = true;
  List<dynamic> adsList = [];

  //  Future<void> fetchAds({bool loadMore = false}) async {
  //   if (!hasMore && loadMore) return;

  //   if (!loadMore) {
  //     emit(LoadingAdsState());
  //     currentPage = 1;
  //     adsList.clear();
  //   }

  //   try {
  //     final response = await _api.getData(url: ApiUrls.postAdstUrl,
  //     //  columns: {"page": currentPage}
  //      );

  //     if (isSuccessResponse(response: response)) {
  //       AdsModel adsModel = AdsModel.fromJson(response["data"]);

  //       adsList.addAll(adsModel.data ?? []);
  //       hasMore = adsModel.currentPage! < adsModel.lastPage!;

  //       emit(SuccessAdsState(ads: adsModel));
  //       currentPage++;
  //     } else {
  //       emit(ErrorAdsState(message:  "فشل في جلب الإعلانات"));
  //     }
  //   }on DioException catch (dioError) {
  //     final errorHandled = Diohandling.fromDioError(dioError);
  //     toast(errorHandled.errorMessage,
  //         gravity: ToastGravity.BOTTOM,
  //         bgColor: Colors.red,
  //         textColor: Colors.white,
  //         print: true);
  //     dev.log("Dio Error: ${errorHandled.errorMessage}");
  //   } catch (e) {
  //     emit(ErrorAdsState(message: "خطأ في الاتصال: $e"));
  //   }
  // }

  Future<void> fetchAds() async {
    emit(LoadingAdsState());
    try {
      final response = await _api.getData(
        url: ApiUrls.postAdstUrl,

        //  columns: {"page": currentPage}
      );
      
      if (isSuccessResponse(response: response)) {
        // final jsonResponse = response['data'];
        //  = AdsModel.fromJson(jsonResponse["data"]);
        // AdsModel adsModel = AdsModel.fromJson(jsonResponse["data"]);

        List<ListingModel> adsModel = (response['data']['data'] as List)
            .map((json) => ListingModel.fromJson(json))
            .toList();
            dev.log("the ADS responce is ${adsModel[0].title}");
        emit(SuccessAdsState(listing: adsModel));
      } else {
        emit(ErrorAdsState(message: "Error: ${response['message']}"));
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
      emit(ErrorAdsState(message: "Failed to load ads: $e"));
    }
  }
}
