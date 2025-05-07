import 'dart:io';
import 'package:arta_app/core/constants/global_constants.dart';
import 'package:arta_app/core/utils/local_repo/local_storage.dart';
import 'package:arta_app/core/widgets/custom_text_feild.dart';
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
  // RegetionParent regetion = RegetionParent();
  int? categoryId;
  int? selectedCityId;
  int? selectedRegitionId;

  @override
  void initState() {
    categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getCategoris(isHome: false);
    regetionCubit = context.read<RegetionCubit>();
    regetionCubit.getContreis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      showBackButton: true,
      onTap: () => Navigator.pushNamed(context, '/home'),
      title: 'اضافة اعلان جديد',
      widgets: SingleChildScrollView(
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

                      if (categories.isEmpty) {
                        return const Center(
                            child: Text('مافي تصنيفات متاحة حالياً'));
                      }

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
                    List<String> regitions = [];
                    List<String> cities = [];

                    if (state is SuccessRegetionParentState) {
                      // countries = state.cities;
                      Map<String, int> cityNameToId = {
                        for (var item in state.cities)
                          if (item.name != null && item.id != null)
                            item.name!: item.id!,
                      };
                      cities = cityNameToId.keys.toList();
                    } else if (state is SuccessRegetionChildState) {
                      // countries = state.cities;
                      Map<String, int> regitiomNameToId = {
                        for (var item in state.regetions)
                          if (item.name != null && item.id != null)
                            item.name!: item.id!,
                      };
                      regitions = regitiomNameToId.keys.toList();
                      // countries = context.read<RegetionCubit>().lastCountries;
                    }

                    return Column(
                      children: [
                        if (cities.isEmpty)
                          const Center(child: Text("emity"))
                        else
                          CustomDropdownTextField(
                            label: "المدينة",
                            items: cities,
                            // cities.map((e) => e.name ?? "").toList(),
                            onItemSelected: (value) {
                              //TODO: عدلي ذا كمان بعدين
                              selectedCityId = 6;
                              //  cityNameToId[value];
                              // regitio
                              // regetion =
                              //     cities.firstWhere((e) => e.name == value);
                              //TODO: ف هذا المكان لازم نمرر الاي دي حق المنطقة
                              // selectedRegitionId =
                              context
                                  .read<RegetionCubit>()
                                  .getCities(selectedRegitionId ?? 6);
                            },
                          ),
                        const SizedBox(height: 20),
                        // if (state is LoadingRegetionChildState)
                        //   const Center(child: CircularProgressIndicator())
                        // else
                        if (cities.isNotEmpty)
                          CustomDropdownTextField(
                            label: "المنطقة",
                            items: regitions,
                            // regitions.map((e) => e.name ?? "").toList(),
                            onItemSelected: (value) {
                              //TODO: عدلي ذا بعدين
                              selectedRegitionId = 18;
                            },
                          )
                        else
                          CustomDropdownTextField(
                            label: "المنطقة",
                            items: [''],
                            hintText: "اختر البلد أولاً",
                            readOnly: true,
                            onItemSelected: (_) {},
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

                // AddImageContainer(
                //     onImagesUpdated: (images) =>
                //         setState(() => advertisementImages = images)),
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
    );
  }

  void _handleAddAd() {
    //  final FormData formDataMap = {
    //   'title': listing.title,
    //   'description': listing.description,
    //   'category_id': listing.categoryId.toString(),
    // };
    dev.log("category_id is : $categoryId");
    final listing = ListingModel(
        title: nameController.text,
        description: describeController.text,
        price: priceController.text,
        categoryId: 1,
        // categoryId,
        currencyId: 3,
        regionId: selectedRegitionId ?? 18,
        //TODO: بعدين حطي صورة افتراضية في حالة الخطأ هنا عشان النل سيفتي
        primaryImage: selectedPrimaryImage!.path,
        images: selectedImages.map((file) => file!.path).toList(),
        status: statusController.text,
        userId: int.tryParse(LocalStorage.getStringFromDisk(key: USERID))
        //  double.tryParse(priceController.text) ?? 0.0,
        // أضف باقي الحقول حسب ما هو مطلوب، مثلاً الصور، المدينة، التصنيف إلخ
        );

    context.read<ListingCubit>().addListing(toFormData(listing));
  }

  FormData toFormData(ListingModel listing) {
    final formDataMap = {
      'title': listing.title,
      'description': listing.description,
      'category_id': 3,
      // listing.categoryId,
      'status': 'جديد',
      // listing.status,
      'region_id': listing.regionId,
      'currency_id': listing.currencyId,
      'price': listing.price,
    };

    final formData = FormData.fromMap(formDataMap);

    // صورة رئيسية
    if (listing.primaryImage != null) {
      formData.files.add(MapEntry(
        'primary_image',
        MultipartFile.fromFileSync(listing.primaryImage!,
            filename: listing.primaryImage?.split('/').last),
      ));
    }

    // باقي الصور (images[])
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
