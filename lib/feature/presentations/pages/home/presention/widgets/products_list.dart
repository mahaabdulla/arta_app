import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/views/add_advsrtismint.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/states_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingCubit, ListingState>(
      builder: (context, state) {
        if (state is LoadingListingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorListingState) {
          return Center(child: Text(state.message));
        } else if (state is SuccessListingState) {
          // استخدام القائمة المفلترة إذا كانت موجودة، وإلا استخدام القائمة الأصلية
          final ads = state.filteredListing?.isNotEmpty == true 
              ? state.filteredListing 
              : state.listing;

          if (ads?.isEmpty == true) {
            return const Center(child: Text('لا توجد إعلانات'));
          }

          return ListView.builder(
            itemCount: ads?.length ?? 0,
            itemBuilder: (context, index) {
              final ad = ads?[index];
              if (ad == null) return const SizedBox.shrink();
              return ProductCard(ad: ad);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final ListingModel ad;

  const ProductCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الإعلان
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              ad.images?.first ?? '',
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200.h,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان الإعلان
                Text(
                  ad.title ?? '',
                  style: TextStyles.reguler14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                // وصف الإعلان
                Text(
                  ad.description ?? '',
                  style: TextStyles.reguler14.copyWith(
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                // السعر
                Text(
                  '${ad.price} ريال',
                  style: TextStyles.reguler14.copyWith(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                // المنطقة
                Text(
                  ad.region?.name ?? '',
                  style: TextStyles.reguler14.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 