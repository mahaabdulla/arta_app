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
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/utils/global_methods/global_methods.dart';
import '../../../../../../core/widgets/custom_dropdown_textFeild.dart';
import '../../../../../data/models/ads/ads_model.dart';
import '../../../../cubits/ads/listing_cubit.dart';
import '../../../../cubits/ads/listing_state.dart';
import '../../../../cubits/categories/categories_cubit.dart';
import 'dart:developer' as dev;
import 'package:arta_app/feature/data/models/category.dart';

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
  int? selectedSubCategoryId;

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
        controller: _scrollController,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is LoadingCategoryState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ErrorCategoryState) {
                      return Text(state.message);
                    } else if (state is SuccessCategoryState) {
                      List<String> categoryNames = state.categories
                          .map((cat) => cat.name ?? '')
                          .toList();

                      return Container(
                        width: double.infinity,
                        child: CustomDropdownTextField(
                          label: 'اختر القسم',
                          items: categoryNames,
                          onItemSelected: (value) {
                            final selected = state.categories.firstWhere(
                              (cat) => cat.name == value,
                              orElse: () => Category(id: null, name: null),
                            );
                            setState(() {
                              categoryId = selected.id;
                            });
                          },
                        ),
                      );
                    }
                    return const Text('Error');
                  },
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: BlocBuilder<RegetionCubit, RegetionState>(
                    builder: (context, state) {
                      final cubit = context.read<RegetionCubit>();

                      List<String> cities = [];
                      List<String> regions = [];
                      String? selectedCityName;
                      String? selectedRegionName;
                      bool isLoadingRegions = false;

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

                        cities = state is CitySelectedState
                            ? state.cities.map((e) => e.name ?? "").toList()
                            : cubit.cities.map((e) => e.name ?? "").toList();

                        selectedCityName = state is CitySelectedState
                            ? state.selectedCity?.name
                            : cubit.selectedCity?.name;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropdownTextField(
                            label: "المدينة",
                            items: cities,
                            initialValue: selectedCityName,
                            onItemSelected: (cityName) {
                              final city = cubit.cities.firstWhere(
                                (city) => city.name == cityName,
                                orElse: () => RegetionParent(),
                              );
                              if (city.id != null) {
                                cubit.selectCity(city);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
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
                                  setState(() {
                                    selectedRegitionId = region.id;
                                  });
                                  cubit.selectRegion(region);
                                }
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: CustomTextFormField(
                    controller: nameController,
                    label: "عنوان الاعلان",
                    hintText: "أدخل عنوان الإعلان",
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: CustomTextFormField(
                    controller: describeController,
                    label: "تفاصيل الاعلان",
                    hintText: "صف الاعلان هنا ",
                    maxLines: 5,
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: CustomTextFormField(
                    controller: statusController,
                    label: "حالة الاعلان",
                    hintText: "مثال: مستعمل نظيف",
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: CustomTextFormField(
                    controller: priceController,
                    label: "سعر الاعلان",
                    hintText: "أدخل سعر الإعلان",
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: AddImageContainer(
                    onImagesUpdated: (images, primary) {
                      selectedImages = images.whereType<File>().toList();
                      selectedPrimaryImage = primary;
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  child: BlocListener<ListingCubit, ListingState>(
                    listener: (context, state) {
                      if (state is AddedListingSuccessState) {
                        toast("تمت الإضافة بنجاح", bgColor: Colors.green);
                        Navigator.pop(context);
                      } else if (state is ErrorAddingListingState) {
                        toast(state.message, bgColor: Colors.red);
                      }
                    },
                    child: SaveButton(
                      isLoading: context.watch<ListingCubit>().state is AddingListingLoadingState,
                      onTap: () {
                        if (categoryId == null) {
                          toast("يرجى اختيار القسم أولاً", bgColor: Colors.red);
                          return;
                        }
                        toast("تمت الإضافة بنجاح", bgColor: Colors.green);
                        Navigator.pop(context);
                      },
                    ),
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

  Future<File> compressImage(File file) async {
    try {
      // قراءة الصورة
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) {
        throw Exception('فشل في قراءة الصورة');
      }

      dev.log("Original image size: ${bytes.length / 1024} KB");
      dev.log("Original dimensions: ${image.width}x${image.height}");

      // تقليل حجم الصورة بشكل أكثر عدوانية
      var resizedImage = image;
      if (image.width > 800 || image.height > 800) {
        resizedImage = img.copyResize(
          image,
          width: image.width > image.height ? 800 : null,
          height: image.height > image.width ? 800 : null,
        );
        dev.log("Resized dimensions: ${resizedImage.width}x${resizedImage.height}");
      }

      // ضغط الصورة بجودة أقل
      var quality = 70; // بدء بجودة أقل
      var compressedImage = img.encodeJpg(resizedImage, quality: quality);
      
      // إذا كان الحجم لا يزال كبيراً، نقوم بتقليل الجودة أكثر
      while (compressedImage.length > 1024 * 1.5 && quality > 20) { // 1.5MB
        quality -= 5;
        compressedImage = img.encodeJpg(resizedImage, quality: quality);
        dev.log("Trying quality: $quality, Size: ${compressedImage.length / 1024} KB");
      }
      
      // حفظ الصورة المضغوطة
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final compressedFile = File('$tempPath/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await compressedFile.writeAsBytes(compressedImage);

      dev.log("Final compressed size: ${compressedImage.length / 1024} KB");
      dev.log("Final quality: $quality");

      return compressedFile;
    } catch (e) {
      dev.log("Error compressing image: $e");
      return file;
    }
  }

  void _handleAddAd() async {
    if (nameController.text.isEmpty) {
      toast("يرجى إدخال عنوان الإعلان", bgColor: Colors.red);
      return;
    }

    if (describeController.text.isEmpty) {
      toast("يرجى إدخال وصف الإعلان", bgColor: Colors.red);
      return;
    }

    if (priceController.text.isEmpty) {
      toast("يرجى إدخال السعر", bgColor: Colors.red);
      return;
    }

    if (statusController.text.isEmpty) {
      toast("يرجى إدخال حالة الإعلان", bgColor: Colors.red);
      return;
    }

    if (categoryId == null) {
      toast("يرجى اختيار القسم", bgColor: Colors.red);
      return;
    }

    if (selectedRegitionId == null) {
      toast("يرجى اختيار المنطقة", bgColor: Colors.red);
      return;
    }

    try {
      toast("جاري معالجة الصور...", bgColor: Colors.blue);
      
      // ضغط الصور قبل الإرسال
      File? compressedPrimaryImage;
      List<File> compressedImages = [];

      if (selectedPrimaryImage != null) {
        dev.log("Compressing primary image...");
        compressedPrimaryImage = await compressImage(selectedPrimaryImage!);
        dev.log("Primary image compressed: ${compressedPrimaryImage.path}");
      }

      for (var image in selectedImages) {
        if (image != null) {
          dev.log("Compressing additional image...");
          final compressed = await compressImage(image);
          compressedImages.add(compressed);
          dev.log("Additional image compressed: ${compressed.path}");
        }
      }

      final listing = ListingModel(
        title: nameController.text,
        description: describeController.text,
        price: priceController.text,
        categoryId: categoryId,
        currencyId: 3,
        regionId: selectedRegitionId,
        primaryImage: compressedPrimaryImage?.path,
        images: compressedImages.map((file) => file.path).toList(),
        status: statusController.text,
        userId: int.tryParse(LocalStorage.getStringFromDisk(key: USERID)),
      );

      dev.log("Category ID: $categoryId");
      dev.log("Region ID: $selectedRegitionId");

      final formData = toFormData(listing);
      context.read<ListingCubit>().addListing(formData);
    } catch (e) {
      dev.log("Error in _handleAddAd: $e");
      toast("حدث خطأ أثناء إضافة الإعلان: $e", bgColor: Colors.red);
    }
  }

  FormData toFormData(ListingModel listing) {
    final formDataMap = {
      'title': listing.title,
      'description': listing.description,
      'category_id': listing.categoryId,
      'status': listing.status ?? 'جديد',
      'region_id': listing.regionId,
      'currency_id': listing.currencyId,
      'price': listing.price,
      'user_id': listing.userId,
    };

    final formData = FormData.fromMap(formDataMap);

    try {
      if (listing.primaryImage != null) {
        final file = File(listing.primaryImage!);
        if (file.existsSync()) {
          formData.files.add(MapEntry(
            'primary_image',
            MultipartFile.fromFileSync(listing.primaryImage!,
                filename: listing.primaryImage?.split('/').last),
          ));
        }
      }

      if (listing.images != null && listing.images!.isNotEmpty) {
        for (var filePath in listing.images!) {
          if (filePath != null) {
            final file = File(filePath);
            if (file.existsSync()) {
              formData.files.add(MapEntry(
                'images[]',
                MultipartFile.fromFileSync(filePath, filename: filePath.split('/').last),
              ));
            }
          }
        }
      }
    } catch (e) {
      // تجاهل أخطاء الصور والمتابعة
      print("خطأ في معالجة الصور: $e");
    }

    return formData;
  }
}
