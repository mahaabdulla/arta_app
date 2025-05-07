import 'dart:developer' as dev;

class ApiUrls {


  static const String ipconfig = '10.0.2.2';
  
  static const String image_root = 'http://$ipconfig:8000/';

  static const String primaryImage =
      'http://$ipconfig:8000/assets/listing_images/';

  static const String root = 'http://$ipconfig:8000/api';
  static const String getParentUrl = '$root/categories/parents';
  static const String getcategories = '$root/category';

  static String getChildrenUrl(int parentId) {
    final url = '$root/categories/$parentId/children';
    dev.log('Generated URL: $url');
    return url;
  }

  static String singleCatgUrl(int id) {
    return '$root/category/$id';
  }

  static String deletCatgUrl(int id) {
    return '$root/category/$id';
  }

  static String deletListing(int id) {
    return '$root/listing/$id';
  }

  static String cities(int id) {
    return '$root/regions/$id/children';
  }

  static const String postAdstUrl = '$root/listing';
  static const String LOGIN = '$root/login';
  static const String CHANGEPASSOWRD = '$root/changePassword';
  static const String REGISTER = '$root/register';
  static const String PERENT = '$root/categories/parents';
  static const String COMMINT = '$root/comment';
  static const String PARENTS_REGIONS = '$root/regions/parents';

  static String getRegionChildUrl(int parentId) {
    return '$root/regions/$parentId/children';
  }
  static const String REGETION_PARENT = '$root/regions/parents';
}
