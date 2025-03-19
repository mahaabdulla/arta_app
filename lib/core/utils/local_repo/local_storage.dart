import 'package:arta_app/core/helper/shared_preference_helper.dart';


class LocalStorage {
  LocalStorage._();
  /* static final LocalStorage _localStorage = LocalStorage._();
  LocalStorage._() {
    _init();
  }
  factory LocalStorage() {
    return _localStorage;
  }
  _init() async {
    prefs = await SharedPreferences.getInstance();
  } */

  /* late SharedPreferences prefs;
  LocalStorage({
    required this.prefs,
  }); */
  //LocalStorage({required this.prefs});
  /// Write
  static Future<bool> saveStringToDisk(
      {required String key, required String value}) async {
    return await SharedPrefsHelper.setString(key, value);
  }

  static Future<bool> saveBoolToDisk(
      {required String key, required bool value}) async {
    return await SharedPrefsHelper.setBool(key, value);
  }

  /// Read
  static String getStringFromDisk({required String key}) {
    return SharedPrefsHelper.getString(key) ?? '';
  }

  /// Read
  static bool getBoolFromDisk({required String key}) {
    return SharedPrefsHelper.getBool(key) ?? false;
  }

  static Future<bool> removeValueFromDisk({required String key}) async {
    return await SharedPrefsHelper.removeString(key);
  }

  static Future<bool> removeAllFromDisk() async {
    return true;
  }


}
