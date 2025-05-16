import 'dart:io';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/widgets/custom_text_feild.dart';
import 'package:arta_app/feature/data/models/regetion/get_pernte.dart';
import 'package:arta_app/feature/presentations/cubits/categories/categories_state.dart';
import 'package:arta_app/feature/presentations/cubits/regetion/regetion_cubit.dart';
import 'package:arta_app/feature/presentations/cubits/regetion/regetion_state.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/save_ads_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/core/widgets/products_widgets/add_image_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/global_methods/global_methods.dart';
import '../../../../../../core/widgets/custom_dropdown_textFeild.dart';
import '../../../../../data/models/ads/ads_model.dart';
import '../../../../cubits/ads/listing_cubit.dart';
import '../../../../cubits/ads/listing_state.dart';
import '../../../../cubits/categories/categories_cubit.dart';
import 'dart:developer' as dev;

class AddAdvertisementView extends StatefulWidget {
  const AddAdvertisementView({Key? key}) : super(key: key);

  @override
  _AddAdvertisementViewState createState() => _AddAdvertisementViewState();
}

class _AddAdvertisementViewState extends State<AddAdvertisementView>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late CategoryCubit categoryCubit;
  late RegetionCubit regetionCubit;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController describeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  List<File?> advertisementImages = [];
  List<File?> selectedImages = [];
  File? selectedPrimaryImage;
  int? categoryId;
  int? selectedCityId;
  int? selectedRegitionId;

  final ScrollController _scrollController =
      ScrollController(); // ScrollController for scroll

  @override
  void initState() {
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategoris(isHome: false);
    regetionCubit = context.read<RegetionCubit>();
    regetionCubit.getCities();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose scroll controller when no longer needed
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      showBackButton: true,
      // onTap: () => Navigator.pushNamed(context, '/home'),
      // title: 'اضافة اعلان جديد',
      widgets: SingleChildScrollView(
        controller: _scrollController, // Add scroll controller here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is LoadingCategoryState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ErrorCategoryState) {
                      return Text(state.message);
                    } else if (state is SuccessCategoryState) {
                      Map<String, int> categoryNameToId = {
                        for (var item in state.categories)
                          if (item.name != null && item.id != null)
                            item.name!: item.id!,
                      };

                      List<String> categories = categoryNameToId.keys.toList();

                      return CustomDropdownTextField(
                        label: 'اختر القسم الرئيسي',
                        items: categories,
                        onItemSelected: (value) {
                          categoryId =
                              categoryNameToId[value]; // خزن الـ ID هنا
                        },
                      );
                    }
                    return const Text('Error');
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<RegetionCubit, RegetionState>(
                  builder: (context, state) {
                    final cubit = context.read<RegetionCubit>();

                    // استخراج القوائم من الحالة
                    List<String> cities = [];
                    List<String> regions = [];
                    String? selectedCityName;
                    String? selectedRegionName;
                    bool isLoadingRegions = false;

                    // استخراج البيانات حسب نوع الحالة
                    if (state is SuccessRegetionParentState) {
                      cities = state.cities.map((e) => e.name ?? "").toList();
                    } else if (state is CitySelectedState ||
                        state is LoadingRegetionChildState ||
                        state is SuccessRegetionChildState ||
                        state is ErrorRegetionChildState ||
                        state is RegionSelectedState) {
                      if (state is LoadingRegetionChildState) {
                        isLoadingRegions = true;
                      }

                      // استخراج المدن والمدينة المحددة
                      cities = state is CitySelectedState
                          ? state.cities.map((e) => e.name ?? "").toList()
                          : cubit.cities.map((e) => e.name ?? "").toList();

                      selectedCityName = state is CitySelectedState
                          ? state.selectedCity?.name
                          : cubit.selectedCity?.name;

                      // استخراج المناطق والمنطقة المحددة (إذا وجدت)
                      if (state is SuccessRegetionChildState ||
                          state is RegionSelectedState) {
                        regions = state is SuccessRegetionChildState
                            ? state.regions.map((e) => e.name ?? "").toList()
                            : cubit.regions.map((e) => e.name ?? "").toList();

                        if (state is RegionSelectedState) {
                          selectedRegionName = state.selectedRegion?.name;
                        }
                      }
                    }

                    return Column(
                      children: [
                        // قائمة المدن المنسدلة
                        CustomDropdownTextField(
                          label: "المدينة",
                          items: cities,
                          initialValue: selectedCityName,
                          onItemSelected: (cityName) {
                            final city = cubit.cities.firstWhere(
                              (city) => city.name == cityName,
                              orElse: () =>
                                  RegetionParent(), // أو استخدم نوع القيمة الافتراضية المناسب
                            );
                            if (city.id != null) {
                              cubit.selectCity(city);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        // قائمة المناطق المنسدلة
                        if (isLoadingRegions)
                          const Center(child: CircularProgressIndicator())
                        else
                          CustomDropdownTextField(
                            label: "المنطقة",
                            items: regions,
                            initialValue: selectedRegionName,
                            hintText: cubit.selectedCity == null
                                ? "اختر المدينة أولاً"
                                : null,
                            readOnly: cubit.selectedCity == null,
                            onItemSelected: (regionName) {
                              final region = cubit.regions.firstWhere(
                                (region) => region.name == regionName,
                                orElse: () => RegetionParent(),
                              );
                              if (region.id != null) {
                                cubit.selectRegion(region);
                              }
                            },
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: nameController,
                  label: "عنوان الاعلان",
                  hintText: "أدخل عنوان الإعلان",
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: describeController,
                  label: "تفاصيل الاعلان",
                  hintText: "صف الاعلان هنا ",
                  maxLines: 5,
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: statusController,
                  label: "حالة الاعلان",
                  hintText: "مثال: مستعمل نظيف",
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: priceController,
                  label: "سعر الاعلان",
                  hintText: "أدخل سعر الإعلان",
                ),
                SizedBox(height: 20.h),
                AddImageContainer(
                  onImagesUpdated: (images, primary) {
                    selectedImages =
                        images.whereType<File>().toList(); // حذف null
                    selectedPrimaryImage = primary;
                  },
                ),
                BlocListener<ListingCubit, ListingState>(
                  listener: (context, state) {
                    if (state is AddedListingSuccessState) {
                      toast("تمت الإضافة بنجاح", bgColor: Colors.green);
                      Navigator.pop(context); // ترجع المستخدم مثلاً بعد الإضافة
                    } else if (state is ErrorAddingListingState) {
                      toast(state.message, bgColor: Colors.red);
                    }
                  },
                  child: SaveButton(
                    isLoading: context.watch<ListingCubit>().state
                        is AddingListingLoadingState,
                    onTap: _handleAddAd,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      scrollController: _scrollController, // Add scrollController here
      isScrolled: true, // Set to true to track scroll state
    );
  }

  void _handleAddAd() {
    dev.log("category_id is : $categoryId");
    final listing = ListingModel(
      title: nameController.text,
      description: describeController.text,
      price: priceController.text,
      categoryId: categoryId,
      currencyId: 3,
      regionId: selectedRegitionId ?? 18,
      primaryImage: selectedPrimaryImage!.path,
      images: selectedImages.map((file) => file!.path).toList(),
      status: statusController.text,
      userId: int.tryParse(LocalStorage.getStringFromDisk(key: USERID)),
    );

    context.read<ListingCubit>().addListing(toFormData(listing));
  }

  FormData toFormData(ListingModel listing) {
    final formDataMap = {
      'title': listing.title,
      'description': listing.description,
      'category_id': 3,
      'status': 'جديد',
      'region_id': listing.regionId,
      'currency_id': listing.currencyId,
      'price': listing.price,
    };

    final formData = FormData.fromMap(formDataMap);

    if (listing.primaryImage != null) {
      formData.files.add(MapEntry(
        'primary_image',
        MultipartFile.fromFileSync(listing.primaryImage!,
            filename: listing.primaryImage?.split('/').last),
      ));
    }

    for (var file in listing.images!) {
      if (file != null) {
        formData.files.add(MapEntry(
          'images[]',
          MultipartFile.fromFileSync(file, filename: file.split('/').last),
        ));
      }
    }

    return formData;
  }
}
