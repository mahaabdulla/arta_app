import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;
import '../constants/api_urls.dart';
import '../constants/png_images.dart';
import '../utils/global_methods/global_methods.dart';

class ProductsList extends StatefulWidget {
  ProductsList({
    super.key,
  });

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    ListingCubit adsCubit = context.read<ListingCubit>();
    adsCubit.fetchAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListingCubit, ListingState>(listener: (context, state) {
      if (state is ErrorListingState) {
        toast(
          state.message,
          bgColor: Colors.red,
          print: true,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      if (state is LoadingListingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SuccessListingState) {
        if (state.listing.isEmpty) {
          return const Center(child: Text("No product available"));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: state.listing.length,
          //
          itemBuilder: (ctx, index) {
            dev.log("list length is ${state.listing.length}");
            ListingModel list = state.listing[index];
            return SizedBox(
              width: 357.w,
              //  height: 153.h,
              child: Card(
                // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                // list.images == null || list.images!.length == 0 || list.images!.isEmpty
                                // ?Image.asset(cars)
                                // :
                                Image.network(
                              "${ApiUrls.image_root}${list.primaryImage}",
                              width: 95.w,
                              height: 114.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(cars);
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18.h),
                                Text(
                                  list.title ?? "",
                                  style: TextStyles.reguler14.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(userImage),
                                        SizedBox(width: 4.w),
                                        Text(list.user?.name ?? 'اسم المستخدم',
                                            style: TextStyles.reguler14
                                                .copyWith(
                                                    color: Color(0xff1C274C))),
                                      ],
                                    ),
                                    SizedBox(width: 23.w),
                                    Row(
                                      children: [
                                        SvgPicture.asset(locationImage),
                                        SizedBox(width: 1.w),
                                        Text(list.region?.name ?? "الموقع",
                                            style: TextStyles.reguler14
                                                .copyWith(
                                                    color: Color(0xff1C274C))),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(clockImage),
                                    SizedBox(width: 1.w),
                                    Text(list.status ?? "الحالة",
                                        style: TextStyles.reguler14.copyWith(
                                            color: Color(0xff1C274C))),
                                    SizedBox(width: 26.w),
                                    SvgPicture.asset(dollerImage),
                                    Text(list.price ?? "السعر",
                                        style: TextStyles.reguler14.copyWith(
                                            color: Color(0xff1C274C))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.w, bottom: 5.h),
                            child: DetailsBottum(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product',
                                  arguments: list.id,
                                );
                              },
                              color: const Color(0xff046998),
                              text: 'عرض التفاصيل',
                              imagePath: arrowIcon,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return const Center(child: Text("Error loading products"));
      }
    });
  }
}
