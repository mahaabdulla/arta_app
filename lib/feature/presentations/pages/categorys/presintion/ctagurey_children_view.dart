import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false; // To track if scrolling has occurred

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getChildren(widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      scrollController: _scrollController, // Pass the ScrollController here
      isScrolled: isScrolled, // Pass the isScrolled state here
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
                    Text(' ${widget.parentName}'),
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
              height: MediaQuery.of(context).size.height, // Define height here
              child: ListView.builder(
                controller:
                    _scrollController, // Attach the ScrollController to the ListView
                itemCount: children.length,
                itemBuilder: (ctx, index) {
                  final child = children[index];

                  // Check if image exists, otherwise show a default image
                  // final imageUrl = child.image != null
                  //     ? "${ApiUrls.image_root}${child.image}"
                  //     : null;

                  return InkWell(
                    onTap: () async {
                      final cubit = context.read<CategoryCubit>();
                      await cubit.getChildren(child.id!);

                      final currentState = cubit.state;

                      if (currentState is SuccessChildrenState &&
                          currentState.children.isNotEmpty) {
                        // If it has children, show them on the same screen
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
                        // If no children, navigate to its details page
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
                                    // Image Placeholder (if required, uncomment below)
                                    // Image.network(
                                    //   imageUrl ?? 'assets/images/default_avatar.png',
                                    //   width: 95.w,
                                    //   height: 114.h,
                                    //   fit: BoxFit.cover,
                                    //   errorBuilder: (context, error, stackTrace) {
                                    //     return Image.asset('assets/images/default_avatar.png');
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
