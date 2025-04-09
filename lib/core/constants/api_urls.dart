class ApiUrls {
  static const String ipconfig = '192.168.93.62';
  static const String image_root = 'http://$ipconfig:8000';
  static const String root = 'http://$ipconfig:8000/api';
  static const String getParentUrl = '$root/categories/parents';
  static const String getcategories = '$root/category';

  static String getChildrenUrl(int parentId) {
    return '$root/categories/$parentId/children';
  }

  static String singleCatgUrl(int id) {
    return '$root/category/$id';
  }

  static String deletCatgUrl(int id) {
    return '$root/category/$id';
  }

  static const String postAdstUrl = '$root/listing';
  static const String LOGIN = '$root/login';
  static const String REGISTER = '$root/register';
  static const String PERENT = '$root/categories/parents';
}
