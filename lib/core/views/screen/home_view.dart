import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/widgets/advertisements.dart';
import 'package:arta_app/core/views/widgets/catgury_list.dart';
import 'package:arta_app/core/views/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<Map<String, String>> categ = [
    {'image': cars, 'title': 'السيارات', 'onTap': '/cars'},
    {'image': motors, 'title': 'الدراجات', 'onTap': '/motors'},
    {'image': electronic, 'title': 'الإلكترونيات', 'onTap': '/electronics'},
    {'image': home, 'title': 'المنزل', 'onTap': '/homeCtg'},
    {'image': sports, 'title': 'الرياضة', 'onTap': '/sports'},
    {'image': clothing, 'title': 'الملابس النسائية', 'onTap': '/womecn'},
    {'image': ecomiric, 'title': 'عقارات', 'onTap': '/real_estate'},
    {'image': more, 'title': 'المزيد', 'onTap': '/more'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Stack(
          children: [
            SvgPicture.asset(
              group1,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            // الاعلانات
            const Positioned(child: AdvertisementsView())
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // العنوان "الفئات"
          SliverPadding(
            padding: const EdgeInsets.only(right: 30.0, top: 10.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'الفئات',
                style:
                    TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          // شبكة العناصر
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, categ[index]['onTap']!);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            categ[index]['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categ[index]['title']!,
                          style: TextStyles.reguler14.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                childCount: categ.length,
              ),
            ),
          ),
          // شريط البحث وزر الفلتر
          const SliverToBoxAdapter(
            child: SearchBarFiltter(),
          ),
          // قائمة المنتجات
          CatguryList(
            onTap: () {
              Navigator.pushNamed(context, '/product');
            },
            color: const Color(0xff046998),
            text: 'عرض التفاصيل',
          ),
          // زر مشاهدة المزيد
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: InkWell(
                  onTap: () {
                    // Show all categories or implement logic
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff257A9E),
                            Color(0xff4F8982),
                          ]),
                    ),
                    child: Center(
                      child: Text('مشاهدة المزيد',
                          style: TextStyles.smallReguler
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
