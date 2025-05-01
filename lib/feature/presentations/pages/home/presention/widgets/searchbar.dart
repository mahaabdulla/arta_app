import 'package:arta_app/feature/presentations/pages/home/presention/widgets/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';

class SearchBarFiltter extends StatefulWidget {
  const SearchBarFiltter({super.key});

  @override
  _SearchBarFiltterState createState() => _SearchBarFiltterState();
}

class _SearchBarFiltterState extends State<SearchBarFiltter> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'ابحث هنا',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                // عند كتابة النص في شريط البحث نقوم بتحديث بحث Cubit
                ListingCubit.get(context).searchByTitle(value);
              },
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              String query = _searchController.text;
              if (query.isNotEmpty) {
                // إذا كان النص غير فارغ، نقوم بالتوجيه إلى صفحة نتائج البحث
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(searchQuery: query),
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [primary, secondary],
                ),
              ),
              child: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
