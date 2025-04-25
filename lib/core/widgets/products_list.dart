import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;
import '../constants/api_urls.dart';
import '../constants/png_images.dart';
import '../utils/global_methods/global_methods.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    context.read<ListingCubit>().fetchAds();
    super.initState();
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
          if (state.listing.isEmpty) {
            return const Center(child: Text("لا توجد منتجات حالياً"));
          }

          return ListView.builder(
            itemCount: state.listing.length,
            itemBuilder: (ctx, index) {
              final list = state.listing[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiUrls.image_root}${list.primaryImage}",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image),
                            width: 95,
                            height: 114,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list.title ?? "",
                                style: TextStyles.reguler14.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset(userImage),
                                  const SizedBox(width: 4),
                                  Text(
                                    list.user?.name ?? 'اسم المستخدم',
                                    style: TextStyles.reguler14.copyWith(
                                        color: const Color(0xff1C274C)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset(locationImage),
                                  const SizedBox(width: 4),
                                  Text(
                                    list.region?.name ?? "الموقع",
                                    style: TextStyles.reguler14.copyWith(
                                        color: const Color(0xff1C274C)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset(clockImage),
                                  const SizedBox(width: 4),
                                  Text(
                                    list.status ?? "الحالة",
                                    style: TextStyles.reguler14.copyWith(
                                        color: const Color(0xff1C274C)),
                                  ),
                                  const SizedBox(width: 16),
                                  SvgPicture.asset(dollerImage),
                                  const SizedBox(width: 4),
                                  Text(
                                    list.price ?? "السعر",
                                    style: TextStyles.reguler14.copyWith(
                                        color: const Color(0xff1C274C)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("فشل في تحميل المنتجات"));
        }
      },
    );
  }
}
