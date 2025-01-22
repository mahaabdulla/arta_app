import 'package:arta_app/core/constants/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:arta_app/feature/categorys/data/categury_model.dart';

class CateguryVM {
  final Dio dio = Dio();

  Future<List<Category>> getCtgParent() async {
    Response response = await dio.get(ApiUrls.getParentUrl);
    List<dynamic> data = response.data['data'];

    List<Category> parentCategories =
        data.map((p) => Category.fromJson(p)).toList();

    return parentCategories;
  }

  Future<List<Category>> getChildren(int parentId) async {
    String url = ApiUrls.getChildrenUrl(parentId);
    Response response = await dio.get(url);
    List<dynamic> data = response.data['data'];

    List<Category> children =
        data.map((child) => Category.fromJson(child)).toList();
    return children;
  }

  Future<Category> getSingleCatg(int id) async {
    Dio dio = Dio();
    Response response =
        await dio.get(ApiUrls.singleCatgUrl(id)); 
    Map<String, dynamic> singleCtg =
        response.data['data']; 
    return Category.fromJson(singleCtg);
  }
}
