import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as dev;

class CtgChildrenScreen extends StatefulWidget {
  final int parentId;
  final String parentName;

  const CtgChildrenScreen({
    Key? key,
    required this.parentId,
    required this.parentName,
  }) : super(key: key);

  @override
  State<CtgChildrenScreen> createState() => _CtgChildrenScreenState();
}

class _CtgChildrenScreenState extends State<CtgChildrenScreen> {
  @override
  void initState() {
    super.initState();
    // طلب الأبناء عند تحميل الشاشة
    context.read<CategoryCubit>().getChildren(widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      title: ' ${widget.parentName}',
      text: 'text',
      showBackButton: true,
      widgets: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is ErrorCategoryState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingCategoryState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SuccessChildrenState) {
            final children = state.children;

            if (children.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'لا توجد بيانات للأبناء',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (ctx, index) {
                  final child = children[index];

                  // تحقق من وجود صورة، وإذا كانت null نعرض صورة افتراضية
                  final imageUrl = child.image != null
                      ? "${ApiUrls.image_root}${child.image}"
                      : null;

                  return InkWell(
                    onTap: () async {
                      final cubit = context.read<CategoryCubit>();
                      await cubit.getChildren(child.id!);

                      final currentState = cubit.state;

                      if (currentState is SuccessChildrenState &&
                          currentState.children.isNotEmpty) {
                        // إذا عنده أبناء، نعرضهم في نفس الشاشة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CtgChildrenScreen(
                              parentId: child.id!,
                              parentName: child.name ?? '',
                            ),
                          ),
                        );
                      } else {
                        // إذا ما عنده أبناء، نروح لتفاصيله
                        Navigator.pushNamed(
                          context,
                          '/categoryDetails',
                          arguments: {
                            'categoryId': child.id!,
                            'categoryName': child.name ?? '',
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: listingCardBackground,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    // // إذا كانت الصورة null نعرض صورة افتراضية
                                    // Image.network(
                                    //   imageUrl ??
                                    //       'assets/images/default_avatar.png', // صورة افتراضية
                                    //   width: 95.w,
                                    //   height: 114.h,
                                    //   fit: BoxFit.cover,
                                    //   errorBuilder: (context, error, stackTrace) {
                                    //     return Image.asset(
                                    //         'assets/images/default_avatar.png'); // صورة افتراضية في حالة الخطأ
                                    //   },
                                    // ),
                                  ],
                                ),
                                SizedBox(width: 6.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(child.name ?? 'اسم غير معروف',
                                        style: TextStyles.reguler14
                                            .copyWith(color: Colors.black)),
                                    SizedBox(height: 5.h),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
        },
      ),
    );
  }
}
