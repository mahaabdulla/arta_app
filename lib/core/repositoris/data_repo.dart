abstract class DataRepo {
  Future<Map<String, dynamic>> getData({required String url, String? columns});
  Future<Map<String, dynamic>> postData(
      Map<String, dynamic> dataToSend, String source);
  Future<Map<String, dynamic>> putData(
      Map<String, dynamic> dataToSend, String source);
  Future<Map<String, dynamic>> deleteData(
      Map<String, dynamic> dataToSend, String source);
  // Future<Map<String, dynamic>> logout();
}
