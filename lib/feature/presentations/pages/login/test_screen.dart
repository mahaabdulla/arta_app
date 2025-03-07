import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late final OnlineDataRepo _api;
  List<dynamic> categories = [];
  @override
  void initState() {
    super.initState();
    _api = OnlineDataRepo();
  }

 

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await _api.getData(url: ApiUrls.getcategories);

      if (response != null &&
          response['data'] != null &&
          response['data']['data'] != null) {
        dev.log("Response of categories: ${response['data']['data']}");
        return categories = List.from(response['data']['data']);
      } else {
        dev.log("Error: Data structure is incorrect or empty");
        return [];
      }
    } catch (e) {
      dev.log("Error fetching data: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("لا توجد بيانات متاحة"));
            }

            // عرض البيانات في القائمة
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(item['name'] ?? 'اسم غير متاح'),
                    subtitle: Text(item['description'] ?? 'بدون وصف'),
                    leading: Icon(Icons.category, color: Colors.blue),
                    
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
