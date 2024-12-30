import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/widgets/basic_scafoold.dart';
import 'package:flutter/material.dart';

class AddAdvertisementView extends StatefulWidget {
  const AddAdvertisementView({super.key});

  @override
  State<AddAdvertisementView> createState() => _AddAdvertisementViewState();
}

class _AddAdvertisementViewState extends State<AddAdvertisementView> {
  String selectedType = 'عقارات';
  String selectedCity = 'سيئون';
  String selectedPlace = 'السحيل';
  String selectedName = 'سيارة';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'اختر القسم الرئيسي',
                  child: _buildDropdown(
                    value: selectedType,
                    items: [
                      'عقارات',
                      'نساء',
                      'الرياضة',
                      'المنزل',
                      'السيارات',
                      'الالكترونيات',
                      'الدراجات',
                      'المزيد'
                    ],
                    onChanged: (val) =>
                        setState(() => selectedType = val ?? selectedType),
                  ),
                ),
                _buildSection(
                  title: 'المدينة',
                  child: _buildDropdown(
                    value: selectedCity,
                    items: ['سيئون', 'تريم', 'المكلا', 'الشحر'],
                    onChanged: (val) =>
                        setState(() => selectedCity = val ?? selectedCity),
                  ),
                ),
                _buildSection(
                  title: 'المنطقة',
                  child: _buildDropdown(
                    value: selectedPlace,
                    items: ['السحيل', 'الغرف', 'دمون', 'المنصورة'],
                    onChanged: (val) =>
                        setState(() => selectedPlace = val ?? selectedPlace),
                  ),
                ),
                _buildSection(
                  title: 'اسم الإعلان',
                  child: _buildDropdown(
                    value: selectedName,
                    items: ['سيارة', 'منزل', 'دراجة', 'جهاز الكتروني'],
                    onChanged: (val) =>
                        setState(() => selectedName = val ?? selectedName),
                  ),
                ),
                _buildSection(
                  title: 'تفاصيل الإعلان',
                  child: _buildTextField(
                    hintText: 'أدخل تفاصيل الإعلان',
                    maxLines: 5,
                  ),
                ),
                _buildSection(
                  title: 'سعر الاعلان',
                  child: _buildTextField(
                    hintText: 'أدخل تفاصيل الإعلان',
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.medium18),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: _buildBoxDecoration(),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            items: items
                .map((e) => DropdownMenuItem(
                    child: Text(e, style: const TextStyle(fontSize: 16)),
                    value: e))
                .toList(),
            onChanged: onChanged,
            value: value,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, required int maxLines}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder:
            _buildOutlineBorder(const Color.fromARGB(255, 116, 172, 196)),
        focusedBorder:
            _buildOutlineBorder(const Color.fromARGB(255, 112, 164, 158)),
        disabledBorder:
            _buildOutlineBorder(const Color.fromARGB(255, 180, 180, 180)),
      ),
    );
  }

  OutlineInputBorder _buildOutlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 116, 172, 196),
          Color.fromARGB(255, 112, 164, 158)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
