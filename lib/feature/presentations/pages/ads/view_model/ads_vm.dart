import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AdvertisementVM {
  Dio dio = Dio();
  final String baseUrl =
      "http://192.168.245.62:8000/api/listing"; 

  // Get all advertisements with optional filters
  Future<List<dynamic>> fetchAdvertisements({
    int? userId,
    int? regionId,
    int? categoryId,
    String? sort,
  }) async {
    try {
      final queryParameters = {
        if (userId != null) 'user_id': userId.toString(),
        if (regionId != null) 'region_id': regionId.toString(),
        if (categoryId != null) 'category_id': categoryId.toString(),
        if (sort != null) 'sort': sort,
      };
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch advertisements");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Create a new advertisement
 Future<void> createAdvertisement({
    required String title,
    required String description,
    required double price,
    required int categoryId,
    required int regionId,
    required String status,
    required String primaryImagePath,
    required String token ,
  }) async {
    try {
      final response = await dio.post(
        'http://192.168.245.62:8000/api/listing',
        data: {
          'title': title,
          'description': description,
          'price': price,
          'category_id': categoryId,
          'region_id': regionId,
          'status': status,
          'primary_image': primaryImagePath,
        },
        
        options: Options(headers: {'Authorization': 'Bearer 11|mRbs2xC2W4WjFu5B8lus1QBQTRwinCd2QGq3JIfZ38b8596f'}),
      );

      if (response.statusCode == 200) {
        print("Advertisement created successfully");
        print('${response.data}');
      } else {
        print("Error: ${response.data}");
        throw Exception("Failed to create advertisement: ${response.data}");
      }
    } catch (e) {
      print("Error in createAdvertisement: $e");
      throw Exception("Failed to create advertisement $e" );
    }
  }

  // Update an existing advertisement
  Future<Map<String, dynamic>> updateAdvertisement({
    required int id,
    required String title,
    required String description,
    required double price,
    required int categoryId,
    required int regionId,
    required String status,
    String? primaryImagePath,
    List<String>? additionalImagesPaths,
    required String token,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/$id");
      final request = http.MultipartRequest("PUT", uri);
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['price'] = price.toString();
      request.fields['category_id'] = categoryId.toString();
      request.fields['region_id'] = regionId.toString();
      request.fields['status'] = status;

      // Attach the primary image if provided
      if (primaryImagePath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'primary_image',
          primaryImagePath,
        ));
      }

      // Attach additional images if provided
      if (additionalImagesPaths != null) {
        for (String imagePath in additionalImagesPaths) {
          request.files.add(await http.MultipartFile.fromPath(
            'images[]',
            imagePath,
          ));
        }
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        throw Exception("Failed to update advertisement");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Delete an advertisement
  Future<bool> deleteAdvertisement({
    required int id,
    required String token,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/$id");
      final response = await http.delete(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete advertisement");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
