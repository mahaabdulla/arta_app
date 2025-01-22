import 'package:dio/dio.dart';

class ApiException {
  static handleException(DioException error) {
    if (error.response != null) {
      // إذا كانت هناك استجابة من الخادم (على سبيل المثال، بيانات اعتماد خاطئة)
      switch (error.response!.statusCode) {
        case 400:
          return "طلب غير صالح. يرجى التحقق من المدخلات.";
        case 401:
          return "غير مصرح. اسم المستخدم أو كلمة المرور غير صحيحة.";
        case 403:
          return "طلب مرفوض.";
        case 404:
          return "المورد غير موجود.";
        case 500:
          return "خطأ داخلي في الخادم. يرجى المحاولة لاحقاً.";
        default:
          return "استجابة غير صحيحة برمز الحالة: ${error.response!.statusCode}";
      }
    } else {
      // التعامل مع الأخطاء التي تحدث بسبب مشاكل الاتصال، انتهاء الوقت، وما إلى ذلك.
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "انتهاء مهلة الاتصال. يرجى المحاولة مرة أخرى.";
        case DioExceptionType.sendTimeout:
          return "انتهاء مهلة الإرسال. يرجى المحاولة مرة أخرى.";
        case DioExceptionType.receiveTimeout:
          return "انتهاء مهلة الاستلام. يرجى المحاولة مرة أخرى.";
        case DioExceptionType.connectionError:
          return "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.";
        case DioExceptionType.cancel:
          return "تم إلغاء الطلب.";
        default:
          return "حدث خطأ غير معروف.";
      }
    }
  }
}
