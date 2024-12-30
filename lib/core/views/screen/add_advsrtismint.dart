import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/widgets/basic_scafoold.dart';
import 'package:flutter/material.dart';

class AddAdvsrtismintView extends StatefulWidget {
  AddAdvsrtismintView({super.key});

  @override
  State<AddAdvsrtismintView> createState() => _AddAdvsrtismintViewState();
}

class _AddAdvsrtismintViewState extends State<AddAdvsrtismintView> {
  String selectedType = 'عقارات'; 
  String selectedCity = 'سيئون'; 
  String selectedPlace = 'السحيل'; 
  String selectedName = 'سيارة'; 

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      showBackButton: true,
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      title: 'اضافة اعلان جديد',
      widgets: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // القسم الرئيسي
                Text('اختر القسم الرئيسي', style: TextStyles.medium18),
                SizedBox(height: 10),
                buildCustomDropdown(
                  value: selectedType,
                  items: [
                    'عقارات',
                    'نساء',
                    'الرياضة',
                    'المنزل',
                    'السيارات',
                    'الالكترونيات',
                    'الدراجات',
                    'المزيد',
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedType = val ?? selectedType;
                    });
                  },
                ),
                SizedBox(height: 16),

                // المدينة
                Text('المدينة', style: TextStyles.medium18),
                SizedBox(height: 10),
                buildCustomDropdown(
                  value: selectedCity,
                  items: [
                    'سيئون',
                    'تريم',
                    'المكلا',
                    'الشحر',
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedCity = val ?? selectedCity;
                    });
                  },
                ),
                SizedBox(height: 16),

                // المنطقة
                Text('المنطقة', style: TextStyles.medium18),
                SizedBox(height: 10),
                buildCustomDropdown(
                  value: selectedPlace,
                  items: [
                    'السحيل',
                    'الغرف',
                    'دمون',
                    'المنصورة',
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedPlace = val ?? selectedPlace;
                    });
                  },
                ),
                SizedBox(height: 16),

                // اسم الإعلان
                Text('اسم الإعلان', style: TextStyles.medium18),
                SizedBox(height: 10),
                buildCustomDropdown(
                  value: selectedName,
                  items: [
                    'سيارة',
                    'منزل',
                    'دراجة',
                    'جهاز الكتروني',
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedName = val ?? selectedName;
                    });
                  },
                ),
                SizedBox(height: 16),

                // تفاصيل الإعلان
                Text('تفاصيل الإعلان', style: TextStyles.medium18),
                SizedBox(height: 10),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'أدخل تفاصيل الإعلان',
                    // الإطار العادي (عند عدم الضغط على الحقل)
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 116, 172, 196), 
                        width: 2,
                      ),
                    ),
                   
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 112, 164, 158), 
                        width: 2,
                      ),
                    ),
                    // الإطار عندما يكون الحقل غير مفعّل
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 180, 180, 180), // لون الإطار عند عدم التفاعل
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Text('سعر الاعلان', style: TextStyles.medium18),
                TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'أدخل تفاصيل الإعلان',
                      // الإطار العادي (عند عدم الضغط على الحقل)
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 116, 172, 196), // لون الإطار عند عدم التفاعل
                          width: 2,
                        ),
                      ),
                      // الإطار عند التركيز (عند الضغط على الحقل)
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 112, 164, 158), // لون الإطار عند الضغط
                          width: 2,
                        ),
                      ),
                      // الإطار عندما يكون الحقل غير مفعّل
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 180, 180, 180), // لون الإطار عند عدم التفاعل
                          width: 2,
                        ),
                      ),
                    )),
                    // send bottom
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء قائمة منسدلة مخصصة
  Widget buildCustomDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 116, 172, 196),
            Color.fromARGB(255, 112, 164, 158),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(2), // مسافة لحافة التدرج
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            items: items
                .map((e) => DropdownMenuItem(
                      child: Text(e, style: TextStyle(fontSize: 16)),
                      value: e,
                    ))
                .toList(),
            onChanged: onChanged,
            value: value,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
