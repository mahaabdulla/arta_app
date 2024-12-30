import 'package:arta_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBarFiltter extends StatelessWidget {
  const SearchBarFiltter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          // شريط البحث
          Expanded(
            child: TextField(
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
            ),
          ),
          const SizedBox(width: 10),
          // زر الفلتر
          InkWell(
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
