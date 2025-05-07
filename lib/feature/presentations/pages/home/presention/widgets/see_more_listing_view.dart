import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;

class SeeMoreListingView extends StatelessWidget {
  const SeeMoreListingView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ListingCubit>().fetchAds();

    return BasicScaffold(
      showBackButton: true,
      onTap: () {
        Navigator.pushReplacementNamed(context, "/home");
      },
      // appBar: AppBar(title: const Text('عرض المزيد')),
      widgets: BlocConsumer<ListingCubit, ListingState>(
        listener: (context, state) {
          if (state is ErrorListingState) {
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingListingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessListingState) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.listing.length,
              itemBuilder: (ctx, index) {
                dev.log('عنصر رقم: $index');
                final list = state.listing[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${ApiUrls.image_root}${list.primaryImage}",
                                  width: 95.w,
                                  height: 114.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(cars),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.h),
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
                                        SvgPicture.asset(userImage, width: 16),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            list.user?.name ?? 'اسم المستخدم',
                                            style: TextStyles.reguler14
                                                .copyWith(
                                                    color: Color(0xff1C274C)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        SvgPicture.asset(locationImage,
                                            width: 16),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            list.region?.name ?? "الموقع",
                                            style: TextStyles.reguler14
                                                .copyWith(
                                                    color: Color(0xff1C274C)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        SvgPicture.asset(clockImage, width: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          list.status ?? "الحالة",
                                          style: TextStyles.reguler14.copyWith(
                                              color: Color(0xff1C274C)),
                                        ),
                                        SizedBox(width: 16),
                                        SvgPicture.asset(dollerImage,
                                            width: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          list.price ?? "السعر",
                                          style: TextStyles.reguler14.copyWith(
                                              color: Color(0xff1C274C)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
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
      ),
    );
  }
}
