
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/ads_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/ads_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;
import '../constants/api_urls.dart';
import '../constants/png_images.dart';
import '../utils/global_methods/global_methods.dart';

class ProductsList extends StatefulWidget {
  // final VoidCallback onTap;
  // final Color color;
  // final String title;
  // final String text;
  // final String userName;
  // final String time;
  // final String price;
  // final String location;
  // final String imagePath;

  ProductsList({
    super.key,
    // required this.onTap,
    // required this.color,
    // required this.title,
    // required this.text,
    // required this.userName,
    // required this.time,
    // required this.price,
    // required this.location,
    // required this.imagePath,
  });

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    AdsCubit adsCubit = context.read<AdsCubit>();
    adsCubit.fetchAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(listener: (context, state) {
      if (state is ErrorAdsState) {
        toast(
          state.message,
          bgColor: Colors.red,
          print: true,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
      }
    }, builder: (context, state) {
      if (state is LoadingAdsState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SuccessAdsState) {
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
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                            width: 100,
                            height: 120,
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
                              Text(
                                list.title ?? "",
                                style: TextStyles.reguler14.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(userImage),
                                      const SizedBox(width: 4),
                                      Text(list.user?.name ?? 'اسم المستخدم',
                                          style: TextStyles.reguler14.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlck)),
                                    ],
                                  ),
                                  SizedBox(width: 60),
                                  Row(
                                    children: [
                                      SvgPicture.asset(locationImage),
                                      const SizedBox(width: 4),
                                      Text(list.region?.name?? "الموقع",
                                          style: TextStyles.reguler14.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: darkBlck)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SvgPicture.asset(clockImage),
                                  const SizedBox(width: 4),
                                  Text(list.status?? "الحالة",
                                      style: TextStyles.reguler14.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlck)),
                                  SizedBox(width: 75),
                                  SvgPicture.asset(dollerImage),
                                  Text(list.price?? "السعر",
                                      style: TextStyles.reguler14.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: darkBlck)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    DetailsBottum(
                      onTap: () {
                        Navigator.pushNamed(context, '/product');
                      },
                      color: const Color(0xff046998),
                      text: 'عرض التفاصيل',
                      imagePath: arrowIcon,
                    ),
                  ],
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
