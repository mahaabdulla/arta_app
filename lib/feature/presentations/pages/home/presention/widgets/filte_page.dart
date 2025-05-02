import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/feature/data/models/ads/ads_model.dart';
import 'package:arta_app/feature/presentations/cubits/ads/listing_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/region/region_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/views/add_advsrtismint.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<RegionCubit>().getParentRegions();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      title: "فلترة",
      showBackButton: true,
      onTap: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
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

                return DropdownWidget(
                  value: isParentValid ? currentParentName : null,
                  items: regionNames,
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
                  hint: 'المدينة',
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

                return DropdownWidget(
                  value: isChildValid ? currentChildName : null,
                  items: childNames,
                  onChanged: (String? newValue) {
                    final selectedRegion = children.firstWhere(
                      (region) => region.name == newValue,
                      orElse: () => RegionModel(id: null, name: ''),
                    );
                    setState(() {
                      selectedChild = selectedRegion;
                    });
                  },
                  hint: 'المنطقة',
                );
              },
            ),

            SizedBox(height: 32.h),

            // الأقل سعرًا
            buildPriceOption("الأقل سعرًا", "low"),

            SizedBox(height: 32.h),

            // الأعلى سعرًا
            buildPriceOption("الأعلى سعرًا", "high"),

            SizedBox(height: 32.h),

            // زر تطبيق الفلترة
            FilterApplyButton(
              onTap: () {
                // مثال: تعيين حدود السعر (يمكن تعديلها حسب الحاجة)
                double? priceLimitValue;
                if (selectedSortOrder == "low") {
                  priceLimitValue = 500;
                } else if (selectedSortOrder == "high") {
                  priceLimitValue = 1000;
                }

                context.read<ListingCubit>().filterAds(
                      city: selectedParent?.name,
                      region: selectedChild?.name,
                      priceLimit: priceLimitValue,
                      isPriceAbove: selectedSortOrder == "high",
                    );

                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceOption(String label, String value) {
    return Container(
      width: 360.w,
      height: 72.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 116, 172, 196),
            Color.fromARGB(255, 112, 164, 158)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: RadioListTile<String>(
          title: Text(
            label,
            style: TextStyles.smallReguler.copyWith(color: darkGreenContainer),
          ),
          value: value,
          groupValue: selectedSortOrder,
          onChanged: (value) {
            setState(() {
              selectedSortOrder = value;
            });
          },
        ),
      ),
    );
  }
}
