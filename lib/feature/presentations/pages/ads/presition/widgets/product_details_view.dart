import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/core/widgets/products_widgets/blue_container.dart';
import 'package:arta_app/core/widgets/products_widgets/products_card.dart';
import 'package:arta_app/core/widgets/products_widgets/send_commint_bottom.dart';
import 'package:arta_app/core/widgets/products_widgets/send_commint_dialog.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/cubits/commint/commints_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as dev;

import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsView extends StatefulWidget {
  final int? id;
  const ProductDetailsView({super.key, required this.id});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController _commentController = TextEditingController();
  late int listingId;

  @override
  void initState() {
    super.initState();
    context.read<ListingCubit>().getSingleListing(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<ListingCubit, ListingState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingSingleListingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SuccessSingleListingState) {
            listingId = state.listing.id!;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: screenHeight * 0.55,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          group1,
                          fit: BoxFit.cover,
                          width: screenWidth,
                          height: screenHeight * 0.5,
                        ),
                        Positioned(
                          top: screenHeight * 0.03,
                          right: screenWidth * 0.04,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: SvgPicture.asset(iconsArrow),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.13,
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          child: ProductsCard(product: state.listing),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'تفاصيل الاعلان',
                          style: TextStyles.medium18,
                          maxLines: 5,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          state.listing.description ?? "",
                          style: TextStyles.reguler14,
                          maxLines: 10,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final items = [
                              BlueContainerWidget(
                                imagePath: 'assets/svg_images/Smartphone 2.svg',
                                text: state.listing.user?.contactNumber ?? "",
                                onTap: () {},
                              ),
                              BlueContainerWidget(
                                text: state.listing.user?.whatsappNumber ?? "",
                                onTap: () {},
                              ),
                              BlueContainerWidget(
                                imagePath: 'assets/svg_images/Share.svg',
                                text: 'مشاركة الاعلان',
                                onTap: () {},
                              ),
                              BlueContainerWidget(
                                imagePath: 'assets/svg_images/Dislike.svg',
                                text: 'ابلاغ عن الاعلان',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return SendCommintDialog(onTap: () {
                                        //TODO ابلاغ المشروف الاند بوينت ناقص
                                      });
                                    },
                                  );
                                },
                              ),
                            ];
                            return items[index];
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        //
                        // SEND COMMINT
                        TextField(
                          controller: _commentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'اضف تعليق على الاعلان...',
                            hintStyle: TextStyles.reguler14,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        BlocConsumer<CommintsCubit, CommintsState>(
                          listener: (context, state) {
                            if (state is SuccessCommintState) {
                              _commentController.clear();
                              Fluttertoast.showToast(
                                msg: 'تم إرسال التعليق بنجاح',
                                backgroundColor: Colors.green,
                              );
                            }
                            if (state is ErrorCommintState) {
                              toast(
                                state.message,
                                bgColor: Colors.red,
                              );
                            }
                          },
                          builder: (context, state) {
                            return SendCommintBlueBottom(
                              onTap: () {
                                final commentText =
                                    _commentController.text.trim();
                                if (commentText.isEmpty) {
                                  dev.log("النص المدخل فارغ، يرجى إضافة تعليق");
                                  return;
                                }
                                context.read<CommintsCubit>().sendCommint(
                                    commentText, listingId.toString());
                              },
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.04),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is ErrorListingSingleState) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            );
          }

          return const Center(child: Text("حصل خطأ في تحميل المنتج"));
        },
      ),
    );
  }
}
