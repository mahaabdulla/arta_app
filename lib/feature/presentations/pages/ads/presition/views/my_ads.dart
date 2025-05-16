import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advs_card_info.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListingCubit>(context).fetchMyAds();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollScafold(
      showBackButton: true,
      scrollController: _scrollController,
      isScrolled: _isScrolled,
      widgets: BlocConsumer<ListingCubit, ListingState>(
        listener: (context, state) {
          if (state is SuccessListingState) {
            dev.log('تم تحميل الإعلانات بنجاح');
          } else if (state is ErrorListingState) {
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

            return Column(
              children: myAds.map((ad) {
                final imageUrl = "${ApiUrls.image_root}${ad.primaryImage}";
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
                            Image.network(
                              imageUrl,
                              width: 95.w,
                              height: 114.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(cars);
                              },
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: AdvsCardInfo(
                                title: ad.title ?? 'عنوان غير متوفر',
                                location: ad.region?.name ?? 'موقع غير متوفر',
                                userName: ad.user?.name ?? 'مستخدم غير معروف',
                                time: ad.createdAt != null
                                    ? DateFormat('yyyy-MM-dd HH:mm')
                                        .format(ad.createdAt!)
                                    : 'وقت غير متوفر',
                                price: ad.price?.toString() ?? 'سعر غير متوفر',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DetailsBottum(
                              onTap: () {
                                _showDeleteDialog(ad.id);
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
              }).toList(),
            );
          }

          return Center(child: Text('حدث خطأ أثناء تحميل الإعلانات'));
        },
      ),
    );
  }

  void _showDeleteDialog(int? adId) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'هل أنت متأكد أنك ترغب في إزالة هذا الإعلان؟',
            textAlign: TextAlign.center,
            style:
                TextStyles.smallReguler.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'هذه العملية لايمكن التراجع عنها',
            textAlign: TextAlign.center,
            style: TextStyles.reguler14,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (adId != null && adId > 0) {
                  ListingCubit.get(context).deleteListing(adId);
                  Navigator.of(ctx).pop();
                } else {
                  Fluttertoast.showToast(
                    msg: "المعرف غير صالح أو مفقود",
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
  }
}
