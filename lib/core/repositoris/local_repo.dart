

// import 'package:e_commesce_app/helper/sqldbHealper.dart';

// import 'data_repo.dart';

// class LocalProductsRepo extends DataRepo {
  
//   @override
//   Future<Map<String, dynamic>> deleteData(Map<String, dynamic> dataToSend, String source)async {
//     DBManger dbManger = DBManger();
//   int id = dataToSend['id'] as int;

//   int rowsAffected = await dbManger.delete("DELETE FROM ${DBManger.TBL_PRODUCTS} WHERE ${DBManger.COL_ID} = $id");
//   return {'rowsAffected': rowsAffected};
//   }
  
//   @override
//   Future<List> getListData({required String source, List<String>? columns})async {
//     DBManger dbManger = DBManger();
//     return await dbManger.fetch("select * from ${DBManger.TBL_PRODUCTS}");
//   }
  
//   @override
//   Future<Map<String, dynamic>> postData(Map<String, dynamic> dataToSend, String source) async {
//     // Product p;
//     DBManger dbManger = DBManger();

//     Map<String, dynamic> prodcutRow = dataToSend;
//     // p.toJson();
//     // List<Map<String, dynamic>> sub_images = [];
//        int id = await dbManger.insert(source, prodcutRow,mainTable_id:DBManger.COL_ID);
//        Map<String, dynamic> responce = {"id": id};
//     return responce;
//   }
  
//   @override
//   Future<Map<String, dynamic>> putData(Map<String, dynamic> dataToSend, String source) {
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Map<String, dynamic>> getMapData({required String source, List<String>? columns}) {
//     // TODO: implement getMapData
//     throw UnimplementedError();
//   }
// }