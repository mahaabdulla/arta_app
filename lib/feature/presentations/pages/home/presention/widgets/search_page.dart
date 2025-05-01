import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;

  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // نقوم بتحميل الإعلانات بناءً على البحث
    context.read<ListingCubit>().searchByTitle(searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text("نتائج البحث: $searchQuery"),
      ),
      body: BlocConsumer<ListingCubit, ListingState>(
        listener: (context, state) {
          if (state is ErrorListingState) {
            // عرض رسالة خطأ إذا حدث خطأ أثناء تحميل البيانات
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingListingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessListingState) {
            final filteredAds = state.filteredListing;

            if (filteredAds == null || filteredAds.isEmpty) {
              return const Center(child: Text("لا توجد نتائج مطابقة"));
            }

            return ListView.builder(
              itemCount: filteredAds.length,
              itemBuilder: (context, index) {
                final ad = filteredAds[index];
                return ListTile(
                  title: Text(ad.title ?? "لا يوجد عنوان"),
                  subtitle: Text(ad.price ?? "لا يوجد سعر"),
                  onTap: () {
                    // يمكنك إضافة رابط إلى تفاصيل الإعلان عند النقر
                  },
                );
              },
            );
          }
          return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
        },
      ),
    );
  }
}
