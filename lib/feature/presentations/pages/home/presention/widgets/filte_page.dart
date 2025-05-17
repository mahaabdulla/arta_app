import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/ctg_dropdaon_bottun.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/filtter_applay_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RegionModel? selectedParent;
  RegionModel? selectedChild;
  String? selectedSortOrder;
  RangeValues _priceRange = const RangeValues(0, 1000000);

  // ScrollController
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false; // Track scroll position

  @override
  void initState() {
    super.initState();
    context.read<RegionCubit>().getParentRegions();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 50) {
        setState(() {
          isScrolled = true;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      scrollController: _scrollController, // Pass the scrollController here
      isScrolled: isScrolled, // Pass the isScrolled flag here
      header: null, // If you want to add a header, you can do so here
      showBackButton: true, // Set to true if you want the back button visible
      widgets: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // المدينة
            BlocBuilder<RegionCubit, RegionState>(
              builder: (context, state) {
                List<RegionModel> regions = [];
                if (state is ParentRegionsLoaded) {
                  regions = state.regions;
                }

                final regionNames = regions.map((e) => e.name ?? '').toList();
                final currentParentName = selectedParent?.name;
                final isParentValid = regionNames.contains(currentParentName);

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: isParentValid ? currentParentName : null,
                      hint: Text('اختر المدينة', style: TextStyles.reguler14),
                      items: regionNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        final selectedRegion = regions.firstWhere(
                          (region) => region.name == newValue,
                          orElse: () => RegionModel(id: null, name: ''),
                        );
                        setState(() {
                          selectedParent = selectedRegion;
                          selectedChild = null;
                        });
                        if (selectedRegion.id != null) {
                          context
                              .read<RegionCubit>()
                              .getChildRegions(selectedRegion.id!);
                        }
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32.h),

            // المنطقة
            BlocBuilder<RegionCubit, RegionState>(
              builder: (context, state) {
                List<RegionModel> children = [];
                if (state is ChildRegionsLoaded) {
                  children = state.childRegions;
                }

                final childNames = children.map((e) => e.name ?? '').toList();
                final currentChildName = selectedChild?.name;
                final isChildValid = childNames.contains(currentChildName);

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: isChildValid ? currentChildName : null,
                      hint: Text('اختر المنطقة', style: TextStyles.reguler14),
                      items: childNames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        final selectedRegion = children.firstWhere(
                          (region) => region.name == newValue,
                          orElse: () => RegionModel(id: null, name: ''),
                        );
                        setState(() {
                          selectedChild = selectedRegion;
                        });
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32.h),

            // نطاق السعر
            Text('نطاق السعر', style: TextStyles.reguler14.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000000,
              divisions: 100,
              labels: RangeLabels(
                '${_priceRange.start.round()} ريال',
                '${_priceRange.end.round()} ريال',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_priceRange.start.round()} ريال'),
                  Text('${_priceRange.end.round()} ريال'),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // ترتيب حسب السعر
            Text('ترتيب حسب السعر', style: TextStyles.reguler14.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedSortOrder,
                  hint: Text('اختر الترتيب', style: TextStyles.reguler14),
                  items: [
                    'السعر: من الأقل للأعلى',
                    'السعر: من الأعلى للأقل',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSortOrder = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // زر تطبيق الفلترة
            FilterApplyButton(
              onTap: () {
                // تطبيق الفلترة
                context.read<ListingCubit>().filterAds(
                      city: selectedParent?.name,
                      region: selectedChild?.name,
                      priceLimit: _priceRange.end,
                      isPriceAbove: selectedSortOrder == 'السعر: من الأعلى للأقل',
                    );

                // العودة إلى صفحة الهوم وتحديث البيانات
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
