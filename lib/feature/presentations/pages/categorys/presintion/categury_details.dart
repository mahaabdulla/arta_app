import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  // ScrollController
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false; // Track scroll position

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      scrollController: _scrollController, // Pass the scrollController here
      isScrolled: isScrolled, // Pass the isScrolled flag here
      // title: '${categoryName}',
      showBackButton: true,

      widgets: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تفاصيل التصنيف:',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text('رقم التصنيف: $categoryId'),
              Text('الاسم: $categoryName'),
            ],
          ),
        ),
      ),
    );
  }
}
