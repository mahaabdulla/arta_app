import 'dart:convert';
import 'dart:developer' as dev;
import 'local_storage.dart';

class CacheHelper {
  CacheHelper._();
  // date of the key (if changes you will not be able to get the cache)
  static final String _date = DateTime.now().toString().substring(0, 10);
  // to get data that was cached it return either a map or list of map
  static getCacheData({required String key, bool wasOnline = true}) {
    // the key field is usually the url
    // status of the user when they saved the data
    String status = wasOnline ? 'online' : 'offline';
    // the cache key to access the data
    String cacheKey = json.encode({'key': key, 'date': _date, 'status': status});
    // data as a string
    String stringifyData = LocalStorage.getStringFromDisk(key: cacheKey);
    // data variable a map of list of map
    var data;
    try {
      // decode the string into json
      data = json.decode(stringifyData);
    } catch (e) {
      // when stringifyData is empty or decode fails return empty map
      data = {};
    }
    dev.log('i am get data : $stringifyData');
    return data;
  }

  // save data into cache
  static Future<void> saveCacheData({required String key,required Map data,bool isList = false ,bool isOnline=true}) async {
    // the user connection status when saving data
    String status = isOnline ? 'online' : 'offline';
    // cache key to save
    String cacheKey = json.encode({'key': key, 'date': _date, 'status': status});
    // data as string
    late String stringifyData;
    try {
      // this is usually used when user wants to add data when they are offline ex (stock heads) so we save it as list
      if (status == 'offline'&&isList) {
        // empty list of map
        List allData = [];
        // add the data that was received to the list
        allData.add(data);
        // get cached offline data
        var cache = getCacheData(key: key, wasOnline: false);
        // if cache is list which means we added elements before so we combine them
        if (cache is List) {
          // combine old data with the data we received
          allData.addAll(cache);
        }
        // data as string from list
        stringifyData = json.encode(allData);
      }
      else {
        //no list and user wasn't adding this data by choice  ex (location)
        // we save data as string from map
        stringifyData = json.encode(data);
      }
    } catch (e) {
      // in case of error we return empty map
      stringifyData = json.encode({});
    }
    dev.log('i am save data : $stringifyData');
    // saving the string data (list of map) to local
    await LocalStorage.saveStringToDisk(key: cacheKey, value: stringifyData);
  }

  // delete cached data usually used to delete the data that was offline then got uploaded to the server
  static Future<void> deleteCacheData ({required String key}) async {
    // cache key we assume that the data that we will be deleted was uploaded offline then got uploaded to the server
    String cacheKey = json.encode({'key': key, 'date': _date, 'status': 'offline'});
    // remove the value from local
    await LocalStorage.removeValueFromDisk(key: cacheKey);
}
}
