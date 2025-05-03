import 'package:arta_app/core/repositoris/online_repo.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListingCubit(OnlineDataRepo())..fetchAds(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('إعلانات $categoryName'),
          backgroundColor: Colors.blueAccent,
        ),
        body: BlocBuilder<ListingCubit, ListingState>(
          builder: (context, state) {
            if (state is LoadingListingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SuccessListingState) {
              final filteredAds = state.listing
                  .where((ad) => ad.categoryId == categoryId)
                  .toList();

              if (filteredAds.isEmpty) {
                return Center(child: Text('لا توجد إعلانات في هذه الفئة.'));
              }

              return ListView.builder(
                itemCount: filteredAds.length,
                itemBuilder: (context, index) {
                  final ad = filteredAds[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(ad.title ?? 'بدون عنوان'),
                      subtitle: Text(ad.description ?? ''),
                      onTap: () {
                        // اذهب إلى تفاصيل الإعلان
                      },
                    ),
                  );
                },
              );
            } else if (state is ErrorListingState) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('حدث خطأ غير متوقع'));
            }
          },
        ),
      ),
    );
  }
}
