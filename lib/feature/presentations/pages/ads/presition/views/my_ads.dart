import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advs_card_info.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as dev;

import 'package:intl/intl.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListingCubit>(context).fetchMyAds();

    return BasicScaffold(
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      title: 'إعلاناتي',
      text: 'text',
      showBackButton: true,
      widgets: BlocConsumer<ListingCubit, ListingState>(
        listener: (context, state) {
          if (state is SuccessListingState) {
            dev.log('تم تحميل الإعلانات بنجاح');
            dev.log('البيانات المسترجعة: ${state.listing}');
          } else if (state is ErrorListingState) {
            dev.log('حدث خطأ أثناء جلب الإعلانات: ${state.message}');
            Fluttertoast.showToast(
              msg: state.message,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingListingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is SuccessListingState) {
            final myAds = state.listing;

            if (myAds.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'لا يوجد لديك إعلانات',
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
                itemCount: myAds.length,
                itemBuilder: (ctx, index) {
                  final ad = myAds[index];

                  final imageUrl = "${ApiUrls.image_root}${ad.primaryImage}";
                  dev.log(imageUrl);

                  return Container(
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
                                  // TODO fix get images
                                  Image.network(
                                    imageUrl,
                                    width: 95.w,
                                    height: 114.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      dev.log('${error}');
                                      return Image.asset(cars);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(width: 6.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AdvsCardInfo(
                                    title: ad.title ?? 'عنوان غير متوفر',
                                    location:
                                        ad.region?.name ?? 'موقع غير متوفر',
                                    userName:
                                        ad.user?.name ?? 'مستخدم غير معروف',
                                    time: ad.createdAt != null
                                        ? DateFormat('yyyy-MM-dd HH:mm')
                                            .format(ad.createdAt!)
                                        : 'وقت غير متوفر',
                                    price:
                                        ad.price?.toString() ?? 'سعر غير متوفر',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DetailsBottum(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          'هل أنت متأكد أنك ترغب في إزالة هذا الإعلان؟',
                                          style:
                                              TextStyles.smallReguler.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(
                                          textAlign: TextAlign.center,
                                          'هذه العملية لايمكن التراجع عنها',
                                          style: TextStyles.reguler14,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (ad.id != null && ad.id! > 0) {
                                                dev.log(
                                                    'حذف الإعلان بـ ID: ${ad.id}');
                                                ListingCubit.get(context)
                                                    .deleteListing(ad.id!);
                                                Navigator.of(ctx).pop();
                                              } else {
                                                dev.log(
                                                    'المعرف غير صالح أو مفقود: ${ad.id}');
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "المعرف غير صالح أو مفقود",
                                                  backgroundColor: Colors.red,
                                                );
                                                Navigator.of(ctx).pop();
                                              }
                                            },
                                            child: Text("نعم"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("لا"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                color: redColor,
                                text: 'إزالة الإعلان',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Center(child: Text('حدث خطأ أثناء تحميل الإعلانات'));
        },
      ),
    );
  }
}
