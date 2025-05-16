import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/repositoris/online_repo.dart';
import '../../../../core/utils/global_methods/global_methods.dart';
import '../../../../core/utils/online_repo/dio_handling.dart';
import '../../../data/models/ads/ads_model.dart';
import 'listing_state.dart';
import 'dart:developer' as dev;

class ListingCubit extends Cubit<ListingState> {
  late final OnlineDataRepo _api;

  List<ListingModel> _listing = []; // الإعلانات الأصلية
  List<ListingModel> _filteredListing = []; // الإعلانات المفلترة

  ListingCubit(this._api) : super(ListingInitial());

  static ListingCubit get(context) => BlocProvider.of(context);

  Future<void> fetchAds() async {
    emit(LoadingListingState());
    try {
      final response = await _api.getData(
        url: ApiUrls.postAdstUrl,
      );

      if (isSuccessResponse(response: response)) {
        dev.log('${response}');
        List<ListingModel> adsModel = (response['data']['data'] as List)
            .map((json) => ListingModel.fromJson(json))
            .toList();
        dev.log('${adsModel}');
        _listing = adsModel; // تخزين الإعلانات الأصلية
        _filteredListing = _listing; // تعيين الإعلانات المفلترة لجميع الإعلانات

        emit(SuccessListingState(
          listing: _listing,
          filteredListing: _filteredListing,
        ));
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
    try {
      final response = await _api.getData(
        url: '${ApiUrls.postAdstUrl}/$id',
      );

      if (isSuccessResponse(response: response)) {
        ListingModel adsModel = ListingModel.fromJson(response['data']);
        dev.log("the ADS responce is ${adsModel.title}");
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

  void searchInAds(String query) {
    if (query.isEmpty) {
      _filteredListing = _listing;
    } else {
      _filteredListing = _listing.where((ad) {
        return ad.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
      }).toList();
    }

    emit(SuccessListingState(
      listing: _listing,
      filteredListing: _filteredListing,
    ));
  }

  // filter function
  void filterAds({
    String? city,
    String? region,
    double? priceLimit,
    bool isPriceAbove = false,
  }) {
    dev.log('Filtering ads with: city=$city, region=$region, priceLimit=$priceLimit, isPriceAbove=$isPriceAbove');
    
    List<ListingModel> filteredAds = List.from(_listing);

    // فلترة حسب المدينة والمنطقة
    if (_hasLocationFilter(city, region)) {
      filteredAds = _filterByLocation(filteredAds, city, region);
    }

    // فلترة حسب السعر
    if (priceLimit != null) {
      filteredAds = _filterByPrice(filteredAds, priceLimit, isPriceAbove);
    }

    // ترتيب حسب السعر
    filteredAds = _sortByPrice(filteredAds, isPriceAbove);

    dev.log('Filtered ads count: ${filteredAds.length}');
    _filteredListing = filteredAds;
    
    // إظهار رسالة إذا لم توجد إعلانات
    if (filteredAds.isEmpty) {
      String location = '';
      if (city != null && city.isNotEmpty) {
        location += city;
      }
      if (region != null && region.isNotEmpty) {
        if (location.isNotEmpty) location += ' - ';
        location += region;
      }
      
      Fluttertoast.showToast(
        msg: 'لا توجد إعلانات في $location',
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
    
    emit(SuccessListingState(
      listing: _listing,
      filteredListing: _filteredListing,
    ));
  }

  // التحقق من وجود فلتر للموقع
  bool _hasLocationFilter(String? city, String? region) {
    return (city != null && city.isNotEmpty) || (region != null && region.isNotEmpty);
  }

  // فلترة حسب الموقع
  List<ListingModel> _filterByLocation(
    List<ListingModel> ads,
    String? city,
    String? region,
  ) {
    return ads.where((ad) {
      final adRegion = ad.region?.name?.toLowerCase() ?? '';
      final searchCity = city?.toLowerCase() ?? '';
      final searchRegion = region?.toLowerCase() ?? '';
      
      dev.log('Comparing region: $adRegion with city: $searchCity and region: $searchRegion');
      
      // إذا تم تحديد المنطقة فقط
      if (region != null && region.isNotEmpty && (city == null || city.isEmpty)) {
        final matchesRegion = adRegion.contains(searchRegion);
        dev.log('Region match: $matchesRegion');
        return matchesRegion;
      }
      
      // إذا تم تحديد المدينة فقط
      if (city != null && city.isNotEmpty && (region == null || region.isEmpty)) {
        final matchesCity = adRegion.contains(searchCity);
        dev.log('City match: $matchesCity');
        return matchesCity;
      }
      
      // إذا تم تحديد كلاهما
      if (city != null && city.isNotEmpty && region != null && region.isNotEmpty) {
        final matchesRegion = adRegion.contains(searchRegion);
        dev.log('Region match: $matchesRegion');
        return matchesRegion;
      }
      
      return false;
    }).toList();
  }

  // فلترة حسب السعر
  List<ListingModel> _filterByPrice(
    List<ListingModel> ads,
    double priceLimit,
    bool isPriceAbove,
  ) {
    return ads.where((ad) {
      final price = double.tryParse(ad.price ?? '0') ?? 0;
      dev.log('Comparing price: $price with limit $priceLimit');
      return isPriceAbove ? price >= priceLimit : price <= priceLimit;
    }).toList();
  }

  // ترتيب حسب السعر
  List<ListingModel> _sortByPrice(
    List<ListingModel> ads,
    bool isPriceAbove,
  ) {
    return List.from(ads)..sort((a, b) {
      final priceA = double.tryParse(a.price ?? '0') ?? 0;
      final priceB = double.tryParse(b.price ?? '0') ?? 0;
      return isPriceAbove
          ? priceB.compareTo(priceA) // ترتيب تنازلي
          : priceA.compareTo(priceB); // ترتيب تصاعدي
    });
  }

  Future<void> fetchMyAds() async {
    emit(LoadingListingState());
    try {
      final response = await _api.getData(url: ApiUrls.postAdstUrl);

      if (isSuccessResponse(response: response)) {
        final allAds = response['data']['data'] as List;
        int myId = 1;

        List<ListingModel> myAds = allAds
            .where((json) => json['user_id'] == myId)
            .map((json) => ListingModel.fromJson(json))
            .toList();

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

  // حذف الإعلان
  Future<void> deleteListing(int id) async {
    try {
      Dio dio = Dio();
      String? token = await LocalStorage.getStringFromDisk(key: TOKEN);

      if (token != null) {
        dio.options.headers = {
          'Authorization': 'Bearer $token',
        };

        final response = await dio.delete(
          'http://192.168.93.62:8000/api/listing/$id',
        );

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
