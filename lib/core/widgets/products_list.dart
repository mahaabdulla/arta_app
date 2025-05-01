import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    super.initState();
    context.read<ListingCubit>().fetchAds(); // جلب الإعلانات عند بداية الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListingCubit, ListingState>(
      listener: (context, state) {
        if (state is ErrorListingState) {
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
        if (state is LoadingListingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessListingState) {
          // استخدام filteredListing لعرض الإعلانات المفلترة
          final adsToShow =
              state.filteredListing != null && state.filteredListing!.isNotEmpty
                  ? state.filteredListing!
                  : state.listing;

          if (adsToShow.isEmpty) {
            return const Center(child: Text("لا توجد نتائج مطابقة"));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: adsToShow.length,
            itemBuilder: (ctx, index) {
              final ad = adsToShow[index];
              return SizedBox(
                width: 357.w,
                child: Card(
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
                              child: Image.network(
                                "${ApiUrls.image_root}${ad.primaryImage}",
                                width: 95.w,
                                height: 114.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(cars); // صورة بديلة
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
                                    ad.title ?? "",
                                    style: TextStyles.reguler14.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(userImage),
                                      SizedBox(width: 4.w),
                                      Text(
                                        ad.user?.name ?? 'اسم المستخدم',
                                        style: TextStyles.reguler14.copyWith(
                                          color: const Color(0xff1C274C),
                                        ),
                                      ),
                                      SizedBox(width: 23.w),
                                      SvgPicture.asset(locationImage),
                                      SizedBox(width: 1.w),
                                      Text(
                                        ad.region?.name ?? "الموقع",
                                        style: TextStyles.reguler14.copyWith(
                                          color: const Color(0xff1C274C),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(clockImage),
                                      SizedBox(width: 1.w),
                                      Text(
                                        ad.status ?? "الحالة",
                                        style: TextStyles.reguler14.copyWith(
                                          color: const Color(0xff1C274C),
                                        ),
                                      ),
                                      SizedBox(width: 26.w),
                                      SvgPicture.asset(dollerImage),
                                      Text(
                                        ad.price ?? "السعر",
                                        style: TextStyles.reguler14.copyWith(
                                          color: const Color(0xff1C274C),
                                        ),
                                      ),
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
                                    arguments: ad.id,
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
          return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
        }
      },
    );
  }
}
