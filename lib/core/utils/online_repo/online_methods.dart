//=========================GLOBAL DIO METHODS=========================

import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

void logResponse({required String tagKey, required bool isInfo, required response, required String url}) {
  if (LocalStorage.getBoolFromDisk(key: tagKey)) {
    errorLogger(
      isInfo: isInfo,
      statusCode: response.statusCode.toString(),
      url: url,
      responseData: response.data.toString(),
      errorMessage: (response.data['error'] != null) ? response.data['error'].toString() : '',
    );
  }
}


  errorLogger(
      {String? statusCode,
      String? url,
      String? errorMessage,
      String? responseData,
      required bool isInfo}) async {
    dev.log('is info $isInfo', name:'errorLogger' );

     Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        followRedirects: false,
      ),
    );
    Map<String, dynamic> body = {
      "user_id": LocalStorage.getStringFromDisk(key: USERID),
      "user_email": LocalStorage.getStringFromDisk(key: USEREMAIL),
      "status_code": statusCode,
      "url": url,
      "date": DateFormat(
        'dd MMM yyyy - hh:mm a',
      ).format(DateTime.now()),
    };
    if (errorMessage != '') {
      body.addAll({'error_message': errorMessage});
    }
    if (isInfo) {
      body.addAll({'response_data': responseData});
    }

   
    if (isInfo) {
      // await dio.post('${EndPoints.errorLoggerUrl}${EndPoints.infoLogger}', data: body);
    } else {
      // await dio.post('${EndPoints.errorLoggerUrl}${EndPoints.errorLogger}', data: body);
    }
  }

   bool isSuccessResponse({required Response<dynamic> response}) {
    if (response.statusCode! == 200 ||
        response.statusCode! == 201 ||
        response.statusCode! == 204) {
      return true;
    }

    return false;
  }