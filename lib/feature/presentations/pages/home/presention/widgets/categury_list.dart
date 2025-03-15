import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/data/models/category.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/ctagurey_children_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../cubits/categories/categories_cubit.dart';
import '../../../../cubits/categories/categories_state.dart';

class CateguryList extends StatefulWidget {
  // final List<Category> categ;

  CateguryList({
    super.key,
    // required this.categ,
  });

  @override
  State<CateguryList> createState() => _CateguryListState();
}

class _CateguryListState extends State<CateguryList> {
  late CategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategoris();
    super.initState();
  }

  // final List<String> ctgImages = [
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
    return CustomScrollView(slivers: [
      // BlocConsumer<CategoryCubit, CategoryState>(
      //   listener: (context, state) {
      //     if (state is ErrorCategoryState) {
      //       toast(
      //         state.message,
      //         bgColor: Colors.red,
      //         print: true,
      //         gravity: ToastGravity.BOTTOM,
      //         textColor: Colors.white,
      //       );
      //     }
      //   },
      //   builder: (context, state) {
      //     if (state is LoadingCategoryState) {
      //       return SliverToBoxAdapter(
      //           child: Center(child: CircularProgressIndicator()));
      //     } else if (state is SuccessCategoryState) {
      // return
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate((ctx, index) {
            // Category category = state.categories[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => CategoryChildrenView(
                        parentId: 1,
                        // category.id ?? 1,
                        parentName: ""
                        // category.name ?? "",
                        ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      ctgImages[index % ctgImages.length],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "",
                    // category.name ?? "",
                    style: TextStyles.reguler14.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }, childCount: 5
              // state.categories.length,
              ),
        ),
      )
      // } else {
      //   return SliverToBoxAdapter(
      //       child: Center(child: Text("Error loading categories")));
      // }
    ]);
  }
  //   ),
  // ],
// );

  // return BlocConsumer<CategoryCubit, CategoryState>(
  //           listener: (context, state) {
  //             if (state is ErrorCategoryState) {
  //               toast(
  //             state.message,
  //             bgColor: Colors.red,
  //             print: true,
  //             gravity: ToastGravity.BOTTOM,
  //             textColor: Colors.white,
  //           );
  //             }
  //           },
  //           builder: (context, state)
  //   {
  //      if (state is LoadingCategoryState) {
  //         return Center(child: CircularProgressIndicator()); // عرض لودنغ
  //       }else if (state is SuccessCategoryState)
  //       {
  //         return SliverPadding(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       sliver: SliverGrid(
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
  //           mainAxisSpacing: 8,
  //           crossAxisSpacing: 8,
  //           childAspectRatio: 1,
  //         ),
  //         delegate: SliverChildBuilderDelegate(
  //           (ctx, index) {
  //             Category category = state.categories[index];

  //             // Category category = categ[index];
  //             return GestureDetector(

  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (ctx) => CategoryChildrenView(
  //                       parentId: category.id??1,
  //                       parentName: category.name?? "",
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Column(
  //                 children: [
  //                   Expanded(
  //                     //الصور تفاهمي معها بعدين
  //                     child: Image.asset(
  //                       ctgImages[
  //                           index % ctgImages.length],
  //                       fit: BoxFit.contain,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 4),
  //                   Text(
  //                     category.name??"",
  //                     style: TextStyles.reguler14.copyWith(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //           childCount: state.categories.length,
  //         ),
  //       ),
  //     );
  //       }else {
  //         return Center(child: Text("Error loading categories"));
  //       }
  //   }
  // );
}
// }
