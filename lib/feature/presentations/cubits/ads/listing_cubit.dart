import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // لازم عشان compute
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/repositoris/online_repo.dart';
import '../../../../core/utils/global_methods/global_methods.dart';
import '../../../../core/utils/online_repo/dio_handling.dart';
import '../../../data/models/ads/ads_model.dart';
import 'listing_state.dart';
import 'dart:developer' as dev;

/// فانكشن لفصل عملية البارسينج الثقيلة
List<ListingModel> parseListings(List<dynamic> data) {
  return data.map((json) => ListingModel.fromJson(json)).toList();
}

class ListingCubit extends Cubit<ListingState> {
  late final OnlineDataRepo _api;

  ListingCubit(this._api) : super(ListingInitial());

  static ListingCubit get(context) => BlocProvider.of(context);

  Future<void> fetchAds() async {
    emit(LoadingListingState());
    await Future.delayed(Duration.zero); // 🔥

    try {
      final response = await _api.getData(url: ApiUrls.postAdstUrl);

      if (isSuccessResponse(response: response)) {
        final List<dynamic> rawData = response['data']['data'];
        List<ListingModel> adsModel =
            await compute(parseListings, rawData); // 🔥
        dev.log("the ADS response is ${adsModel[0].title}");
        emit(SuccessListingState(listing: adsModel));
      } else {
        emit(ErrorListingState(message: "Error: ${response['message']}"));
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
      emit(ErrorListingState(message: "Failed to load ads: $e"));
    }
  }

  Future<void> getSingleListing(String id) async {
    emit(LoadingSingleListingState());
    await Future.delayed(Duration.zero); // 🔥

    try {
      final response = await _api.getData(url: '${ApiUrls.postAdstUrl}/$id');

      if (isSuccessResponse(response: response)) {
        ListingModel adsModel = ListingModel.fromJson(response['data']);
        dev.log("the ADS response is ${adsModel.title}");
        emit(SuccessSingleListingState(listing: adsModel));
      } else {
        emit(ErrorListingSingleState(message: "Error: ${response['message']}"));
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
      emit(ErrorListingSingleState(message: "Failed to load ads: $e"));
    }
  }

  Future<void> fetchMyAds() async {
    emit(LoadingListingState());
    await Future.delayed(Duration.zero); // 🔥

    try {
      final response = await _api.getData(url: ApiUrls.postAdstUrl);

      if (isSuccessResponse(response: response)) {
        final allAds = response['data']['data'] as List;
        int myId =
            1; // استبدل لاحقا بـ LocalStorage.getStringFromDisk(key: 'userId')

        List<ListingModel> myAds = (await compute(parseListings, allAds))
            .where((ad) => ad.userId == myId)
            .toList(); // 🔥

        emit(SuccessListingState(listing: myAds));
      } else {
        emit(ErrorListingState(message: "فشل تحميل الإعلانات"));
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
      emit(ErrorListingSingleState(message: "Failed to load ads: $e"));
    }
  }

  Future<void> deleteListing(int id) async {
    try {
      Dio dio = Dio();
      String? token = await LocalStorage.getStringFromDisk(key: TOKEN);

      if (token != null) {
        dio.options.headers = {
          'Authorization': 'Bearer $token',
        };

        final response =
            await dio.delete('http://192.168.93.62:8000/api/listing/$id');

        if (response.statusCode == 200) {
          dev.log('تم حذف الإعلان بنجاح');
          Fluttertoast.showToast(
            msg: 'تم حذف الإعلان بنجاح',
            backgroundColor: Colors.green,
          );

          final adsResponse = await dio.get(ApiUrls.postAdstUrl);

          if (adsResponse.statusCode == 200) {
            List allAds = adsResponse.data['data']['data'];
            int myId = 1; // لو عندك userId مخزن، بدّله هنا
            List myAds = allAds.where((ad) => ad['user_id'] == myId).toList();

            if (myAds.isEmpty) {
              Fluttertoast.showToast(
                msg: 'لا يوجد لديك إعلانات',
                backgroundColor: Colors.orange,
              );
            }
          } else {
            dev.log('فشل تحميل الإعلانات بعد الحذف');
          }
        } else {
          dev.log('حدث خطأ أثناء الحذف: ${response.data}');
          Fluttertoast.showToast(
            msg: 'حدث خطأ أثناء الحذف',
            backgroundColor: Colors.red,
          );
        }
      } else {
        dev.log("التوكن مفقود!");
        Fluttertoast.showToast(
          msg: "التوكن مفقود أو غير صالح",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      dev.log('حدث خطأ أثناء الحذف: $e');
      Fluttertoast.showToast(
        msg: 'حدث خطأ أثناء الحذف',
        backgroundColor: Colors.red,
      );
    }
  }
}
