import 'package:dio/dio.dart';

class HttpHelper {
  /////////////////////singleton
  static HttpHelper? httpHelper;
  HttpHelper._();
  static HttpHelper get instance {
    if (httpHelper == null) httpHelper = HttpHelper._();
    return httpHelper!;
  }

  /////////////////////////////
  Dio d = Dio();

  Future<Response> getRequest({required String url}) async {
    try {
      return await d.get(url);
    } catch (e) {
      print('GET Request Error: $e');
      rethrow; // لإعادة إرسال الخطأ إلى المكان الذي استُدعيت منه
    }
  }

  Future<Response> postRequest({
    required String url,
    required dynamic data,
    Options? options,
  }) async {
    try {
      return await d.post(url, data: data, options: options);
    } catch (e) {
      print('POST Request Error: $e');
      rethrow; // لإعادة إرسال الخطأ إلى المكان الذي استُدعيت منه
    }
  }
}
