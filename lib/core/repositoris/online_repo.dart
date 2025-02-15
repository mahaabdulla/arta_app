import 'dart:convert';

import 'package:arta_app/core/utils/online_repo/online_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:developer' as dev;
import '../constants/api_urls.dart';
import '../constants/global_constants.dart';
import '../utils/global_methods/check_connection.dart';
import '../utils/global_methods/global_methods.dart';
import '../utils/local_repo/cache_helper.dart';
import '../utils/local_repo/local_storage.dart';
import '../utils/online_repo/dio_connection.dart';
import '../utils/online_repo/dio_handling.dart';
import 'data_repo.dart';

class OnlineDataRepo extends DataRepo {
//خليها حاليا كذا بس بعدين اذا صارت مشاكل بعديه
  static final OnlineDataRepo _apiRequest = OnlineDataRepo._();

  OnlineDataRepo._() {
    _init();
  }

  factory OnlineDataRepo() {
    return _apiRequest;
  }

  Dio dio = DioConnection.connect();
  late String _baseUrl;

  Future<void> _init() async {
    _baseUrl = ApiUrls.root;
    log("CHECK BASE URL $_baseUrl");
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 50),
        baseUrl: _baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
        },
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getData(
      {required String url, String? columns}) async {
    Response? response;
    try {
      DioConnection.connect().options.headers.addAll({
        "Authorization": "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
      });

      if (!await checkConnection()) {
        Map<String, dynamic> cachedData = CacheHelper.getCacheData(key: url)
                is Map<String, dynamic>
            ? CacheHelper.getCacheData(key: url)
            : {"status": true, "message": null, "results": [], "error": null};

        response = Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
            data: cachedData);
      } else {
        response = await DioConnection.connect().get(
          url,
        );
        CacheHelper.saveCacheData(
            key: url, data: response.data, isOnline: true);
      }

      // Response<String> serverResponse = await DioConnection.connect().get(url);


           //تأكدي من ذا 
      // Map<String, dynamic> content = jsonDecode(response.data!);
      // return content;
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      log("Dio Error: ${errorHandled.errorMessage}");
      return {"status": false, "message": errorHandled.errorMessage};
    } catch (ex) {
      if (response?.statusCode == 401) {
        log("ON ERROR Unauthorized : ${response?.statusCode}");
      }
      return {"status": false, "message": "An error occurred: $ex"};
    }
     return response.data;
  }

  @override
  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> dataToSend, String url) async {
    DioConnection.connect().options.headers.addAll({
      "Authorization": "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
    });

    Response? response;
    try {
      if (!await checkConnection()) {
        await CacheHelper.saveCacheData(
          key: url,
          data: dataToSend,
          isOnline: false,
        );
        response = Response(
            requestOptions: RequestOptions(), statusCode: 200, data: {});
      } else {
        response = await dio.post(
          url,
          data: dataToSend,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response.statusCode == 401) {
          dev.log("ON ERROR Unauthorized : ${response.statusCode}");
        }
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      dev.log("Dio Error: ${errorHandled.errorMessage}");
      return {"status": false, "message": errorHandled.errorMessage};
    } catch (e) {
      return {"status": false, "message": "An error occurred: $e"};
    }
    // content = response.data;
    // jsonDecode(response.data!);
    if (response.data == null) {
      return {"status": false, "message": "Response data is null"};
    }
    return response.data;
  }


  Future<Response> postForm(
      {required String url,
      required FormData data,
      Map<String, dynamic>? query,
      Map? jsonData}) async {
    // dio.options.headers.addAll({
    //   "Authorization": "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
    // });

    Response? response;
    try {
      if (!await checkConnection()) {
        await CacheHelper.saveCacheData(
          key: url,
          data: jsonData ?? {},
          isOnline: false,
        );
        response = Response(
            requestOptions: RequestOptions(), statusCode: 200, data: {});
        return response;
      } else {
        response = await dio.post(
          url,
          queryParameters: query,
          data: data,
        );
      }
    } catch (e) {}

    dev.log((response?.data['error'] != null).toString());

    return response!;
  }

  @override
  Future<Map<String, dynamic>> deleteData(
      Map<String, dynamic> data, String url) async {
    String deleteUrl = '$url/${data["id"]}';

    DioConnection.connect().options.headers.addAll({
      "Authorization": "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
    });

    Response? response;
    late Map<String, dynamic> content;

    try {
      response = await dio.delete(deleteUrl, data: data);
      content = jsonDecode(response.data!);
      if (content.containsKey("data")) {
        // Map<String, dynamic>? result =
        content["data"];
      }
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      log("Dio Error: ${errorHandled.errorMessage}");
      return {"status": false, "message": errorHandled.errorMessage};
    } catch (e) {
      return {"status": false, "message": "An error occurred: $e"};
    }
    logResponse(tagKey: INFOTAG, isInfo: true, response: response, url: url);
    logResponse(tagKey: ERRORTAG, isInfo: false, response: response, url: url);
    return content;
  }

  @override
  Future<Map<String, dynamic>> putData(
      Map<String, dynamic> data, String url) async {
    DioConnection.connect().options.headers.addAll({
      "Authorization": "Bearer ${LocalStorage.getStringFromDisk(key: TOKEN)}",
    });
    Response? response;
    // late Map<String, dynamic> content;
    try {
      response = await dio.put(
        url,
        data: data,
      );
      // content = jsonDecode(response.data!);
    } on DioException catch (dioError) {
      final errorHandled = Diohandling.fromDioError(dioError);
      toast(errorHandled.errorMessage,
          gravity: ToastGravity.BOTTOM,
          bgColor: Colors.red,
          textColor: Colors.white,
          print: true);
      log("Dio Error: ${errorHandled.errorMessage}");
      return {"status": false, "message": errorHandled.errorMessage};
    } catch (e) {
      return {"status": false, "message": "An error occurred: $e"};
    }
    logResponse(tagKey: INFOTAG, isInfo: true, response: response, url: url);
    logResponse(tagKey: ERRORTAG, isInfo: false, response: response, url: url);
    return response.data;
  }
}
