import 'package:dio/dio.dart';

class RegionVM {
  final Dio dio = Dio();

  List<dynamic> regions = [];
  List<dynamic> parentRegions = [];
  List<dynamic> childrenRegions = [];
  late Map<String, dynamic> singleRegion;

  /// Fetches all regions.
  Future<List<dynamic>> getAllRegions() async {
    try {
      Response response = await dio.get('http://192.168.245.62:8000/api/region');
      regions = response.data['data'];
      return regions;
    } catch (e) {
      print('Error fetching all regions: $e');
      return [];
    }
  }

  /// Creates a new region.
  Future<Map<String, dynamic>?> createRegion({
    required String name,
    int? parentId,
  }) async {
    try {
      Response response = await dio.post(
        'http://192.168.245.62:8000/api/region',
        data: {
          'name': name,
          if (parentId != null) 'parent_id': parentId,
        },
        options: Options(headers: {
          'Authorization': 'Bearer YOUR_TOKEN', // Replace with actual token
        }),
      );
      return response.data['data'];
    } catch (e) {
      print('Error creating region: $e');
      return null;
    }
  }

  /// Fetches a single region by ID.
  Future<Map<String, dynamic>?> getRegionById(int id) async {
    try {
      Response response = await dio.get('http://192.168.245.62:8000/api/region/$id');
      singleRegion = response.data['data'];
      return singleRegion;
    } catch (e) {
      print('Error fetching region by ID: $e');
      return null;
    }
  }

  /// Deletes a region by ID.
  Future<bool> deleteRegion(int id) async {
    try {
      await dio.delete(
        'http://192.168.245.62:8000/api/region/$id',
        options: Options(headers: {
          'Authorization': 'Bearer YOUR_TOKEN', // Replace with actual token
        }),
      );
      return true;
    } catch (e) {
      print('Error deleting region: $e');
      return false;
    }
  }

  /// Fetches all parent regions.
  Future<List<dynamic>> getParentRegions() async {
    try {
      Response response = await dio.get('http://192.168.245.62:8000/api/regions/parents');
      parentRegions = response.data['data'];
      return parentRegions;
    } catch (e) {
      print('Error fetching parent regions: $e');
      return [];
    }
  }

  /// Fetches all child regions for a given parent ID.
  Future<List<dynamic>> getChildRegions(int parentId) async {
    try {
      Response response = await dio.get('http://192.168.245.62:8000/api/regions/$parentId/children');
      childrenRegions = response.data['data'];
      return childrenRegions;
    } catch (e) {
      print('Error fetching child regions: $e');
      return [];
    }
  }
}
