import 'package:arta_app/core/constants/api_urls.dart';
import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_state.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/details_bottum.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/filte_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ListingCubit>();
    if (cubit.state is SuccessListingState &&
        (cubit.state as SuccessListingState).filteredListing == null) {
      cubit.fetchAds(); // جلب الإعلانات عند بداية الشاشة
    }
    _searchController
        .addListener(_onSearchChanged); // استماع للتغييرات في مربع البحث
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    context.read<ListingCubit>().searchInAds(query);
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'ابحث هنا',
              hintStyle: TextStyles.reguler14,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        InkWell(
          onTap: () {
            //TODO: add filter logic
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => FilterPage()));
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [primary, secondary],
              ),
            ),
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ),
      ],
    );
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
          final hasSearchText = _searchController.text.isNotEmpty;
          final isFiltered = state.filteredListing != null;

          final adsToShow = hasSearchText || isFiltered
              ? state.filteredListing ?? []
              : state.listing;

          return Column(
            children: [
              _buildSearchAndFilter(),
              SizedBox(height: 10.h),
              if (hasSearchText && adsToShow.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("لا توجد نتائج مطابقة"),
                  ),
                )
              else
                ListView.builder(
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
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(cars);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              style:
                                                  TextStyles.reguler14.copyWith(
                                                color: darkBlur,
                                              ),
                                            ),
                                            SizedBox(width: 23.w),
                                            SvgPicture.asset(locationImage),
                                            SizedBox(width: 1.w),
                                            Text(
                                              ad.region?.name ?? "الموقع",
                                              style:
                                                  TextStyles.reguler14.copyWith(
                                                color: darkBlck,
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
                                              style:
                                                  TextStyles.reguler14.copyWith(
                                                color: darkBlur,
                                              ),
                                            ),
                                            SizedBox(width: 36.w),
                                            SvgPicture.asset(dollerImage),
                                            Text(
                                              ad.price ?? "السعر",
                                              style:
                                                  TextStyles.reguler14.copyWith(
                                                color: darkBlur,
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
                                    margin: EdgeInsets.only(
                                        left: 10.w, bottom: 5.h),
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
                ),
            ],
          );
        } else {
          return const Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
        }
      },
    );
  }
}
