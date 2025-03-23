import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/data/models/category.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/ctagurey_children_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../cubits/categories/categories_cubit.dart';
import '../../../../cubits/categories/categories_state.dart';
import 'dart:developer' as dev;

class CategoryList extends StatefulWidget {
  CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late CategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategoris(isHome: true);
    super.initState();
  }

  final List<String> ctgImages = [
    cars,
    motors,
    electronic,
    home,
    sports,
    clothing,
    ecomiric,
    more,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        dev.log("Current state is $state");
        if (state is ErrorCategoryState) {
          toast(
            state.message,
            bgColor: Colors.red,
            print: true,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingCategoryState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessCategoryState) {
          if (state.categories.isEmpty) {
            return const Center(child: Text("No categories available"));
          }

          return GridView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // يمنع التمرير داخل الجريد
            shrinkWrap: true, // يجعل الجريد يأخذ حجمه الطبيعي
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: state.categories.length,
            itemBuilder: (ctx, index) {
              dev.log(
                  " image URL is ${ApiUrls.image_root}/${state.categories[0].image}");
              Category category = state.categories[index];
              dev.log(
                  "the image response is : http://localhost:8000/${category.image}");
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => CategoryChildrenView(
                        parentId: category.id ?? 1,
                        parentName: category.name ?? "",
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      child: category.id == -1
                          ? Container(
                              width: 57.79.w,
                              height: 59.17.h,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF2F2F7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(55.04),
                                ),
                              ),
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: Colors.blue,
                                size: 50.sp,
                              ),
                            )
                          //  SvgPicture.asset(
                          //     moreImage,
                          //   )
                          : Image.network(
                              "${ApiUrls.image_root}${category.image}",
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(ctgImages[1]);
                              },
                            ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      category.name ?? "",
                      style: TextStyles.reguler14.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("Error loading categories"));
        }
      },
    );
  }
}

// class CateguryList extends StatefulWidget {
//   // final List<Category> categ;

//   CateguryList({
//     super.key,
//     // required this.categ,
//   });

//   @override
//   State<CateguryList> createState() => _CateguryListState();
// }

// class _CateguryListState extends State<CateguryList> {
//   late CategoryCubit categoryCubit;

//   @override
//   void initState() {
//     categoryCubit = context.read<CategoryCubit>();
//     categoryCubit.getCategoris();
//     super.initState();
//   }

//   // final List<String> ctgImages = [
//   final List<String> ctgImages = [
//     cars,
//     motors,
//     electronic,
//     home,
//     sports,
//     clothing,
//     ecomiric,
//     more,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: BlocConsumer<CategoryCubit, CategoryState>(
//             listener: (context, state) {
//       if (state is ErrorCategoryState) {
//         toast(
//           state.message,
//           bgColor: Colors.red,
//           print: true,
//           gravity: ToastGravity.BOTTOM,
//           textColor: Colors.white,
//         );
//       }
//     }, builder: (context, state) {
//       if (state is LoadingCategoryState) {
//         return Center(child: CircularProgressIndicator());
//       } else if (state is SuccessCategoryState) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           // sliver: SliverGrid(
//           //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
//           //     mainAxisSpacing: 8,
//           //     crossAxisSpacing: 8,
//           //     childAspectRatio: 1,
//           //   ),
//           // delegate:
//           child: ListView.builder(
//             itemCount: state.categories.length,
//             itemBuilder: (ctx, index) {
//               Category category = state.categories[index];

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (ctx) => CategoryChildrenView(
//                         parentId: category.id ?? 1,
//                         parentName: category.name ?? "",
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         ctgImages[index % ctgImages.length],
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       category.name ?? "",
//                       style: TextStyles.reguler14.copyWith(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           // ),
//         );
//       } else {
//         return Center(child: Text("Error loading categories"));
//       }
//     }));
//   }
// }
