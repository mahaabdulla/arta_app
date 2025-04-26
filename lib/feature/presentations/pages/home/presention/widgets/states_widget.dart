import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget buildLoadingHomeState(BuildContext context) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(), // يمنع التمرير داخل الجريد
    shrinkWrap: true, // يجعل الجريد يأخذ حجمه الطبيعي
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
    ),
    itemCount: 8,
    itemBuilder: (context, index) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 84.w,
                height: 68.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Shimmer.fromColors(
              baseColor: Colors.grey[350]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 84.w,
                height: 23.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildErrorHomeState() {
  return Center(
    child: Column(
      children: [
        Icon(Icons.error_outline, size: 50, color: Colors.red),
        SizedBox(height: 10.h),
        Text(
          'حدث خطأ أثناء تحميل الفئات',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ],
    ),
  );
}

Widget buildEmptyHomeState() {
  return Center(
    child: Column(
      children: [
        Icon(Icons.category, size: 50.sw, color: Colors.grey),
        SizedBox(height: 10.h),
        Text(
          'لا توجد فئات متاحة',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ],
    ),
  );
}
