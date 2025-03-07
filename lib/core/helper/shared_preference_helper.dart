import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();


  static String? getString(String key) {
    return SharedPrefsHelper.instance.getString(key);
  }

  static int? getInt(String key) {
    return SharedPrefsHelper.instance.getInt(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await SharedPrefsHelper.instance.setString(key, value);
  }

   static Future<bool> setInt(String key, int value) async {
    return await SharedPrefsHelper.instance.setInt(key, value);
  }

   static Future<bool> setBool(String key, bool value) async {
    return await SharedPrefsHelper.instance.setBool(key, value);
  }

   static bool? getBool(String key) {
    return SharedPrefsHelper.instance.getBool(key);
  }
  
  static Future<bool> removeString(String key)async{
    return await SharedPrefsHelper.instance.remove(key);
  }



  


}