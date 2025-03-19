import 'package:arta_app/core/constants/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:arta_app/feature/presentations/pages/categorys/data/categury_model.dart';

class CateguryVM {
  final Dio dio = Dio();
  List<Category> parentCategories = [];
  List<Category> children = [];
  late  Map<String, dynamic> singleCtg;

  Future<List<Category>> getCtgParent() async {
    try {
      Response response = await dio.get(ApiUrls.getParentUrl);
      List<dynamic> data = response.data['data'];
      parentCategories = data.map((p) => Category.fromJson(p)).toList();
      return parentCategories;
    } catch (e) {
      print('the exption is : $e');
    } finally {
      return parentCategories;
    }
  }

  Future<List<Category>> getChildren(int parentId) async {
   try{

     String url = ApiUrls.getChildrenUrl(parentId);
      Response response = await dio.get(url);
      List<dynamic> data = response.data['data'];

      children = data.map((child) => Category.fromJson(child)).toList();
      return children;
   }catch(e){
    print('$e');
   }
   finally{
    return children;
   }
  }

  Future<Category> getSingleCatg(int id) async {
    Response response = await dio.get(ApiUrls.singleCatgUrl(id));
 singleCtg = response.data['data'];
    return Category.fromJson(singleCtg);
  }
}
