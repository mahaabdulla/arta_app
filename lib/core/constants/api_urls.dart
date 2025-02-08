class ApiUrls {
  static const String root = 'http://192.168.245.62:8000/api';
  static const String getParentUrl = '$root/categories/parents';

  static String getChildrenUrl(int parentId) {
    return '$root/categories/$parentId/children';
  }

  static String singleCatgUrl(int id) {
    return '$root/category/$id';
  }

  static String deletCatgUrl(int id) {
    return '$root/category/$id';
  }

  static const String postAdstUrl = '$root /listing';
  static const String LOGIN = '$root/login';
}
