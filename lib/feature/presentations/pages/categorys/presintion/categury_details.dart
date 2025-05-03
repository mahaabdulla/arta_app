import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDetailPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      title: '${categoryName}',
      showBackButton: true,
      onTap: () {
        Navigator.pop(context);
      },
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
