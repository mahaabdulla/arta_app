import 'dart:io';
import 'package:arta_app/feature/data/models/ads/region.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/add_ads_textfield.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/save_ads_button.dart';
import 'package:arta_app/feature/presentations/pages/ads/view_model/ads_vm.dart';
import 'package:arta_app/feature/presentations/pages/ads/view_model/region_vm.dart';
import 'package:arta_app/feature/presentations/pages/categorys/data/categury_model.dart';
import 'package:arta_app/feature/presentations/pages/categorys/presintion/view_model/catagury_vm.dart';
import 'package:flutter/material.dart';
import 'package:arta_app/core/widgets/basic_scafoold.dart';
import 'package:arta_app/core/widgets/products_widgets/add_image_container.dart';

class AddAdvertisementView extends StatefulWidget {
  const AddAdvertisementView({super.key});

  @override
  State<AddAdvertisementView> createState() => _AddAdvertisementViewState();
}

class _AddAdvertisementViewState extends State<AddAdvertisementView> {
  final regionVM = RegionVM();
  final categoryVM = CateguryVM();
  final adsVM = AdvertisementVM();

  String selectedCategory = '';
  String selectedParentRegion = '';
  String selectedChildRegion = '';
  String selectedCondition = 'مستخدم';

  List<Category> categories = []; // Updated to List<Category>
  List<Region> parentRegions = []; // Updated to List<Region>
  List<Region> childRegions = []; // Updated to List<Region>
  List<File?> advertisementImages = [];

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchCategories();
    await _fetchParentRegions();
  }

  Future<void> _fetchCategories() async {
    final fetchedCategories = await categoryVM.getCtgParent();
    setState(() {
      categories = fetchedCategories;
      if (categories.isNotEmpty)
        selectedCategory = categories.first.name!; // Access with .name
    });
  }

  Future<void> _fetchParentRegions() async {
    final fetchedParentRegions = await regionVM.getParentRegions();
    setState(() {
      // Map dynamic data to List<Region>
      parentRegions = fetchedParentRegions
          .map<Region>((regionJson) => Region.fromJson(regionJson))
          .toList();

      if (parentRegions.isNotEmpty) {
        selectedParentRegion =
            parentRegions.first.name ?? ''; // Access with .name
        _fetchChildRegions(parentRegions.first.id ?? 0); // Access with .id
      }
    });
  }

  Future<void> _fetchChildRegions(int parentId) async {
    final fetchedChildRegions = await regionVM.getChildRegions(parentId);
    setState(() {
      // Map dynamic data to List<Region>
      childRegions = fetchedChildRegions
          .map<Region>((regionJson) => Region.fromJson(regionJson))
          .toList();

      selectedChildRegion = childRegions.isNotEmpty
          ? childRegions.first.name ?? ''
          : ''; // Access with .name
    });
  }

  void _saveAdvertisement() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final priceText = priceController.text.trim();

    if (!_validateFields(title, description, priceText)) return;

    try {
      final selectedCategoryId = categories
          .firstWhere((cat) => cat.name == selectedCategory)
          .id; // Access with .id
      final selectedParentRegionId = parentRegions
          .firstWhere((region) => region.name == selectedParentRegion)
          .id; // Access with .id
      final selectedChildRegionId = childRegions
          .firstWhere((region) => region.name == selectedChildRegion)
          .id; // Access with .id

      await adsVM.createAdvertisement(
        title: title,
        description: description,
        price: double.parse(priceText),
        categoryId: selectedCategoryId,
        regionId: selectedChildRegionId!,
        status: selectedCondition,
        primaryImagePath: advertisementImages.isNotEmpty
            ? advertisementImages.first!.path
            : '',
        token:
            '11|mRbs2xC2W4WjFu5B8lus1QBQTRwinCd2QGq3JIfZ38b8596f', // Replace the token
      );

      _showSnackbar('تم حفظ الإعلان بنجاح');
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('the error is : $e');
      _showSnackbar('حدث خطأ أثناء الحفظ: $e');
    }
  }

  bool _validateFields(String title, String description, String priceText) {
    if (title.isEmpty) return _showValidationError('يرجى إدخال عنوان الإعلان');
    if (description.isEmpty)
      return _showValidationError('يرجى إدخال تفاصيل الإعلان');
    if (priceText.isEmpty || double.tryParse(priceText) == null) {
      return _showValidationError('يرجى إدخال سعر صالح');
    }
    if (selectedCategory.isEmpty)
      return _showValidationError('يرجى اختيار القسم الرئيسي');
    if (selectedParentRegion.isEmpty)
      return _showValidationError('يرجى اختيار المنطقة الرئيسية');
    if (selectedChildRegion.isEmpty)
      return _showValidationError('يرجى اختيار المنطقة الفرعية');
    return true;
  }

  bool _showValidationError(String message) {
    _showSnackbar(message);
    return false;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      showBackButton: true,
      onTap: () => Navigator.pushNamed(context, '/home'),
      title: 'اضافة اعلان جديد',
      widgets: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SectionWidget(
                  title: 'اختر القسم الرئيسي',
                  child: DropdownWidget(
                    value: selectedCategory,
                    items: categories
                        .map((cat) => cat.name!)
                        .toList(), // Access with .name
                    onChanged: (val) =>
                        setState(() => selectedCategory = val ?? ''),
                  ),
                ),
                SectionWidget(
                  title: 'اختر المنطقة الرئيسية',
                  child: DropdownWidget(
                    value: selectedParentRegion,
                    items: parentRegions
                        .map((region) => region.name!)
                        .toList(), // Access with .name
                    onChanged: (val) {
                      setState(() => selectedParentRegion = val ?? '');
                      _fetchChildRegions(parentRegions
                          .firstWhere((region) => region.name == val)
                          .id!); // Access with .id
                    },
                  ),
                ),
                SectionWidget(
                  title: 'اختر المنطقة الفرعية',
                  child: DropdownWidget(
                    value: selectedChildRegion,
                    items: childRegions
                        .map((region) => region.name!)
                        .toList(), // Access with .name
                    onChanged: (val) =>
                        setState(() => selectedChildRegion = val ?? ''),
                  ),
                ),
                SectionWidget(
                  title: 'اختر الحالة',
                  child: DropdownWidget(
                    value: selectedCondition,
                    items: ['جديد', 'شبه جديد', 'مستخدم'],
                    onChanged: (val) =>
                        setState(() => selectedCondition = val ?? ''),
                  ),
                ),
                SectionWidget(
                  title: 'عنوان الإعلان',
                  child: AdsTextFieldWidget(
                      controller: titleController,
                      hintText: 'أدخل اسم الإعلان',
                      maxLines: 2),
                ),
                SectionWidget(
                  title: 'تفاصيل الإعلان',
                  child: AdsTextFieldWidget(
                      controller: descriptionController,
                      hintText: 'أدخل تفاصيل الإعلان',
                      maxLines: 5),
                ),
                SectionWidget(
                  title: 'سعر الإعلان',
                  child: AdsTextFieldWidget(
                      controller: priceController,
                      hintText: 'أدخل سعر الإعلان',
                      maxLines: 1),
                ),
                AddImageContainer(
                    onImagesUpdated: (images) =>
                        setState(() => advertisementImages = images)),
                SaveButton(onTap: _saveAdvertisement),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionWidget({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hint;

  const DropdownWidget({
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF74ACC4), Color(0xFF70A49E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: items.contains(value) ? value : null,
            hint: (value == null && hint != null) ? Text(hint!) : null,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 16)),
                    ))
                .toList(),
            onChanged: onChanged,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
